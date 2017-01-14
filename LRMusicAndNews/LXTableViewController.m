//
//  LXMusicListController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXTableViewController.h"
#import "LXTableViewCell.h"
#import "LXSong.h"
#import "LXPlayMusicController.h"
#import "LXTopView.h"
#import "LXSectionView.h"
#import "LXSelectListTableViewController.h"
#import "LXNavigationListTableView.h"
#import "LXOrderTableView.h"
#import "LXSearchViewController.h"
#import "LXScrollerLable.h"
#import "LXMusicTool.h"
#import "LXPlayerMusicTool.h"
#import "LXHorizontalButton.h"
#import "LXMaskView.h"
#import "LXOperationSongView.h"
@interface LXTableViewController ()<UITableViewDataSource,UITableViewDelegate,LXTopViewDelegate,LXSectionViewDelegate,LXTableViewCellDelegate,LXMaskViewDelegate ,LXOperationSongViewDelegate,LXTopViewDelegate>
@property (nonatomic,strong)UIButton *back;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)LXTopView *topView;
@property (nonatomic,strong)UIColor *topViewColor;
@property (nonatomic,strong)LXSectionView *sectionView;
@property (nonatomic,strong)  LXSelectListTableViewController *vc ;
@property (nonatomic,strong)LXNavigationListTableView *listTableView;
@property (nonatomic,strong)NSMutableArray *defaultSongList;
@property (nonatomic,strong)NSString *tagStr;
@property (nonatomic,strong)LXMaskView *maskView;
@property (nonatomic,strong)LXOperationSongView *operationSongView;
//记录tableView是上滑还是下滑
@property (nonatomic,assign)CGFloat oldOffset;
@property (nonatomic ,strong)NSMutableArray   *groupArray;
//中文转英文以后名字和歌曲的对应关系
@property (nonatomic,strong)NSMutableDictionary *wayAndSongDic;
@end
static const NSString *identity = @"musicListCell";
static CGFloat red;
static CGFloat green;
static CGFloat blue;
static NSIndexPath *selectedIndexPath;
@implementation LXTableViewController
-(NSString *)type{
    return nil;
}
-(NSMutableArray *)groupArray{
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray ;
}
-(NSMutableDictionary *)groupsDic{
    if (!_groupsDic) {
        _groupsDic = [NSMutableDictionary dictionary];
    }
    return _groupsDic;
}
-(LXScrollerLable *)scrollerLb{
    if (!_scrollerLb) {
        _scrollerLb = [[LXScrollerLable  alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        _scrollerLb.lableText = self.scrollerText;
        _scrollerLb.speed = 0.5;
        self.navigationItem.titleView = _scrollerLb;
    }
    return _scrollerLb;
}
-(UIView *)navigationBarBackView{
    if (!_navigationBarBackView) {
        _navigationBarBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 64)];
      [self.view addSubview:_navigationBarBackView];
    }
    return _navigationBarBackView;
}
-(void)setRgbArray:(NSArray *)rgbArray{
    _rgbArray = rgbArray;
    red = [rgbArray[0] floatValue];
    green = [rgbArray[1] floatValue];
    blue = [rgbArray[2] floatValue];
}
-(void)setSongs:(NSArray *)songs{
    _songs = songs;
    _defaultSongList = songs;
    [self.tableView reloadData];
}

-(LXMaskView *)maskView{
    if (!_maskView) {
        _maskView = [[LXMaskView  alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
        _maskView.delegate =self;
        [self.view addSubview:_maskView];
    }
    return _maskView;
}
-(LXOperationSongView *)operationSongView{
    if (!_operationSongView) {
        _operationSongView = [[LXOperationSongView alloc]initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, ViewHeight/2.0-100)];
        [self.maskView addSubview:_operationSongView];
    }
    return _operationSongView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.currentOrderWay   = @"默认";
    [self setUptableView];
    [self requestData];
    [self setUptableHeaderView];
    self.navigationBarBackView.backgroundColor =[UIColor colorWithRed:red green:green blue:blue alpha:1.0];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(order:) name:@"order" object:nil];
}
//初始化tableView
-(void)setUptableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth,ViewHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = LXBacColor;
    _tableView.delegate = self;
    _tableView .dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(34, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    self.topView = [[LXTopView alloc]initWithFrame:CGRectMake(0, 0,ViewWidth , 30)];
    self.topView.backgroundColor = [UIColor clearColor];
    self.topView.delegate = self;
    self.topView.type = self.type;
    [self.tableView addSubview:self.topView];
    self.oldOffset = -34;
}


