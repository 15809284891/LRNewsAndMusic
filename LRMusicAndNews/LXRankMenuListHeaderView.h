//
//  LXRankMenuListHeaderView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  LXRankMenu;
@interface LXRankMenuListHeaderView : UIImageView
@property (nonatomic,strong)LXRankMenu *rankMenu;
@property (nonatomic,copy)NSString *updateTime;
@end

