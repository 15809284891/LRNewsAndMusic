//
//  LXHorizontalButton.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXHorizontalButton.h"

@implementation LXHorizontalButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((self.frame.size.width-25)/2.0, 0, 25, 25);
    self.titleLabel.frame  =CGRectMake(0, 25, self.frame.size.width, self.frame.size.height-25);
}
@end
