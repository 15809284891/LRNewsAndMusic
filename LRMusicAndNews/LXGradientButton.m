//
//  LXGradientButton.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/24.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXGradientButton.h"
#define LXRed 0
#define LXGreen 0
#define LXBlue 0
@implementation LXGradientButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self setTitleColor:[UIColor colorWithRed:LXRed green:LXGreen blue:LXBlue alpha:1.0] forState:UIControlStateNormal];
    }
    return self;
}
-(void)setScale:(CGFloat)scale{
    _scale = scale;
    //设置渐变色
    CGFloat red = LXRed +(229/255.0-LXRed)*scale;
    CGFloat green = LXGreen +(11/255.0-LXGreen)*scale;
    CGFloat blue = LXBlue +(33/255.0-LXBlue)*scale;
    [self setTitleColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0] forState:UIControlStateNormal];
    //大小缩放比例
    CGFloat transformScale = 1+ scale*0.2;
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}
@end
