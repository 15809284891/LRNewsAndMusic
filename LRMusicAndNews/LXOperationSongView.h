//
//  LXOperationSongView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/5.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXHorizontalButton;
@protocol LXOperationSongViewDelegate <NSObject>
-(void)LXOperationSongViewButtonClick:(LXHorizontalButton *)sender;
@end
@interface LXOperationSongView : UIView
/**
 *  图片
 */
@property (nonatomic,strong)NSArray *images;
/**
 *标题
 */
@property (nonatomic,strong)NSArray *titles;
/**
 *  列数
 */
@property (nonatomic,assign)NSInteger clos;
/**
 *  每个button的尺寸
 */
@property(nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,weak)id<LXOperationSongViewDelegate>delegate;
-(void)setupOperationSongView;

@end

