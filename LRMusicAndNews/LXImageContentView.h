//
//  LXImageContentView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXHorizontalButton;
@class LXSong;
@protocol LXImageContentViewDelegate <NSObject>

-(void)LXImageContentViewClickButton:(LXHorizontalButton *)button;
-(void)LXImageContentViewTouchImage;
@end
@interface LXImageContentView : UIView
@property (nonatomic,copy)LXSong *song;
@property (nonatomic,strong)id<LXImageContentViewDelegate>delegate;
@end

