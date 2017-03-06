//
//  LXPlayMusicController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXPlayMusicController.h"
#import "LXSong.h"
#import "LXBlurViewTool.h"
#import <AVFoundation/AVFoundation.h>
#import "LXPlayerMusicTool.h"
#import "LXMusicOperationView.h"
#import "LXMusicTool.h"
#import "LXScrollerLable.h"
#import "LXLRCTableView.h"
#import "LXGetLRCData.h"
#import "LXImageContentView.h"
#import "LXHorizontalButton.h"
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import "LXDownLoadSong.h"
@interface LXPlayMusicController ()<LXmusicOperarionDelegate,LXPlayerMusicToolDelegate,LXImageContentViewDelegate,LXLRCTableViewDelegate>
@property (nonatomic,strong)LXImageContentView *ImageContentView;
@property (nonatomic,strong)LXMusicOperationView *operationView;
@property (nonatomic,copy)NSString *playTime;
@property (nonatomic,copy)NSString *totalTime;
@property (nonatomic,assign)CGFloat sliderValue;
@property (nonatomic,strong)LXScrollerLable *scrollerLb;
@property (nonatomic,strong)LXLRCTableView  *lrcTable;
@property (nonatomic,strong)LXPlayerMusicTool *playMusicTool ;
@property (nonatomic,strong)UILabel *currentLb;
@property (nonatomic,strong)UILabel *totalLb;
@property (nonatomic,strong)UIProgressView *progressView;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong)UIView *sliderAndProgressView;

@end
NSString *const addDownloadSongProgress = @"addDownloadSongProgress";
@implementation LXPlayMusicController
- (instancetype)init
{
    self = [super init];
    if (self) {
              _playMusicTool = [LXPlayerMusicTool shareMusicPlay];
              _playMusicTool.delegate = self;
    }
    return self;
}
-(void)setupSliderAndProgress{
    _sliderAndProgressView = [[UIView alloc] init];
    [self.view addSubview:_sliderAndProgressView];
    [_sliderAndProgressView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(_operationView.top);
        make.top.equalTo(_ImageContentView.bottom);
    }];
    _slider = [[UISlider alloc]init];
    _slider.minimumTrackTintColor = MainColor;
    _slider.maximumTrackTintColor  =[UIColor clearColor];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_sliderAndProgressView addSubview:_slider];
    [_slider makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.right.equalTo(-50);
        make.top.equalTo(_sliderAndProgressView.top);
        make.bottom.equalTo(_sliderAndProgressView.bottom);
    }];
    _progressView = [[UIProgressView alloc]init];
    _progressView.tintColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    _progressView.trackTintColor = [UIColor darkGrayColor];
    [_sliderAndProgressView insertSubview:_progressView belowSubview:_slider];
  
    _currentLb = [[UILabel alloc]init];
    _currentLb.textColor = [UIColor whiteColor];
    _currentLb.font = [UIFont systemFontOfSize:14.0];
    _currentLb.text = @"00:00";
    [_sliderAndProgressView addSubview:_currentLb];
    _totalLb = [[UILabel alloc]init];
    _totalLb.textColor = [UIColor whiteColor];
    _totalLb.font = [UIFont systemFontOfSize:14.0];
    _totalLb.text = @"00:00";
    [_sliderAndProgressView addSubview:_totalLb];
    [_progressView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.right.equalTo(-50);
        make.height.equalTo(2);
        make.centerY.equalTo(_slider).offset(0.8);
    }];
    [_slider makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.right.equalTo(-50);
        make.height.equalTo(3);
        make.centerY.equalTo(_sliderAndProgressView.centerY);
    }];
    [_currentLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.right.equalTo(_progressView.left);
        make.height.equalTo(_sliderAndProgressView.height);
        make.top.equalTo(_sliderAndProgressView.top);
    }];
    [_totalLb makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-5);
        make.left.equalTo(_progressView.right);
        make.height.equalTo(_sliderAndProgressView.height);
        make.top.equalTo(_sliderAndProgressView.top);
    }];

}
-(void)requestSongData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager  manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"application/javascript",nil];
    [manager GET:LXSONGURL parameters:@{@"songIds":_song.song_id} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *tempArray = responseObject[@"data"][@"songList"];
        NSDictionary *tempdic = tempArray[0];
        self.song = [LXSong mj_objectWithKeyValues:tempdic];
        self.scrollerLb.lableText = self.song.songName;
        [_playMusicTool preparePlayMusicWithURLStr:_song];
         _playMusicTool.playingMusic = self.song;
        [self configNowPlayingCenter];
        _ImageContentView.song = self.song;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:31/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
    //加高斯模糊
    [self setUpBlurView];
    //设置导航栏标题
    [self setupSCrollerLb];
    //设置中间的内容
    [self setUpContent];
    //歌曲的操作
    [self setupOperationView];
    [self setupSliderAndProgress];
    //请求数据
    [self requestSongData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadLRCTable:) name:@"loadLRC" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开始接受远程控制
    [[UIApplication  sharedApplication]beginReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication]endReceivingRemoteControlEvents];
    [self canBecomeFirstResponder];
}
-(BOOL)canResignFirstResponder{
    return YES;
}

