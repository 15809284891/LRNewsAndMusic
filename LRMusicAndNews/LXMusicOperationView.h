//
//  LXMusicOperationView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/20.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXmusicOperarionDelegate <NSObject>
@required
-(void)addButtonTarget:(UIButton *)sender;
@end
@interface LXMusicOperationView : UIView
@property (nonatomic,weak) id<LXmusicOperarionDelegate>delegate;

@end
