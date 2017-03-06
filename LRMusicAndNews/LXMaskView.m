//
//  LXMaskView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/6.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXMaskView.h"

@implementation LXMaskView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpMaskView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpMaskView];
    }
    return self;
}
-(void)setUpMaskView{
    self.backgroundColor = [UIColor colorWithRed:0  green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];

}
-(void)dismissView:(UITapGestureRecognizer *)sender{
    [self.delegate dissmissView:sender];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    // 点击了tableViewCell，view的类名为UITableViewCellContentView，则不接收Touch点击事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
@end