-(void)reloadLRCTable:(NSNotification *)noticy{
    NSArray *array = (NSArray *)(noticy.object);
    self.lrcTable.lrcArray = array;
    NSLog(@"--------啊啊啊啊啊啊啊啊啊 ----------%@",array);
    NSLog(@"0---------bbbbbbbbbb%@",self.lrcTable);
}
-(void)setUpBlurView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    imageView.userInteractionEnabled = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.song.pic_big]placeholderImage:[UIImage imageNamed:nil]];
    [LXBlurViewTool blurView:imageView :UIBarStyleBlack];
    [self.view addSubview:imageView];
}
-(void)getCacheProgress:(CGFloat)cacheProgress{
    self.progressView.progress = cacheProgress;
}
-(void)setupSCrollerLb{
    self.scrollerLb  = [[LXScrollerLable alloc]initWithFrame:CGRectMake(70, 20, ViewWidth-140, 44)];
    self.scrollerLb.lableText = self.song.title;
    [self.view addSubview:_scrollerLb];
}
-(void)sliderValueChanged:(UISlider *)sender{

    LXPlayerMusicTool *tool = [LXPlayerMusicTool shareMusicPlay];
    [tool seekToTimeWithValue:sender.value];
//    [tool removeCurrentTimer];
}
//-(void)sliderEnd:(UISlider*)sender{
//    NSLog(@"滑动结束");
//    LXPlayerMusicTool *tool = [LXPlayerMusicTool shareMusicPlay];
//    [tool seekToTimeWithValue:sender.value];
//}
-(void)setupOperationView{
    _operationView = [[LXMusicOperationView alloc]init];
    _operationView.delegate = self;
    [self.view addSubview:_operationView];
    [_operationView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(60);
        make.bottom.equalTo(self.view.bottom).offset(-10);
    }];

}
-(void)setUpContent{
    _ImageContentView = [[LXImageContentView alloc]initWithFrame:CGRectMake(0, 60, ViewWidth  ,ViewHeight -64-80-10)];
    _ImageContentView.song = self.song;
    _ImageContentView.delegate = self;
    [self.view addSubview:_ImageContentView];
}
#pragma mark LXImageContentViewDelegate
-(void)LXImageContentViewTouchImage{
    self.ImageContentView .alpha = 0;
//    self.ImageContentView.userInteractionEnabled = YES;
//    self.ImageContentView = nil;
    LXLRCTableView *lrcT = [[LXLRCTableView alloc]initWithFrame:CGRectMake(40,64, mainScreenWidth-80,mainScreenHeight-64-90)];
    lrcT.backgroundColor = [UIColor clearColor];
    lrcT.delegate = self;
    lrcT.alpha = 0;
    [self.view addSubview:lrcT];
    [UIView animateWithDuration:1 animations:^{
        lrcT.alpha =0.5;
    }];
    LXGetLRCData   *data = [[LXGetLRCData alloc]init];
    [data   getLRCarray:self.song :^(NSArray *lrcArray) {
        lrcT.lrcArray  = lrcArray;
    }];
    self.lrcTable = lrcT;
}
#pragma mark - LXLRCTableViewDelegate
-(void)showImageContentView{
   [UIView animateWithDuration:2 animations:^{
       _ImageContentView.alpha =1.0;
   }];
}
-(void)LXImageContentViewClickButton:(LXHorizontalButton *)button{
//    NSLog(@"%ld",button.tag);
    if (button.tag == 1) {
        NSLog(@"下载");
        LXPlayerMusicTool *tool = [LXPlayerMusicTool shareMusicPlay];
        LXDownLoadSong *downloadSong = [[LXDownLoadSong alloc]init];
        [downloadSong downFileWithURL:tool.playingMusic.showLink];
        [[NSNotificationCenter defaultCenter]postNotificationName:addDownloadSongProgress object:tool.playingMusic];
    }
}
#pragma mark  -LXmusicOperarionDelegate
-(void)addButtonTarget:(UIButton *)sender{
    //当前播放列表
    if (sender.tag == 101) {
       
    }
    //上一曲
    else if (sender.tag == 102){
        _playMusicTool.playingMusic = _playMusicTool.playingMusic;
        LXSong *song = [_playMusicTool previousMusic];
        _song.song_id = song.song_id;
        [self requestSongData];
    }
    //播放
    else if(sender.tag == 103){
        sender.selected = !sender.selected;
        if (sender.selected) {
               [_playMusicTool preparePlayMusicWithURLStr:_song];
        }
        else{
            [_playMusicTool  pausePlayingMusic];
        }
    }
    //下一曲
    else if(sender.tag == 104){
        _playMusicTool.playingMusic = _playMusicTool.playingMusic;
        LXSong *song = [_playMusicTool nextMusic];
        _song.song_id = song.song_id;
        [self requestSongData];
       
    }
    //随机
    else if(sender.tag == 105){
        LXSong *song =[_playMusicTool previousMusic];
        [_playMusicTool preparePlayMusicWithURLStr:song];
        
    }

}
-(void)endOfPlayAction{
//    _playMusicTool.playingMusic = _playMusicTool.playingMusic;
    
    LXSong *song = [_playMusicTool nextMusic];
    _song.song_id = song.song_id;
    [self requestSongData];
}
-(void)getCurrentTime:(NSString *)currentTime Totle:(NSString *)totleTime Progress:(CGFloat)progress{
    
    self.totalTime = totleTime;
    self.playTime = currentTime;
    self.currentLb.text= currentTime;
    self.totalLb.text= totleTime;
    self.slider.value= progress;
    _lrcTable.currentTime = currentTime;

}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    LXPlayerMusicTool *tool = [LXPlayerMusicTool shareMusicPlay];
    switch (event.subtype)    {
        case UIEventSubtypeRemoteControlPlay:
            [tool preparePlayMusicWithURLStr:tool.playingMusic];
            [self configNowPlayingCenter];
            NSLog(@"远程播放");
            break;
        case UIEventSubtypeRemoteControlPause:
            [tool pausePlayingMusic];
            NSLog(@"远程暂停");
            break;
        case UIEventSubtypeRemoteControlNextTrack:{
            _playMusicTool.playingMusic = _playMusicTool.playingMusic;
            LXSong *song = [_playMusicTool nextMusic];
            _song.song_id = song.song_id;
            [self requestSongData];
            [self configNowPlayingCenter];
            NSLog(@"remote_下一首");
            break;
        }
        case UIEventSubtypeRemoteControlPreviousTrack:{
            _playMusicTool.playingMusic = _playMusicTool.playingMusic;
            LXSong *song = [_playMusicTool previousMusic];
            _song.song_id = song.song_id;
            [self requestSongData];
            [self configNowPlayingCenter];
            NSLog(@"播放上一首");
            break;
        }
        case UIEventSubtypeRemoteControlTogglePlayPause://ios6暂停
            [tool pausePlayingMusic];
            break;
        default:
            break;
    }
}
-(void)configNowPlayingCenter{
    NSLog(@"锁屏设置");
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:self.song.songName forKey:MPMediaItemPropertyTitle];
    [info setObject:self.song.artistName forKey:MPMediaItemPropertyArtist];
    [info setObject:self.currentLb.text forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [info setObject:@(1) forKey:MPNowPlayingInfoPropertyPlaybackRate];
    [info setObject:self.totalLb.text forKey:MPMediaItemPropertyPlaybackDuration];
    NSLog(@"总时间%@",self.totalTime);
//    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc]initWithImage:[UIImage imageNamed:_song.songPicRadio]];
//    [info setObject:artWork forKey:MPMediaItemPropertyArtwork];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:info];
}
@end
