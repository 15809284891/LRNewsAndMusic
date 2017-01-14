//
//  LXTableViewController.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/6.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXHiddenNavigationBar.h"
@class LXScrollerLable;
@interface LXTableViewController : UIViewController
-(void)setUptableHeaderView;
-(void)requestData;
-(void)setUpSearchBar;
@property (nonatomic,strong)UIColor *topBacColor;
@property (nonatomic,strong)NSArray *songs;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *rgbArray;
@property (nonatomic,copy)NSString *scrollerText;
@property (nonatomic,strong)UIView *navigationBarBackView;
@property (nonatomic,strong)LXScrollerLable *scrollerLb;
@property (nonatomic,assign)CGFloat tableViewContentOffsety;
//分组后的数据字典
@property (nonatomic,strong)NSMutableDictionary *groupsDic;
@property (nonatomic,copy)NSString *currentOrderWay;
-(NSString *)type;
@end
