//
//  LXPlayerMusicTool.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/18.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXPlayerMusicTool.h"
#import <AVFoundation/AVFoundation.h>
#import "LXSong.h"
#import "LXQueuePlayer.h"
#import "LXLRCTableView.h"
#import "LXGetLRCData.h"

@interface LXPlayerMusicTool ()
@property (nonatomic,assign)CGFloat cacheProgress;
@end

static NSMutableDictionary *_musicPlayers;//缓存被播放过的歌曲
static LXPlayerMusicTool *_musicPlay=nil;
static NSMutableDictionary *_cacheProgressDic;
@implementation LXPlayerMusicTool

+ (void)initialize
{
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                   error:nil];
    //会话激活
    [session setActive:YES error:nil];
}
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
//准备播放
-(void)preparePlayMusicWithURLStr:(LXSong*)song{
    
    LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
    //判断当前是否有播放的歌曲，
    if (queuePlayer.currentItem) {
        //如果当前播放的歌曲和点进来对的歌曲是同一个，那么不创建playItem,直接播放
        if ([_playingMusic.songName isEqualToString:song.songName]) {
            NSLog(@"点进来的与当前播放的是同一首歌，直接播放");
            [self beginPlayMusic];
        }
        //否则移除以前的，创建一个新的给他
        else{ 
            [queuePlayer.currentItem removeObserver:self forKeyPath:@"status"];
            [queuePlayer.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
            NSLog(@"点进来的与当前播放的不是同一首歌，移除以前的，创建一个新的给他");
            self.timer = nil;
            NSArray *array = [_playingMusic.showLink componentsSeparatedByString:@"?"];
            NSString *str = array[0];
            [_musicPlayers removeObjectForKey:str];
            [self addNewPlayerItem:song];
        }
    }
    //没有正在播放的歌曲
    else{
        NSLog(@"没有正在播放的歌曲");

        self.timer = nil;
        [self addNewPlayerItem:song];
    }
   
}
-(void)addNewPlayerItem:(LXSong *)song{
    LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
    NSArray *array = [song.showLink componentsSeparatedByString:@"?"];
    NSString *str = array[0];
    //创建异步连接，链接完成会改变status的属性
    AVPlayerItem* playItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:song.showLink]];
    [playItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [playItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    [_musicPlayers setObject:playItem forKey:str];
    [queuePlayer replaceCurrentItemWithPlayerItem:playItem];
}
//播放歌曲
-(void)beginPlayMusic{
      NSLog(@"-开始播放了");
    
    //给当前对象添加监听者，监听播放进度
    if (self.timer==nil) {
          [self addCurrentTimeTimer];
    }
    LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
    [queuePlayer play];
    //播放后专辑开始旋转
    [[NSNotificationCenter defaultCenter]postNotificationName:@"startRotating" object:nil];
    LXGetLRCData *lrcData = [[LXGetLRCData alloc]init];
    [lrcData getLRCarray:self.playingMusic :^(NSArray *lrcArray) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadLRC" object:lrcArray];
    }];
}

//获取当前播放时间
-(NSInteger)getCurrentTime{
    LXQueuePlayer *queueplayer = [LXQueuePlayer shareQueuePlayer];
    if (queueplayer.currentItem) {
        return queueplayer.currentTime.value/queueplayer.currentTime.timescale;
    }
    return 0;
}
//获取总时长
-(NSInteger)getTotleTime{
     LXQueuePlayer *queueplayer = [LXQueuePlayer shareQueuePlayer];
    CMTime totleTime = [queueplayer.currentItem duration];
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
-(void)pauseWithURLStr:(NSString *)urlstr{
    NSLog(@"暂停了");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopRotating" object:nil];
    LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
    NSArray *array = [urlstr componentsSeparatedByString:@"?"];
    NSString *str = array[0];
    AVPlayerItem *playItem = _musicPlayers[str];
    if (playItem) {
        [queuePlayer pause];
    }
}
//停止
-(void)stopPlayMusicWithURLStr:(NSString *)urlstr{
    [self removeCurrentTimer];
    LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
    if (queuePlayer.currentItem) {
        [queuePlayer.currentItem removeObserver:self forKeyPath:@"status"];
        [queuePlayer.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    }
    NSArray *array = [urlstr componentsSeparatedByString:@"?"];
    NSString *str = array[0];
    AVPlayerItem *playItem = _musicPlayers[str];
    if (playItem) {
        [_musicPlayers removeAllObjects];
        [queuePlayer removeItem:playItem];
    }
}
//跳转到某个地方
-(void)seekToTimeWithValue:(CGFloat)value{
//    NSLog(@" ----------------  %lf",value);
    NSArray *array = [self.playingMusic.showLink componentsSeparatedByString:@"?"];
    NSString *str = array[0];
    [self pauseWithURLStr:str];
    LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
//    NSLog(@"11111       %lf",value*[self getTotleTime]);
    [queuePlayer seekToTime:CMTimeMake(value*[self getTotleTime], 1)  completionHandler:^(BOOL finished) {
        if (finished == YES) {
            [self preparePlayMusicWithURLStr:_playingMusic];
        }
    }];
}
-(LXSong *)nextMusic{
    int  nextIndex ;

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
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准备播放");
                [self beginPlayMusic];
                break;

            case AVPlayerItemStatusFailed:
                NSLog(@"准备失败");
                break;

                
            default:
                break;
        }
    }
    AVPlayerItem * songItem = object;
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        NSLog(@"%lf",self.playingMusic.cacheProgress);
//        NSLog(@"%@",self.playingMusic.songName);
        if (_cacheProgressDic[self.playingMusic.songName]) {
            self.cacheProgress = [_cacheProgressDic[self.playingMusic.songName] floatValue];
//            NSLog(@"if %lf",self.cacheProgress);
        }
        else{
            LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
            AVPlayerItem  *playerItem = queuePlayer.currentItem;
            NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
            CMTime duration = playerItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            self.cacheProgress  = timeInterval /totalDuration;
        if (self.cacheProgress-1>=0.00) {
            _cacheProgressDic[self.playingMusic.songName] = @(self.cacheProgress);

        }
            //            NSLog(@"%f",_cacheProgress);
//            NSLog(@"else %lf",self.cacheProgress);/
            
        }
        [self.delegate getCacheProgress:self.cacheProgress];
    }
}


- (NSTimeInterval)availableDuration {
    LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
    AVPlayerItem  *playerItem = queuePlayer.currentItem;
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
//    NSLog(@"result  %lf",startSeconds);
    return result;
}
-(void)endAction:(NSNotification *)noticy{
    [self removeCurrentTimer];
    NSLog(@"播放结束");
    [self pauseWithURLStr:self.playingMusic.showLink];
    [self.delegate endOfPlayAction];
}
-(void)timeAction:(NSTimer *)sender{
    LXQueuePlayer *queuePlayer = [LXQueuePlayer shareQueuePlayer];
    AVPlayerItem  *playerItem = queuePlayer.currentItem;
    if ((int)queuePlayer.rate==0 ) {
        [self removeCurrentTimer];
    }
    [self.delegate getCurrentTime:[self valueToString:[self getCurrentTime]] Totle:[self valueToString:[self getTotleTime]] Progress:[self getProgress]];
}
-(void)removeCurrentTimer{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)addCurrentTimeTimer{
    //播放后,开启定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];

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
