//
//  LXTopView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXScrollerLable;
@protocol LXTopViewDelegate <NSObject>
-(void)LXTopViewButtonClick:(UIButton *)sender;
@end

@interface LXTopView : UIView
@property (nonatomic,strong)NSString *type;
@property (nonatomic,weak)id <LXTopViewDelegate>delegate;
@end
