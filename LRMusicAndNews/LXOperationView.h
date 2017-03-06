//
//  LXOperationView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXOperationViewDelegate <NSObject>

-(void)addMyCollection;
-(void)comment;
-(void)share;
-(void)downLoad;

@end
@interface LXOperationView : UIView
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,weak)id<LXOperationViewDelegate>delegate;
@end