//中文转英文
-(NSMutableString   *)tranFormChineseIntoEnglish:(NSString *)chinese{
    NSMutableString *mutableString = [NSMutableString stringWithString:chinese];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    return mutableString;
}
#pragma mark 正则表达式
-(BOOL)MatchLetter:(NSString *)str
{
    //判断是否以字母开头
    NSString *ZIMU = @"^[A-Za-z]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}

-(void)orderByWay:(NSMutableArray *)oldArray{
    NSLog(@"oldArray      %@",oldArray);
    NSMutableArray *keyArray = [NSMutableArray array];
    NSMutableArray *resault = [NSMutableArray array];
    NSMutableArray *lowerCaseArray = [NSMutableArray  array];
    for (int i = 0; i<oldArray.count; i++) {
        NSString *tt = [oldArray[i] lowercaseString];
        [lowerCaseArray addObject:tt];
    
    }
    //排序后的数组
    NSMutableArray *newArray =(NSMutableArray *) [lowerCaseArray sortedArrayUsingSelector:@selector(compare:)];
    NSString *str = [newArray[0] substringToIndex:1];
    NSMutableArray *characterArray = [NSMutableArray array];
    NSMutableArray *otherArray = [NSMutableArray array];
    NSLog(@" newArray    %@",newArray);
    for (int i =0; i<newArray.count; i++) {
          NSString *firstStr = [newArray[i] substringToIndex:1];
        BOOL isA = [self MatchLetter:firstStr];
        if (isA) {
            [characterArray addObject:newArray[i]];
        }
        else{
            [otherArray addObject:[_wayAndSongDic objectForKey: newArray[i] ]];
        }
    }
    NSLog(@"  characterArray %@",characterArray);
    NSLog(@"    otherArray%@",otherArray);
    int i = 0;
    NSMutableArray *groupArray =[NSMutableArray array];
    while (i<characterArray.count) {
        [resault addObject:[_wayAndSongDic objectForKey:characterArray[i]]];
        NSString *firstStr = [characterArray[i] substringToIndex:1];
        if ([firstStr isEqualToString:str]) {
            [groupArray addObject:[_wayAndSongDic objectForKey:characterArray[i]]];
            NSLog(@"groupArray %@",groupArray);
            NSLog(@" resault %@",resault);
            if (characterArray.count == 1) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:groupArray forKey:str];
                [keyArray addObject:dic];
                [self.groupsDic setObject:keyArray forKey:@"datas"];
                break;
            }
            
        }
     
        else {
            //定义一个额外数组保存上次数据，不然groupArray在后面的数据发生改变，字典中的也会改变
            NSMutableArray*array = [NSMutableArray array];
            [array addObjectsFromArray:groupArray];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:array forKey:str];
            [keyArray addObject:dic];
            [groupArray removeAllObjects];
            str = firstStr;
            [groupArray addObject:[_wayAndSongDic objectForKey:characterArray[i]]];
            
        }
        i++;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if (otherArray.count>0) {
          [keyArray addObject:dic];
          [dic setObject:otherArray forKey:@"#"];
    }
  
    [self.groupsDic setObject:keyArray forKey:@"datas"];
    _tagStr =@"";
    _songs= resault;
    LXPlayerMusicTool *tool = [LXPlayerMusicTool shareMusicPlay];
    tool.musics =resault;
    NSLog(@"77777777   %@",self.groupsDic);
    [self.tableView reloadData];

}
//选择排序方式
-(void)order:(NSNotification *)notticy{
    self.currentOrderWay = notticy.object;
    //默认列表
    if ([notticy.object isEqualToString:@"默认"]) {
        _tagStr = @"榜单";
        _songs = _defaultSongList;
    }
    else if ([notticy.object isEqualToString:@"按单曲名"]){
        self.wayAndSongDic= [NSMutableDictionary dictionary];
        NSMutableArray *oldArray = [NSMutableArray array];
        for (int i = 0; i<_songs.count; i++) {
            LXSong *song = _songs[i ];
            NSMutableString *mutableString =  [self tranFormChineseIntoEnglish:song.title];
            [oldArray addObject:mutableString];
            [self.wayAndSongDic setObject:song forKey:[mutableString lowercaseString]];
        }
        [self orderByWay:oldArray];
    }
    else if ([notticy.object isEqualToString:@"按专辑名"]){
        self.wayAndSongDic= [NSMutableDictionary dictionary];
        NSMutableArray *oldArray = [NSMutableArray array];
        for (int i = 0; i<_songs.count; i++) {
            LXSong *song = _songs[i ];
            NSMutableString *mutableString =  [self tranFormChineseIntoEnglish:song.album_title];
            if (song.album_title.length>0) {
                [oldArray addObject:mutableString];
                [self.wayAndSongDic setObject:song forKey:[mutableString lowercaseString]];

            }
                 }
        if (oldArray.count>0) {
               [self orderByWay:oldArray];
        }
        else{
            _songs = _defaultSongList;
            [self.tableView reloadData];
        }
    }
    else if ([notticy.object isEqualToString:@"按歌手名"]){
        self.wayAndSongDic= [NSMutableDictionary dictionary];
        NSMutableArray *oldArray = [NSMutableArray array];
        for (int i = 0; i<_songs.count; i++) {
            LXSong *song = _songs[i ];
            NSLog(@"artist_name          %@",song.album_title);
            NSMutableString *mutableString =  [self tranFormChineseIntoEnglish:song.author];
            [oldArray addObject:mutableString];
            [self.wayAndSongDic setObject:song forKey:[mutableString lowercaseString]];
        }
        NSLog(@" oldArray%@",oldArray);
        [self orderByWay:oldArray];
    }
    
    [self.listTableView.orderTable removeFromSuperview];
    self.listTableView = nil;
    [self.maskView removeFromSuperview];
    self.maskView = nil;

}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LXPlayerMusicTool *tool = [LXPlayerMusicTool shareMusicPlay];
    tool.musics = _songs;
    return _songs.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        _sectionView = [[LXSectionView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 40)];
        _sectionView.backgroundColor = LXcellLineColor;
        _sectionView.delegate = self;
        _sectionView.count =_songs.count;
        return _sectionView;

    }
    return nil;
    }
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LXSong *song = _songs[indexPath.row];
    LXPlayMusicController *playVc = [[LXPlayMusicController  alloc]init];
    playVc.song = song;
    [self.navigationController pushViewController:playVc animated:YES];
}


