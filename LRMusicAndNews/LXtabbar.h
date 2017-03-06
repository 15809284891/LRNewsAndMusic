//
//  LXtabbar.h
//  LXMusicPlayer
//
//  Created by    karisli on 16/10/29.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXtabbar;
@protocol LXtabbarDelegate <NSObject>
-(void)tabBar:(LXtabbar*)tabBar didselectedButtonFrom:(long)fromBurrnTag to:(long)toButtonTag;
@end
@interface LXtabbar : UIView
-(void)addTabBarBtWithTabBarItem:(UITabBarItem *)tabBarItem;
@property(nonatomic,assign)id<LXtabbarDelegate>delegate;
@end

