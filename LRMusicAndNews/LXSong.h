//
//  LXMusicRankContent.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXSong : NSObject
/**
 *  歌曲名
 */
@property (nonatomic,copy) NSString *title;
/**
 *  榜单作者
 */
@property (nonatomic,copy) NSString *author;
@property (nonatomic,assign)NSInteger album_no;
/**
 *  专辑id
 */
@property (nonatomic,copy)NSString *album_id;
/**
 *  专辑名称
 */
@property (nonatomic,copy) NSString *album_title;
@property (nonatomic,copy) NSString *all_artist_ting_uid;

/**
 *  所有比率，费用
 */
@property(nonatomic,copy)NSString *all_rate;
/**
 *  作者id
 */
@property (nonatomic,copy) NSString *artist_id;
/**
 *  音乐列表作者名
 */
@property (nonatomic,copy) NSString *artist_name;
/**
 *  专辑排名
 */
@property (nonatomic,copy) NSString *rank;
/**
 *  歌曲大图片
 */
@property (nonatomic,copy) NSString *pic_big;
/**
 *  小图片
 */
@property (nonatomic,copy) NSString *pic_small;
/**
 *  排名变化情况
 */
@property (nonatomic,copy)NSString *rank_change;
/**
 *  是否是新歌
 */
@property (nonatomic,copy)NSString *artistName;
@property (nonatomic,copy)NSString *is_new;
/**
 *  歌曲id
 */
@property (nonatomic,copy )NSString *song_id;
/**
 *  歌曲格式
 */
@property (nonatomic,copy)NSString *format;
/**
 *  歌词链接
 */
@property (nonatomic,copy) NSString *lrcLink;;
/**
 *  播放链接
 */
@property (nonatomic,copy)NSString *showLink;
/**
 *  大小
 */
@property (nonatomic,copy)NSString *size;
/**
 *  城市
 */
@property (nonatomic,copy) NSString *country;
/**
 *  歌曲名
 */

@property (nonatomic,copy)NSString *songName;
/**
 *  删除状态
 */
@property (nonatomic,assign)NSInteger del_status;
/**
 *  文件时长
 */
@property (nonatomic,assign)NSInteger file_duration;
/**
 *  歌曲封面
 */
@property (nonatomic,copy)NSString *songPicRadio;
/**
 *  播放次数
 */
@property (nonatomic,copy)NSString *time;
/**
 *  有没有mv;
 */
@property (nonatomic,assign)NSInteger has_mv;
/**
 *  have high
 */
@property (nonatomic,assign)NSInteger havehigh;
/**
 *  热度
 */
@property (nonatomic,assign)NSInteger hot;
/**
 *  是不是首发
 */
@property (nonatomic,assign)NSInteger is_first_publish;
/**
 *  韩国歌曲
 */
@property (nonatomic,assign)NSInteger korean_bb_song;
/**
 *  歌曲语言
 */
@property (nonatomic,copy) NSString *language;
/**
 *  发行时间
 */
@property (nonatomic,copy) NSString *publishtime;
@property (nonatomic,copy) NSString *ting_uid;
@property (nonatomic,assign)BOOL isSelected;
@end
