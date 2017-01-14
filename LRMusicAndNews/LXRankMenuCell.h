//
//  LXSongRankCell.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXRankMenu;
@interface LXRankMenuCell : UITableViewCell
@property (nonatomic,strong)LXRankMenu *rankMenu;
+(LXRankMenuCell *)addRankMenuCell:(UITableView *)tableView withIdentity:(NSString *)identity;
@end
