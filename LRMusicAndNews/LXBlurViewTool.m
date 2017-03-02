//
//  LXBlurViewTool.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/26.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXBlurViewTool.h"

@implementation LXBlurViewTool
+(void)blurView:(UIImageView*)view :(UIBarStyle)style{
    UIToolbar *blurView = [[UIToolbar alloc]init];
    blurView.barStyle = style;
//    blurView.alpha = 0.5;
    blurView.userInteractionEnabled = YES;
    blurView.frame = view.frame;
    [view addSubview:blurView];
}
@end
