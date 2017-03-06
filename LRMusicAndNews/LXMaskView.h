//
//  LXMaskView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/6.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXMaskViewDelegate <NSObject>
-(void)dissmissView:(UITapGestureRecognizer *)sender;
@end
@interface LXMaskView : UIView
@property (nonatomic,weak)id<LXMaskViewDelegate>delegate;
@end
