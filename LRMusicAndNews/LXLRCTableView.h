//
//  LXLRCTableView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/14.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXSong;
@protocol LXLRCTableViewDelegate <NSObject>
-(void)showImageContentView;
@end

@interface LXLRCTableView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic,copy)NSString *songName;
@property (nonatomic,strong)NSArray *lrcArray;
@property (nonatomic,strong)NSString *currentTime;
@property (nonatomic,weak)id<LXLRCTableViewDelegate>delegate;
@end
