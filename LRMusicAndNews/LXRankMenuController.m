//
//  LXSongRankController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXRankMenuController.h"
#import "LXSong.h"
#import "LXRankMenuCell.h"
#import "LXRankMenuListController.h"
#import "LXDatabase.h"
#import "LXRankMenu.h"
@interface LXRankMenuController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *rankMenus;
@end
static  NSString *idenity = @"songRankCell";
@implementation LXRankMenuController
-(NSArray *)musicRankTypes{
    if (!_rankMenus) {
        _rankMenus = [NSArray array];
    }
    return _rankMenus;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    LXDatabase *database = [[LXDatabase  alloc]init];
   BOOL flag =  [database openDataBase];
    self.view.backgroundColor = LXBacColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpTableView];
    [self requestRankMenuData];
   }
/**
 *  初始化tableView
 */
-(void)setUpTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth,ViewHeight-30-64-48) style:UITableViewStylePlain];
    [_tableView registerClass:[LXRankMenuCell class] forCellReuseIdentifier:idenity];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = LXBacColor;
    [self.view addSubview:_tableView];

}
/**
 *  请求榜单数据
 */
-(void)requestRankMenuData{
    [[AFHTTPSessionManager manager] POST:LXMUSICURL parameters:LXParams(@"method":@"baidu.ting.billboard.billCategory",@"kflag":@"1") success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"2222222222222%@",responseObject);
       _rankMenus = [LXRankMenu mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
        for (int i = 0; i<_rankMenus.count; i++) {
            LXRankMenu *rankMenu = _rankMenus[i];
            NSDictionary *tempdic = ((NSArray *)(responseObject[@"content"]))[i];
            rankMenu.contents = [LXSong mj_objectArrayWithKeyValuesArray:tempdic[@"content"]];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXRankMenuCell *cell = [LXRankMenuCell    addRankMenuCell:tableView withIdentity:idenity];
    cell.rankMenu = _rankMenus[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:242/255.20 green:244/255.0 blue:245/255.0 alpha:1.0];
      return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rankMenus.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LXRankMenu *rankMenu = self.rankMenus[indexPath.row];
    LXRankMenuListController *rankMenuListVc = [[LXRankMenuListController alloc]init];
    rankMenuListVc.rankMenu = rankMenu;
    [self.navigationController pushViewController:rankMenuListVc animated:YES];

    }

@end
