
//
//  LXOperationSongView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/5.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXOperationSongView.h"
#import "LXHorizontalButton.h"
@interface LXOperationSongView()
@end
@implementation LXOperationSongView
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(void)setupOperationSongView{
  
    for (int i = 0; i<self.images.count; i++) {
        LXHorizontalButton *button = [[LXHorizontalButton alloc]init];
        [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger clos = self.clos;
    NSInteger rows  = self.images.count%clos;
    CGFloat width = self.width;
    CGFloat height= self.height;
    CGFloat marginX = ( self.frame.size.width-clos*width)/(clos+1);
    CGFloat mariginY= 10;
    for (int i = 0; i<self.images.count; i++) {
        NSInteger clo = i%clos;
        NSInteger row = i/clos;
        CGFloat x = marginX*(clo+1)+width*clo;
        CGFloat y = mariginY*(row +1)+height*row;
        
        LXHorizontalButton *button = self.subviews[i];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(x, y, width,height);
    }
}
-(void)buttonClick:(LXHorizontalButton *)button{
    [self.delegate LXOperationSongViewButtonClick:button];
}
@end
