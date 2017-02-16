//
//  LXOperationView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXOperationView.h"
#import "LXHorizontalButton.h"
@interface LXOperationView()
@end
@implementation LXOperationView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initContent];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initContent];
    }
    return self;
}
-(void)initContent{
    NSArray *images = @[@"addFile",@"comment",@"share",@"download"];
    for (int i = 0; i<4; i++) {
        LXHorizontalButton *button = [[LXHorizontalButton alloc]init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:images[i] ] forState:UIControlStateNormal];
        [button setTitle:@"测试" forState:UIControlStateNormal];
        [self addSubview:button];
  }
}
-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    for (int i = 0; i<self.subviews.count; i++) {
        LXHorizontalButton *button = self.subviews[i];
//        [button setTitle:titles[i] forState:UIControlStateNormal];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat marginX =( self.frame.size.width-50*4)/5.0;
    CGFloat width = 50;
    CGFloat height = 50;
    CGFloat y = (self.frame.size.height-50)/2.0;
    for (int i = 0; i<self.subviews.count; i++) {
        LXHorizontalButton *button = self.subviews[i];
        button.frame = CGRectMake(marginX*(i+1)+width*i, y, width, height);
    }

}
-(void)buttonClick:(UIButton *)sender{
    if (sender.tag == 0) {
        [self.delegate addMyCollection];
    }
    else if(sender.tag ==1){
        [self.delegate comment];
    }
    else if(sender.tag == 2){
        [self.delegate share];
    }
    else
        [self.delegate downLoad];
}
@end
