//
//  LXPlayerMusicTool.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/18.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class LXSong;
@protocol LXPlayerMusicToolDelegate <NSObject>
//将播放进度传递出去
-(void)getCurrentTime:(NSString *)currentTime Totle:(NSString *)totleTime Progress:(CGFloat )progress;
//播放结束，由外部结束该做什么；
-(void)endOfPlayAction;
-(void)getCacheProgress:(CGFloat)cacheProgress;
@end
@interface LXPlayerMusicTool :NSObject
@property (nonatomic,strong)LXSong *song;
@property (nonatomic,strong)LXSong *playingMusic;
@property (nonatomic,strong)NSArray *musics;
@property (nonatomic,strong)CADisplayLink *displayLink;
@property (nonatomic,weak)id<LXPlayerMusicToolDelegate >delegate;
+(LXPlayerMusicTool *)shareMusicPlay;
//停止播放
-(void)stopPlayMusicWithURLStr:(NSString *)urlstr;
//暂停播放
-(void)pausePlayingMusic;
//准备播放
-(void)preparePlayMusicWithURLStr:(NSString*)showURL;
-(void)preparePlayMusicWithFilePath:(NSString *)filePathURL;
-(LXSong *)nextMusic;
-(LXSong *)previousMusic;
//添加定时器
-(void)addCurrentTimeTimer;
-(void)updateCurrentTimer;
-(void)removeCurrentTimer;
-(void)seekToTimeWithValue:(CGFloat)value;
@end



