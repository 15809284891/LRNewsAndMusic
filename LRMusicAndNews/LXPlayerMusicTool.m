//
//  LXPlayerMusicTool.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/18.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXPlayerMusicTool.h"
#import <AVFoundation/AVFoundation.h>
#import "LXSong.h"
#import "LXLRCTableView.h"
#import "LXGetLRCData.h"

@interface LXPlayerMusicTool ()
@property (nonatomic,assign)CGFloat cacheProgress;
@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)AVPlayerItem *currentItem;
@end

static NSMutableDictionary *_musicPlayers;//缓存被播放过的歌曲
static LXPlayerMusicTool *_musicPlay=nil;
static NSMutableDictionary *_cacheProgressDic;
@implementation LXPlayerMusicTool


+(LXPlayerMusicTool *)shareMusicPlay{

    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _musicPlay = [[LXPlayerMusicTool alloc]init ];
            

    });
    return _musicPlay;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (_musicPlay == nil) {
            _musicPlay = [super allocWithZone:zone];
        }
    });
    return _musicPlay;
}
////自定义初始化方法
-(instancetype)init{
    __block  LXPlayerMusicTool*weakSelf = self;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if ((weakSelf = [super init])!=nil) {
            _player = [[AVPlayer alloc]init];
            _musicPlayers = [NSMutableDictionary dictionary];
            _cacheProgressDic = [NSMutableDictionary dictionary];
            //监听播放结束
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
            //监听中断
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterreption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
            
        }
    });

    self = weakSelf;
    return self;
}
//覆盖该方法主要确保当用户通过copy方法产生对象时对象的唯一性
-(id)copy{
    return self;
}
//覆盖该方法主要确保用户通过mutableCopy方法产生对象时对象的唯一性
-(id)mutableCopy{
    return self;
}
-(NSString *)getsongURL:(NSString *)songURL{
    return [songURL componentsSeparatedByString:@"?"][0];
}
//准备播放
-(void)preparePlayMusicWithURLStr:(LXSong*)song{
    NSString *showURL = song.showLink;
    //当前有正在播放的
    if (_currentItem) {
        bool a = [([self getsongURL:_playingMusic.showLink])isEqualToString:showURL]?YES:NO;
        if ([([self getsongURL:_playingMusic.showLink])isEqualToString:[self getsongURL:showURL]]) {
            [self beginPlayMusic];
        }
        
        else{
            [self removeAllObserVer];
            self.displayLink = nil;
            [self addNewPlayerItem:showURL];
    }
    }else{
        self.displayLink = nil;
        [self addNewPlayerItem:showURL];
    }
}
-(void)preparePlayMusicWithFilePath:(NSString *)filePathURL{
    NSURL *videoURL = [NSURL fileURLWithPath:filePathURL];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:asset];
    [_player replaceCurrentItemWithPlayerItem:item];
    [_player play];
}
//移除所有的监听者
-(void)removeAllObserVer{
    [self.currentItem removeObserver:self forKeyPath:@"status"];
    [self.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];

}
-(void)addNewPlayerItem:(NSString*)showURL{
    //创建异步连接，链接完成会改变status的属性
    AVPlayerItem* playItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:showURL]];
    [playItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [playItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    [playItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [playItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    self.currentItem = playItem;
    [_musicPlayers setObject:playItem forKey:[self getsongURL:showURL]];
    [_player replaceCurrentItemWithPlayerItem:playItem];
}
//播放歌曲
-(void)beginPlayMusic{
    //给当前对象添加监听者，监听播放进度
    if (self.displayLink==nil) {
          [self addCurrentTimeTimer];
    }
    [_player play];
    //播放后专辑开始旋转
    [[NSNotificationCenter defaultCenter]postNotificationName:@"startRotating" object:nil];
    LXGetLRCData *lrcData = [[LXGetLRCData alloc]init];
    [lrcData getLRCarray:self.playingMusic :^(NSArray *lrcArray) {

        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadLRC" object:lrcArray];
    }];
   
}

//获取当前播放时间
-(NSInteger)getCurrentTime{
    if (_currentItem) {
        return _player.currentTime.value/_player.currentTime.timescale;
    }
    return 0;
}
//获取总时长
-(NSInteger)getTotleTime{
    CMTime totleTime = [_currentItem duration];
    if (totleTime.timescale == 0) {
        return 1;
    }else{
        return totleTime.value/totleTime.timescale;
    }
}
//获取当前播放进度
-(CGFloat)getProgress{
    return (CGFloat)[self getCurrentTime]/(CGFloat)[self getTotleTime];
}
//将整数转换为00:00格式的字符串
-(NSString *)valueToString:(NSInteger)value{
    return [NSString stringWithFormat:@"%.2ld:%.2ld",value/60,value%60];
}
//暂停
-(void)pausePlayingMusic{
    [self removeCurrentTimer];
    [_player pause];
}
//停止
-(void)stopPlayMusicWithURLStr:(NSString *)urlstr{
    [self removeCurrentTimer];
    if (_currentItem) {
        [_currentItem removeObserver:self forKeyPath:@"status"];
        [_currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    }
    NSArray *array = [urlstr componentsSeparatedByString:@"?"];
    NSString *str = array[0];
    AVPlayerItem *playItem = _musicPlayers[str];
    if (playItem) {
        [_musicPlayers removeAllObjects];
//        [queuePlayer removeItem:playItem];
    }
}
//跳转到某个地方
-(void)seekToTimeWithValue:(CGFloat)value{
    [self pausePlayingMusic];
    // 跳转
    [self.player seekToTime:CMTimeMake(value * [self getTotleTime], 1) completionHandler:^(BOOL finished) {
        if (finished == YES) {
//            [self preparePlayMusicWithURLStr:_playingMusic.showLink];
            [self.player play];
                [self.delegate getCurrentTime:[self valueToString:[self getCurrentTime]] Totle:[self valueToString:[self getTotleTime]] Progress:[self getProgress]];
        }
    }];
}
-(LXSong *)nextMusic{
    int  nextIndex=0 ;
    if (self.playingMusic) {
        for (int i=0; i<self.musics.count; i++) {
            LXSong *sg = self.musics[i];
            if ([self.playingMusic.songName isEqualToString:sg.title]) {
                nextIndex   = i+1;
                break;
            }
        }

        if (nextIndex>=self.musics.count) {
            nextIndex = 0;
        }
    }
    return self.musics[nextIndex];
}
-(LXSong *)previousMusic{
    int previousIndex = 0;
   if (self.playingMusic) {
        for (int i=0; i<self.musics.count; i++) {
            LXSong *sg = self.musics[i];
            if ([self.playingMusic.songName isEqualToString:sg.title]) {
                previousIndex   = i-1;
                break;
            }
        }
        if (previousIndex<0) {
            previousIndex = (int)self.musics.count-1;
        }
   }

    return self.musics[previousIndex];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        switch ([[change valueForKey:@"new"]integerValue]) {
            case AVPlayerItemStatusUnknown:
                NSLog(@"不知道什么错误");
                [self pausePlayingMusic];
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准备播放");
                break;

            case AVPlayerItemStatusFailed:
                NSLog(@"准备失败");
                [self pausePlayingMusic];
                break;

                
            default:
                break;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
            CMTime duration = _currentItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            self.cacheProgress  = timeInterval /totalDuration;
            [self.delegate getCacheProgress:self.cacheProgress];
    }else if([keyPath isEqualToString:@"playbackBufferEmpty"]){
        //监听播放器在缓冲数据的状态
        NSLog(@"缓冲不足暂停了");
    }else if([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
        NSLog(@"缓冲达到可播放的程度");
        [self beginPlayMusic];
    }else{
        NSLog(@"没有检测到");
    }
}
//获取文件大小

- (double)getSizeWithFilePath:(NSString *)path{
    
    // 1.获得文件夹管理者
    
    NSFileManager *manger = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    
    BOOL dir = NO;
    
    BOOL exits = [manger fileExistsAtPath:path isDirectory:&dir];
    
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        
        NSArray *subpaths = [manger subpathsAtPath:path];
        
        int totalSize = 0;
        
        for (NSString *subpath in subpaths) {
            
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            NSLog(@"子文件路径%@",fullsubpath);
            
            BOOL dir = NO;
            
            [manger fileExistsAtPath:fullsubpath isDirectory:&dir];
            
            if (!dir) { // 子路径是个文件
                
                NSDictionary *attrs = [manger attributesOfItemAtPath:fullsubpath error:nil];
                NSLog(@"文件是%@",attrs);
                totalSize += [attrs[NSFileSize] intValue];
                
            }
            
        }
        
        return totalSize / (1024 * 1024.0);
        
    } else { // 文件
        
        NSDictionary *attrs = [manger attributesOfItemAtPath:path error:nil];
        
        return [attrs[NSFileSize] intValue]/ (1024.0 * 1024.0) ;//
        
    }
    
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [_currentItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
-(void)endAction:(NSNotification *)noticy{
    [self removeCurrentTimer];
    NSLog(@"播放结束");
    [self pausePlayingMusic];
    [self.delegate endOfPlayAction];
    
}
-(void)timeAction:(NSTimer *)sender{
    if (_player.rate-0.000<0 ) {
        [self removeCurrentTimer];
    }
    [self.delegate getCurrentTime:[self valueToString:[self getCurrentTime]] Totle:[self valueToString:[self getTotleTime]] Progress:[self getProgress]];
}
-(void)removeCurrentTimer{
    [self.displayLink invalidate];
    self.displayLink= nil;
}
-(void)addCurrentTimeTimer{
    //播放后,开启定时器
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeAction:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}
-(void)updateCurrentTimer{
    
}
    //实现接收到中断通知时的方法
    //处理中断事件
-(void)handleInterreption:(NSNotification *)sender
{
        NSLog(@"中断处理");
}
    

@end
