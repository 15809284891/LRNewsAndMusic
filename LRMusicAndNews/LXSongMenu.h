//
//  LXSongMenu.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/22.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXSongMenu : NSObject
/**
 *  收藏次数
 */
@property (nonatomic,copy)NSString *collectnum;
/**
 *  描述
 */
@property (nonatomic,copy)NSString *desc;
/**
 *高度
 */
@property (nonatomic,assign)CGFloat height;
/**
 *  歌曲数量
 */
@property (nonatomic,copy)NSString *listenum;
@property(nonatomic,copy)NSString *tag;
/**
 *  当前歌单id            
 */
@property (nonatomic,copy)NSString *listid;
@property (nonatomic,copy)NSString *pic_300;
@property (nonatomic,copy)NSString *pic_w300;
/**
 *  歌单标题
 */
@property (nonatomic,copy)NSString *title;
/**
 *  歌单宽度
 */
@property (nonatomic,assign)CGFloat width;

@end
