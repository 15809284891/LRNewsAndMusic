//
//  LXtabbarViewController.m
//  LXMusicPlayer
//
//  Created by    karisli on 16/10/29.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXTabBarViewController.h"
#import "LXOnlineMusicController.h"
#import "SetController.h"
#import "LXNavigationController.h"
#import "LXMyMusicViewController.h"
#import "LXtabbar.h"
@interface LXTabBarViewController()<LXtabbarDelegate>
{
    UIView *_indicatorView;
}
@property (nonatomic,strong)LXtabbar *maintabBar;
@end

@implementation LXTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpmainTabBar];
    self.tabBar.barTintColor = [UIColor blackColor];
    [self addLXChildController:[[LXOnlineMusicController alloc]init] withTitle:@"在线音乐" withImageName:@"onlineMusic"] ;
     [self addLXChildController:[[LXMyMusicViewController alloc]init] withTitle:@"我的音乐" withImageName:@"myMusic"];
    [self addLXChildController:[[SetController alloc]init] withTitle:@"设置" withImageName:@"set"];
    self.delegate = self;
  
}
//移除体统自带的tabbar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl  class]]) {
            [child removeFromSuperview];
        }
    }
}
-(void)setUpmainTabBar{
    LXtabbar *maintabBar = [[LXtabbar alloc]init];
    maintabBar.delegate = self;
    maintabBar.frame = self.tabBar.bounds;
    maintabBar.backgroundColor =  [UIColor colorWithRed:62/255.0 green:62/255.0 blue:72/255.0 alpha:1.0];
    self.tabBar.translucent = YES;
    
    [self.tabBar addSubview:maintabBar];
    self.maintabBar = maintabBar;
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3.0, 60)];
    _indicatorView.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:14/255.0 alpha:1.0];
    [self.maintabBar addSubview:_indicatorView];//位置房正确


}
-(void)addLXChildController:(UIViewController *)controller withTitle:(NSString *)title withImageName:(NSString *)imageNameStr{
    controller.tabBarItem.title = title;
    controller.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageNameStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal  ];
    LXNavigationController *nav = [[LXNavigationController alloc]initWithRootViewController:controller];
    [self.maintabBar addTabBarBtWithTabBarItem:controller.tabBarItem];
    [self addChildViewController:nav];
  
}


-(void)tabBar:(LXtabbar *)tabBar didselectedButtonFrom:(long)fromBurrnTag to:(long)toButtonTag{
    self.selectedIndex = toButtonTag;
    CGRect frame = _indicatorView.frame;
    frame.origin.x =   toButtonTag*(self.view.frame.size.width/3.0);
    _indicatorView.frame = frame;

}



@end
