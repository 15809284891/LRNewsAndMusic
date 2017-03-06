//
//  LXVerticalButton.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/24.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXVerticalButton.h"

@implementation LXVerticalButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.titleLabel.textAlignment = self.textalightment;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//        self.alpha = 0.3;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];

    self.imageView.frame = CGRectMake(0, 7, 16, 16);

    
    self.titleLabel.frame = CGRectMake(16+self.dis,0, self.frame.size.width-20, self.frame.size.height);
    
    
}
@end
