//
//  LXScrollerLable.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/6.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXScrollerLable.h"
@interface LXScrollerLable ()
@property (nonatomic,strong)UILabel *scrollerLb;
@end
@implementation LXScrollerLable

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  initContent];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self  initContent];
          }
    return self;
}
-(void)initContent{
    _scrollerLb = [[UILabel alloc]init];
    _scrollerLb.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:18.0];
    _scrollerLb.textColor = [UIColor whiteColor];
    [_scrollerLb sizeToFit ];
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.mask = maskLayer;
    
    CAKeyframeAnimation* keyFrame = [CAKeyframeAnimation animation];
    keyFrame.keyPath = @"transform.translation.x";
    keyFrame.values = @[@(0), @(-0), @(0)];
    keyFrame.repeatCount = NSIntegerMax;
    keyFrame.duration = self.speed * self.scrollerLb.text.length;
    keyFrame.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.5 :0.5]];
    keyFrame.delegate = self;
    [self.scrollerLb.layer addAnimation:keyFrame forKey:nil];
    [self addSubview:_scrollerLb];

}
-(void)setLableText:(NSString *)lableText{
   
    _lableText  = lableText;
    self.scrollerLb.text =lableText;
      [self startAnimationIfNeeded];
}
-(void)startAnimationIfNeeded{
    [self.scrollerLb.layer removeAllAnimations];
    CGSize textSize = [self.scrollerLb.text sizeWithFont:self.scrollerLb.font];
    CGRect lframe = self.scrollerLb.frame;
    lframe.size.width = textSize.width;
    self.scrollerLb.frame = lframe;
    const float oriWidth = self.frame.size.width;
    if (textSize.width > oriWidth) {
        float offset = textSize.width - oriWidth;
        [UIView animateWithDuration:5.0
                              delay:0
                            options:UIViewAnimationOptionRepeat //动画重复的主开关
         |UIViewAnimationOptionAutoreverse //动画重复自动反向，需要和上面这个一起用
         |UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
                         animations:^{
                             self.scrollerLb.transform = CGAffineTransformMakeTranslation(-offset, 0);
                         }
                         completion:^(BOOL finished) {
                             
                         }
         ];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    _scrollerLb.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_scrollerLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(self.top);
        make.bottom.equalTo(self.bottom);
    }];
}
@end
