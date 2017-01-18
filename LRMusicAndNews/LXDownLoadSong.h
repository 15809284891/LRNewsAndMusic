//
//  LXDownLoadSong.h
//  LRMusicAndNews
//
//  Created by snow on 2017/1/17.
//  Copyright © 2017年 ***REMOVED***. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LXDownLoadSongDelegate <NSObject>
-(void)getDownLoadProgress:(CGFloat)progress;
@end

@interface LXDownLoadSong : NSObject
@property (nonatomic,strong)NSURLSessionDownloadTask *downLoadTask;
@property (nonatomic,weak)id<LXDownLoadSongDelegate>delegate;
-(void)downFileWithURL:(NSString *)urlStr;
-(void)pauseDownloadWithURL:(NSString *)urlStr;
-(void)deleteDownLoadWithURL:(NSString *)urlStr;
@end
