//
//  LXNewSong.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/27.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNewSong : NSObject
@property (nonatomic,assign)NSInteger album_id;
@property (nonatomic,copy)NSString * all_artist_id;
@property (nonatomic,copy)NSString * artist_id;
@property (nonatomic,copy)NSString * author;
@property (nonatomic,copy)NSString * country;
@property (nonatomic,assign)NSInteger is_exclusive;
@property (nonatomic,assign)NSInteger is_first_publish;
@property (nonatomic,assign)NSInteger is_recommend_mis;
@property (nonatomic,copy)NSString * pic_big;
@property (nonatomic,copy)NSString * pic_radio;
@property (nonatomic,copy)NSString * pic_small;
@property (nonatomic,copy)NSString * publishcompany;
@property (nonatomic,copy)NSString * songs_total;
@property (nonatomic,copy)NSString * title;
@end
