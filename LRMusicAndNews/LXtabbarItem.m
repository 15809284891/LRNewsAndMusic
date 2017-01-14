//
//  LXtabbarItem.m
//  LXMusicPlayer
//
//  Created by    karisli on 16/10/29.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXtabbarItem.h"

@implementation LXtabbarItem
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        //只需要设置一次的放置在这里
//        self.imageView.contentMode = UIViewContentModeBottom;
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self setTitleColor:[UIColor colorWithRed:205/255.0f green:89/255.0f blue:75/255.0f alpha:1.0] forState:UIControlStateSelected];
//        
//        [self setTitleColor:[UIColor colorWithRed:117/255.0f green:117/255.0f blue:117/255.0f alpha:1.0] forState:UIControlStateNormal];
//        
//    }
//    return self;
//}
//-(void)layoutSubviews{
//       self.imageView.x= 0;
//    self.imageView.y = 0;
//    self.imageView.width = 60;
//    self.titleLabel.x = self.imageView.width;
//    self.titleLabel.y = 0;
//    self.width = self.width-self.imageView.width;
//    [super layoutSubviews];
//
////    NSLog(@"---%@",NSStringFromCGRect(self.imageView.frame));
////    NSLog(@"+++%@",NSStringFromCGRect(self.titleLabel.frame));
//}
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
       
        //只需要设置一次的放置在这里
        self.imageView.contentMode = UIViewContentModeBottom;
        self.titleLabel.text  =@"***REMOVED***";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        
    }
    return self;
}


//重写该方法可以去除长按按钮时出现的高亮效果
- (void)setHighlighted:(BOOL)highlighted
{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 50;
    CGFloat imageH = 50.;
    return CGRectMake(10, -10, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{

    CGFloat titleY =0;
    CGFloat titleW = contentRect.size.width-50-20;
    CGFloat titleH = 50;
    
    return CGRectMake(60, titleY, titleW, titleH);
}


-(void)setTabbarItem:(UITabBarItem *)tabbarItem{
    _tabbarItem = tabbarItem;
    [self setTitle:self.tabbarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabbarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabbarItem.selectedImage forState:UIControlStateSelected];
}
@end
