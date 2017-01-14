//
//  UIImage+LXImage.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/7.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LXImage)
-(UIImage *)circleImage;
+(UIImage *)circleImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
-(UIColor *)mostColor;
- (UIColor *)colorAtPixel:(CGPoint)point ;
@end