#pragma mark - LXTopViewDelegate
-(void)LXTopViewButtonClick:(UIButton *)sender{
    if (sender.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(sender.tag == 1){
        LXSearchViewController *serchVc = [[LXSearchViewController alloc]init];
        [self.navigationController pushViewController:serchVc animated:YES];
    }
    else if (sender.tag == 2){

        
        _listTableView  = [[LXNavigationListTableView alloc]initWithFrame:CGRectMake(ViewWidth/2.0-30, 94, ViewWidth/2.0+20,  ViewWidth/2.0-40) style:UITableViewStylePlain];
        _listTableView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
                                                                                                 [self.maskView addSubview:_listTableView];

    }
    else
        NSLog(@"error");
}


#pragma mark - UIScrollerViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.oldOffset = scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if( scrollView.contentOffset.y < self.oldOffset) {
        if (contentOffsetY<-64) {
            self.tableViewContentOffsety = 64;
        }
        else {
             self.tableViewContentOffsety = -34;
         
        }
    }else{
        self.tableViewContentOffsety = 64;
    }

    }
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
//    _rightTableView.hidden = NO;
    CGFloat contentOffsety  = scrollView.contentOffset.y;
      if (contentOffsety>60||contentOffsety<0) {
        self.scrollerLb.lableText = self.scrollerText;
        self.tableView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
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

//    _rightTableView.hidden = YES;
}


#pragma mark - LXSectionViewDelegate
-(void)sectionShowList{
    LXSelectListTableViewController *vc = [[LXSelectListTableViewController alloc]init];
    vc.tableView.frame = CGRectMake(0, 64, ViewWidth, ViewHeight-64);
    [self addChildViewController:vc];
    vc.songList = _songs;
    [self.view addSubview:vc.tableView];
    self.vc  =vc;
}


#pragma mark - LXTableViewCellDelegate
-(void)cellListClickEvent:(UIButton *)btn{
    btn.selected = !btn.selected;
    CGPoint point = btn.center;
    point = [self.tableView convertPoint:point fromView:btn.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    selectedIndexPath = indexpath;
    if (btn.selected) {
        self.operationSongView.images = @[@"next-gray",@"add-gray",@"share-gray",@"love-gray",@"download-gray"];
        self.operationSongView.titles = @[@"下一首",@"添加",@"分享",@"收藏",@"下载"];
        self.operationSongView.clos = 4;
        self.operationSongView.width =60;
        self.operationSongView.height = 80;
        self.operationSongView.delegate = self;
        [_operationSongView setupOperationSongView];
        [UIView animateWithDuration:0.1 animations:^{
            _operationSongView.frame = CGRectMake(0, ViewHeight/2.0+100, ViewWidth, ViewHeight/2.0-100);
        }];
        _operationSongView.backgroundColor = [UIColor whiteColor];
    }
    
}


#pragma mark - LXOperationSongViewDelegate
-(void)LXOperationSongViewButtonClick:(LXHorizontalButton *)sender{
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"下一首"]) {
        NSLog(@"下一首");
    }
    else if([title isEqualToString:@"添加"]){
        NSLog(@"添加到文件夹");
    }
    else if ([title isEqualToString:@"分享"]){
        NSLog(@"分享");
    }
    else if([title isEqualToString:@"下载"]){
        NSLog(@"下载");
    }
    else if([title isEqualToString:@"收藏"]){
        NSLog(@"收藏");
    }
    else
        NSLog(@"error");
    
}

#pragma mark - LXMaskViewDelegate
-(void)dissmissView:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [sender locationInView:nil];
        if (![_listTableView pointInside:[_listTableView convertPoint:location fromView:self.maskView] withEvent:nil]) {
            [_listTableView removeFromSuperview];
            _listTableView= nil;
        }
        if((![_listTableView.orderTable pointInside:[_listTableView.orderTable convertPoint:location fromView:self.maskView] withEvent:nil]))
            [_listTableView.orderTable removeFromSuperview];
        _listTableView.orderTable = nil;
        
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [sender locationInView:nil];
        if (![_operationSongView pointInside:[_operationSongView convertPoint:location fromView:self.listTableView] withEvent:nil]) {
            [_operationSongView removeFromSuperview];
            _operationSongView = nil;
            [_maskView removeFromSuperview];
            _maskView = nil;
        }
    }
    
}


@end
