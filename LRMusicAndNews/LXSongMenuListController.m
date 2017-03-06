//
//  LXSongMenuListController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXSongMenuListController.h"
#import "LXSongMenuTableHeaderView.h"
#import "LXOperationView.h"
#import "LXSongMenu.h"
#import "LXSong.h"
#import "LXSongMenuListCell.h"
#import "LXOrderDetailCell.h"
#import "LXPlayerMusicTool.h"
#import "LXPlayMusicController.h"
#import "LXRightIndicater.h"
#import "LXScrollerLable.h"
#import "LXSongMenuDescripView.h"
@interface LXSongMenuListController ()<LXOperationViewDelegate,LXSongMenuTableHeaderViewDelegate>
@property (nonatomic,strong)NSMutableArray *sectionTitles;
@property (nonatomic,strong)LXOperationView *bottomView;
@property (nonatomic,strong)LXSongMenuTableHeaderView *headerView;
@property (nonatomic,strong)UIView *descriptionView;
@property (nonatomic,strong)LXSongMenuDescripView *des;
@property (nonatomic,strong)NSArray *songMenuContents;
@property (nonatomic,strong)LXRightIndicater *rightTableView;
@property (nonatomic,strong)AFHTTPSessionManager *manager;
@end
static NSString *identity = @"songMenuCell";
@implementation LXSongMenuListController
-(NSMutableArray *)sectionTitles{
    if (!_sectionTitles) {
        _sectionTitles  = [NSMutableArray array];
    }
    return _sectionTitles;
}
-(NSArray *)songMenuContents{
    if (!_songMenuContents) {
        _songMenuContents = [NSArray array];
    }
    return _songMenuContents;
}
-(NSString *)type{
    return @"歌单";
}
-(void)setUpDescriptionView{
    _descriptionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    [self.view addSubview:_descriptionView];
    _descriptionView.hidden = YES;
    _des = [[LXSongMenuDescripView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    self.des.backgroundColor = [UIColor clearColor];
    [_descriptionView addSubview:_des];
    UIButton *closeBt = [[UIButton alloc]initWithFrame:CGRectMake(ViewWidth-30-30, 30, 30, 30)];
    [closeBt setImage:[UIImage imageNamed:@"CLOSE"] forState:UIControlStateNormal];
    [closeBt addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.descriptionView addSubview:closeBt];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[LXSongMenuListCell class] forCellReuseIdentifier:identity];
    [self setUpDescriptionView];
    [self addRightView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FindSinger:) name:@"right" object:nil];
    NSArray *datas = self.groupsDic[@"datas"];
    for (int i = 0; i<datas.count; i++) {
        NSDictionary *dic= datas[i];
        NSArray *keys  = [dic allKeys];
        NSString *key = keys[0];
        [self.sectionTitles addObject:key];
    }
}
//设置指示器tableView
-(void)addRightView{
    _rightTableView = [[LXRightIndicater     alloc]initWithFrame:CGRectMake(ViewWidth-20, 60, 20, ViewHeight-60) style:UITableViewStylePlain];
    [self.view addSubview:_rightTableView];
    _rightTableView.hidden = YES;
}

