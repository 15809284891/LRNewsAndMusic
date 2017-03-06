//
//  LXPlayMusicController.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXSong;
extern NSString *const addDownloadSongProgress;
@interface LXPlayMusicController : UIViewController
@property (nonatomic,strong)LXSong *song;
@end
