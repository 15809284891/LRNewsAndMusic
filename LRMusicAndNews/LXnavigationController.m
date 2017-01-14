//
//  LXnavigationController.m
//  LXMusicPlayer
//
//  Created by    karisli on 16/10/29.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXnavigationController.h"

@implementation LXnavigationController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[[UIImage alloc] init]];
 }
-(void)viewDidLoad{
    [super viewDidLoad];

}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
        if (self.childViewControllers.count>0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        CGRect frame = button.frame;
        frame.size = CGSizeMake(70, 30);
        button.frame = frame;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}
-(void)back{
    self.navigationBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0];
    [self popViewControllerAnimated:YES];
}
//- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
//    
//    return [super popViewControllerAnimated:YES];
//}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}
@end