-(void)setUptableHeaderView{
    //这一句使得层次关系发生变化，searchbar被挡在headerView下面
//    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, _headerView.frame.size.height)];
    _headerView = [[LXSongMenuTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, LXTableHeaderViewHeight)];
    _headerView.delegate =self;
    _headerView.songMenu = self.songMenu;
    [self.tableView setTableHeaderView:_headerView];
    self.rgbArray = [[NSUserDefaults standardUserDefaults]objectForKey:self.songMenu.listid];
    _bottomView = [[LXOperationView  alloc]init];
    _bottomView.delegate = self;
    [_headerView addSubview:_bottomView];
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(_headerView.bottom);
        make.height.equalTo(LXBottomViewHeight);
    }];

}
-(void)requestData{
    _manager = [AFHTTPSessionManager manager];
    [_manager POST:LXMUSICURL parameters:LXParams(@"method":@"baidu.ting.diy.gedanInfo",@"listid":self.listID) success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LXSongMenu *songMenu = [LXSongMenu mj_objectWithKeyValues:responseObject];
        self.songs= [LXSong mj_objectArrayWithKeyValuesArray:responseObject[@"content"]];
        [self.des initDataWithPictureUrl:songMenu.pic_300 addTitle:songMenu.title addContent:songMenu.desc];
        self.scrollerText = songMenu.title;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)showSongMenuDetail{
    self.descriptionView.hidden = NO;
       [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = _descriptionView.frame;
        frame.origin.x = 0.f;
        [_descriptionView setFrame:frame];
     
    }];
}
#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.currentOrderWay  isEqualToString:@"默认"]) {
        LXSong *song =self.songs[indexPath.row];
        LXSongMenuListCell*cell = [  LXSongMenuListCell addLXtableViewCell:tableView withIdentity:identity];
        cell.delegate = self;
        cell.num = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell.song = song;
        return cell;

    }
    //不是默认，创建带section的cell
    else{
        //第0行不用，用来显示全部播放。所以cell是nil
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        return cell;
    }
    //其他行，获取每一个section的cell
    else{
        NSArray *datas  = self.groupsDic[@"datas"];
        NSDictionary *dic = datas[indexPath.section-1];
        NSArray *keys = [dic allKeys];
        NSString*key =keys[0];
        NSArray *songs= [dic objectForKey:key];
        LXSong *song =songs[indexPath.row];
       LXOrderDetailCell*cell = [ LXOrderDetailCell addLXtableViewCell:tableView withIdentity:@"cell"];
        cell.delegate = self;
        cell.song = song;
        return cell;

    }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self.currentOrderWay isEqualToString:@"默认"]) {
        return nil;
    }
    else{
        if (section == 0) {
            return nil;
        }
        NSArray *datas  = self.groupsDic[@"datas"];
        NSDictionary *dic = datas[section-1];
        NSArray *keys = [dic allKeys];
        NSString *key =keys[0];
    return key;
    }
}
//设置section个数，要比字典多一个，因为第一个不能用，要用来放全部播放的view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //默认情况下只用返回一个，存放播放全部的view
    if ([self.currentOrderWay isEqualToString:@"默认"]) {
        return 1;
    }
    //返回分组个数+1；
     NSArray *datas  = self.groupsDic[@"datas"];
    return datas.count+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    LXPlayerMusicTool *tool = [LXPlayerMusicTool shareMusicPlay];
    tool.musics = self.songs;
    if ([self.currentOrderWay isEqualToString:@"默认"]) {
        return self.songs.count;
    }
    else{
        if (section ==0) {
            return 0;
        }
        NSArray *datas  = self.groupsDic[@"datas"];
        NSDictionary *dic = datas[section-1];
        NSArray *keys = [dic allKeys];
        NSString *key =keys[0];
        NSArray *songs = dic[key];
        return songs.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.currentOrderWay isEqualToString:@"默认"]) {
        return 60;
    }
    else{
        if (indexPath.section== 0) {
            return 0;
        }
        return 60;
    }
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.currentOrderWay isEqualToString:@"默认"]) {
         LXSong *song = self.songs[indexPath.row];
         LXPlayMusicController *playVc = [[LXPlayMusicController  alloc]init];
         playVc.song = song;
         [self.navigationController pushViewController:playVc animated:YES];
    }
    else{
        NSArray *datas  = self.groupsDic[@"datas"];
        NSDictionary *dic = datas[indexPath.section-1];
        NSArray *keys = [dic allKeys];
        NSString *key =keys[0];
        NSArray *songs = dic[key];
        LXSong *song =songs[indexPath.row];

        LXPlayMusicController *playVc = [[LXPlayMusicController  alloc]init];
        playVc.song = song;
        [self.navigationController pushViewController:playVc animated:YES];
    }
  
}
-(void)comment{
    
}
-(void)addMyCollection{
    
}
-(void)share{
    
}
-(void)downLoad{
 }

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.songs.count>10) {
//        NSLog(@"  self.sectionTitles   %@",self.sectionTitles);
        NSArray *datas = self.groupsDic[@"datas"];
        _rightTableView.titles = self.sectionTitles;
        _rightTableView.hidden = NO;
        [_rightTableView reloadData];
    }

    CGFloat contentOffsety  = scrollView.contentOffset.y;
    if (contentOffsety>60||contentOffsety<0) {
        self.scrollerLb.lableText = self.scrollerText;
//        self.tableView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentYoffset = scrollView.contentOffset.y;
        CGFloat distanceFromBottom = scrollView.contentSize.height - height;
        //当tableView到达底部以后，恢复成原来的背景颜色
        if (distanceFromBottom - contentOffsety<=0) {
            self.tableView.backgroundColor = LXBacColor;
        }
        //让section快要进入导航栏时悬浮
        if (contentOffsety>=200) {
            self.tableView.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
        }
    }
    else{
        [self.scrollerLb removeFromSuperview];
        self.scrollerLb  = nil;
    }
}
//为什么要下滑两次才会更新contentInset
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (self.tableViewContentOffsety==64) {
        
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    
    if(self.tableViewContentOffsety  == -34){
        [UIView animateWithDuration:0.1 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(34, 0, 0, 0);
            
        }];
        
        
    }
    
    _rightTableView.hidden = YES;
}
//点击指示器tableView找对应cell
-(void)FindSinger:(NSNotification *)noticy{
    int row = 0;
    NSString *str = nil;
    NSArray *datas = self.groupsDic[@"datas"];
    for (int i = 0; i<datas.count; i++) {
        NSDictionary *dic= datas[i];
        NSArray *keys  = [dic allKeys];
        NSString *key = keys[0];
        if ([key isEqualToString:noticy.object]) {
            row = i;
            break;
        }
    }
    
    [[self tableView]scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
#pragma mark - LXSongMenuTableHeaderViewDelegate
-(void)showDesDetail{
       [UIView animateWithDuration:0.3f animations:^{
      self.descriptionView.hidden = NO;
        [self.des initDataWithPictureUrl:self.songMenu.pic_300 addTitle:_songMenu.title addContent:_songMenu.desc];
    }];
    self.navigationController.navigationBarHidden = YES;
}
-(void)closeClick{
    
    [UIView animateWithDuration:0.3f animations:^{
        self.descriptionView.hidden = YES;
    }];
    self.des.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = NO;
}

-(void)showuserInfo{
    
}
-(void)dealloc{
    [self.manager.operationQueue cancelAllOperations];
}
@end
