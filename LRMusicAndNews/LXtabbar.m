//
//  LXtabbar.m
//  LXMusicPlayer
//
//  Created by    karisli on 16/10/29.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXtabbar.h"
#import "LXtabbarItem.h"
@interface LXtabbar()
@property (nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic,weak)LXtabbarItem *indicatorItem;
@end
@implementation LXtabbar
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {

        
}
    return self;
}
////自定义tabbar高度
//-(void)setFrame:(CGRect)frame{
//      frame.size.height = 60;
//      [super setFrame:frame];
//}
-(void)layoutSubviews{
    [super layoutSubviews];
   
    CGFloat btWidth = self.frame.size.width/3.0;
    CGFloat btHeigh = self.frame.size.height;
    for (int i= 0; i<self.btnArray.count; i++) {
        LXtabbarItem *btn = self.btnArray[i];
        CGRect frame = btn.frame;
        frame.origin.x= i*btWidth;
        frame.size.height = btHeigh;
        frame.size.width = btWidth;
        frame.origin.y = 0;
        btn.frame = frame;
        btn.tag = i;
    }
}
-(void)addTabBarBtWithTabBarItem:(UITabBarItem *)tabBarItem{
    NSLog(@"%@",tabBarItem);
    LXtabbarItem *tabbarBt = [[LXtabbarItem alloc]init];
    tabbarBt.tabbarItem = tabBarItem;

    [tabbarBt addTarget:self action:@selector(ClickTabBarBtn:) forControlEvents:UIControlEventTouchDown];
   [self addSubview:tabbarBt];
    [self.btnArray addObject:tabbarBt];

    if (self.btnArray.count == 1) {
        [self ClickTabBarBtn:tabbarBt];
    }
}
-(void)ClickTabBarBtn:(LXtabbarItem *)sender{

    if ([self.delegate respondsToSelector:@selector(tabBar:didselectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didselectedButtonFrom:self.indicatorItem.tag   to:sender.tag];
    }
    self.indicatorItem.selected = NO;
    sender.selected = YES;
    self.indicatorItem = sender;
}
@end
