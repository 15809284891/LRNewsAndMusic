//
//  LXAlbum.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/27.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXAlbum : NSObject
@property (nonatomic,assign) NSInteger ai_presale_flag;
@property (nonatomic,assign) NSInteger album_id;
@property (nonatomic,assign) NSInteger all_artist_id;
@property (nonatomic,copy) NSString *all_artist_ting_uid;
@property (nonatomic,assign) NSInteger area;
@property (nonatomic,assign) NSInteger artist_id;
@property (nonatomic,assign) NSInteger artist_ting_uid;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *buy_url;
@property (nonatomic,assign) NSInteger collect_num;
@property (nonatomic,assign) NSInteger comment_num;
@property (nonatomic,copy) NSString *country;
@property (nonatomic,assign) NSInteger favorites_num;
@property (nonatomic,assign) NSInteger gender;
@property (nonatomic,copy) NSString *hot;
@property (nonatomic,copy) NSString *language;
@property (nonatomic,assign) NSInteger listen_num;
@property (nonatomic,copy) NSString *pic_big;
@property (nonatomic,copy) NSString *pic_radio;
@property (nonatomic,copy) NSString *pic_s1000;
@property (nonatomic,copy) NSString *pic_s500;
@property (nonatomic,copy) NSString *pic_small;
@property (nonatomic,copy) NSString *prodcompany;
@property (nonatomic,copy) NSString *info;
@property (nonatomic,copy) NSString *publishtime;
@property (nonatomic,assign) NSInteger recommend_num;
@property (nonatomic,copy) NSString *resource_type_ext;
@property (nonatomic,assign) NSInteger share_num;
@property (nonatomic,assign) NSInteger songs_total;
@property (nonatomic,assign) NSInteger style_id;
@property (nonatomic,copy) NSString *styles;
@property (nonatomic,copy) NSString *title;
@end
