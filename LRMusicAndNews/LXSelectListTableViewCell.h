//
//  LXSelectListTableViewCell.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/28.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import  "LXTableViewCell.h"

@interface LXSelectListTableViewCell : LXTableViewCell
@property (nonatomic,strong)UIButton *selectedBt;
@property (nonatomic,assign)BOOL isSelected;
//+(LXSelectListTableViewCell *)addSelectCell:(UITableView *)tableView WithIdentity:(NSString *)identity;
@end
