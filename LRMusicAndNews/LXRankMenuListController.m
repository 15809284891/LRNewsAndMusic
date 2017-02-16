//
//  LXMusicListController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXRankMenuListController.h"
#import "LXRankMenu.h"
#import "LXRankMenuListHeaderView.h"
#import "LXSong.h"
#import "LXRankListCell.h"
@interface LXRankMenuListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)LXRankMenuListHeaderView *tableHeaderView;
@property (nonatomic,strong)NSMutableArray *defaultSongList;
@property (nonatomic,strong)NSString *tagStr;
@property (nonatomic,strong)AFHTTPSessionManager *manager;
@end
static const NSString *identity = @"musicListCell";
@implementation LXRankMenuListController
-(NSString *)type{
    return @"榜单";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tagStr = @"榜单";
    [self.tableView registerClass:[LXRankListCell class] forCellReuseIdentifier:identity];
    [SVProgressHUD showWithStatus:@"正在加载"];
   }
///初始化tableView的头部view
-(void)setUptableHeaderView{
    _tableHeaderView = [[LXRankMenuListHeaderView  alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, LXTableHeaderViewHeight)];
    _tableHeaderView.rankMenu = self.rankMenu;
    [self.tableView setTableHeaderView:_tableHeaderView];
    self.rgbArray = [[NSUserDefaults standardUserDefaults]objectForKey:self.rankMenu.type];
  
//    [self.tableHeaderView sd_setImageWithURL:[NSURL URLWithString:self.rankMenu.pic_s192] placeholderImage:[UIImage imageNamed:@"playBac"]];
}

-(void)requestData{
    _manager = [AFHTTPSessionManager manager];
    [_manager POST:LXMUSICURL parameters:LXParams(@"method":@"baidu.ting.billboard.billList",@"offset":@"0",@"size":@"196",@"type":self.rankMenu.type) success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.rankMenu =[LXRankMenu mj_objectWithKeyValues:responseObject[@"billboard"]];
        self.rankMenu.contents = [LXSong mj_objectArrayWithKeyValuesArray:responseObject[@"song_list"]];
        self.songs = self.rankMenu.contents;
          self.scrollerText = self.rankMenu.name;
        _tableHeaderView.updateTime = self.rankMenu.update_date;
        _tagStr = self.rankMenu.name;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
        LXSong *song =self.rankMenu.contents[indexPath.row];
        LXRankListCell*cell = [  LXRankListCell addLXtableViewCell:tableView withIdentity:identity];
        cell.delegate = self;
        cell.song = song;
        return cell;
}
-(void)dealloc{
    [self.manager.operationQueue cancelAllOperations];
}
@end
