//
//  LXMusicTool.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/4.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXSong;
@interface LXMusicTool : NSObject
@property (nonatomic,strong)NSArray *musics;
@property (nonatomic,strong)LXSong *playingMusic;
+(LXMusicTool *)shareMisicTool;
-(void)setMusics:(NSArray *)musics;

/**
 *  下一首歌曲
 */
-(LXSong *)nextMusic;
/**
 *  上一首歌曲
 */
-(LXSong *)previousMusic;
@end
