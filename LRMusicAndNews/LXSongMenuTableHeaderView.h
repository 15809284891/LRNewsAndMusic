//
//  LXSongMenuTableHeaderView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/26.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXSongMenu;
@protocol LXSongMenuTableHeaderViewDelegate <NSObject>

-(void)showuserInfo;
-(void)showDesDetail;

@end
@interface LXSongMenuTableHeaderView : UIView
@property (nonatomic,strong)LXSongMenu *songMenu;
@property (nonatomic,weak)id<LXSongMenuTableHeaderViewDelegate>delegate;
@end
