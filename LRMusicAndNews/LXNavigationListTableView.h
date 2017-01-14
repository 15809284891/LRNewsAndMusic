//
//  LXNavigationListTableView.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/28.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXOrderTableView;
@interface LXNavigationListTableView : UITableView<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic,strong) LXOrderTableView *orderTable;
@end
