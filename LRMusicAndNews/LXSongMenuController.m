//
//  LXSongListController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXSongMenuController.h"
#import "LXSongMenu.h"
#import "sqlite3.h"
#import "LXSongMenuImageView.h"
#import "LXSongMenuListController.h"
#import "LXSongMenuCollectionViewCell.h"
@interface LXSongMenuController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    int _currentPage;
    int  _pageCounts;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *songMenus;
@property (nonatomic,strong)AFHTTPSessionManager *manager;
@end
static NSString *  const  identity = @"collectionCell";
@implementation LXSongMenuController
-(NSMutableArray *)songMenus{
    if (!_songMenus) {
        _songMenus = [NSMutableArray array];
    }
    return _songMenus;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showWithStatus:@"正在加载"];
    _currentPage = 1;
    self.view.backgroundColor = [UIColor colorWithRed:242/255.20 green:244/255.0 blue:245/255.0 alpha:1.0];    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-30-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor colorWithRed:242/255.20 green:244/255.0 blue:245/255.0 alpha:1.0];
    [_collectionView  registerClass:[LXSongMenuCollectionViewCell class] forCellWithReuseIdentifier:identity];
    [self.view addSubview:_collectionView];
    [self setUpRefresh];
 }
-(void)requestSongMenuData:(int)page{
    _manager = [AFHTTPSessionManager manager];
    [_manager POST:LXMUSICURL parameters:LXParams(@"method":@"baidu.ting.diy.gedan",@"page_no":[NSString stringWithFormat:@"%d",_currentPage],@"page_size":@"20") success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        NSInteger totalCount = [responseObject[@"total"]intValue];
        if (totalCount%20==0) {
            _pageCounts = totalCount/20;
        }
        else{
            _pageCounts = totalCount/20+1;
        }
        if (_currentPage == 1) {
              self.songMenus = [LXSongMenu mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
        }
        else{
            [self.songMenus addObjectsFromArray: [LXSongMenu mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
        }
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"888888 %@",error);
    }];

}
-(void)setUpRefresh{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.collectionView.mj_header beginRefreshing];
}
-(void)loadNewData{
    _currentPage = 1;
    [self requestSongMenuData:_currentPage];
}
-(void)loadMoreData{
    if (_currentPage == _pageCounts) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    else{
   
        _currentPage = _currentPage+1;
         [self requestSongMenuData:_currentPage];
    }
}
#pragma mark - UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXSongMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
//    for (UIView *view in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
    LXSongMenu *songMenu = self.songMenus[indexPath.row];
    NSLog(@"---------%lf",songMenu.width);
    cell.songMenu = songMenu;
    cell.contentView.backgroundColor= [UIColor colorWithRed:242/255.20 green:244/255.0 blue:245/255.0 alpha:1.0];
//    LXSongMenuImageView *imageView = [[LXSongMenuImageView alloc]init];
//    imageView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.width);
//    imageView.songmenu = songMenu;
//    [cell.contentView  addSubview:imageView];
//    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height, cell.contentView.frame.size.width, 40)];
//    lb.font = [UIFont systemFontOfSize:13.0];
//    lb.numberOfLines = 0;
//    lb.lineBreakMode = NSLineBreakByCharWrapping;
//    lb.text =songMenu.title;
//    
//    [cell.contentView addSubview:lb];
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
       self.collectionView.mj_footer.hidden = (self.songMenus.count ==0);
    NSLog(@"%ld",self.songMenus.count);
    return self.songMenus.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGSize size = CGSizeMake((ViewWidth-30)/2.0,ViewWidth/2.0+40);
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insets =UIEdgeInsetsMake(15,  5, 5,5);
    return insets;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
 
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LXSongMenu *songmMenu = self.songMenus[indexPath.row];
    LXSongMenuListController *songMenuList = [[LXSongMenuListController alloc]init];
    songMenuList.songMenu = songmMenu;
    songMenuList.listID = songmMenu.listid;
    [self.navigationController pushViewController:songMenuList animated:YES];
  }
#pragma mark - 打开数据库
-(void)dealloc{
    [self.manager.operationQueue cancelAllOperations];
}
@end
