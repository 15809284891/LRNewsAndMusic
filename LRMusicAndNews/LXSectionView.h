//
//  LXSectionView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/28.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXSectionViewDelegate <NSObject>

-(void)sectionShowList;

@end
@interface LXSectionView : UIView
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,weak)id<LXSectionViewDelegate>delegate;
@end
