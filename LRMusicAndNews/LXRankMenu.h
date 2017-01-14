//
//  LXRankMenu.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/26.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXRankMenu : NSObject
/**
 *  榜单评论
 */
@property (nonatomic,copy)NSString *comment;
@property (nonatomic,copy) NSString *pic_s192;
@property (nonatomic,copy) NSString *pic_s210;
@property (nonatomic,copy) NSString *pic_s260;
@property (nonatomic,copy) NSString *pic_s444;
/**
 *  榜单内容
 */
@property (nonatomic,strong) NSArray *contents;
/**
 *  榜单名字
 */
@property (nonatomic,copy)NSString *name;
/**
 *  榜单类型
 */
@property (nonatomic,copy)NSString *type;
/**
 *  榜单web链接
 */
@property (nonatomic,copy)NSString *web_url;
/**
 *  榜单id
 */
@property(nonatomic,copy)NSString *billboard_no;
/**
 *  榜单歌曲数量
 */
@property(nonatomic,assign) NSInteger billboard_songnum;
/**
 *  最后更新日期
 */
@property (nonatomic,copy)NSString *update_date;
@end
