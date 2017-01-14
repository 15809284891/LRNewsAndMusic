//
//  LXAlbumHeaderView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/27.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXAlbum;
@protocol LXAlbumHeaderViewDelegate <NSObject>
-(void)showartistDetail;
-(void)showDesdetail;
@end
@interface LXAlbumHeaderView : UIView
@property (nonatomic,strong)LXAlbum *album;
@property (nonatomic,weak)id<LXAlbumHeaderViewDelegate> delegate;
@end
