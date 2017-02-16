//
//  LXRecommmandListViewController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/27.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXRecommmandListViewController.h"
#import "LXSong.h"
#import "LXAlbum.h"
#import "LXAlbumHeaderView.h"
#import "LXOperationView.h"
#import "LXSectionView.h"
#import "LXAlbumDescripView.h"
@interface LXRecommmandListViewController ()<LXOperationViewDelegate,LXAlbumHeaderViewDelegate>


@property (nonatomic,strong)LXOperationView *bottomView;
@property (nonatomic,strong)  LXAlbumHeaderView *headerView;
@property (nonatomic,strong)NSArray *albumContents;
@property (nonatomic,strong)UIView *descriptionView;
@property (nonatomic,strong)LXAlbumDescripView*des;
@property (nonatomic,strong)AFHTTPSessionManager *manager;
@end
@implementation LXRecommmandListViewController
-(NSArray *)albumContents{
    if (!_albumContents) {
        _albumContents = [NSArray array];
    }
    return _albumContents;
}
-(NSString *)type{
    return @"推荐";
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.album = [[LXAlbum alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollerText = self.album.title;

}
-(void)setUpDescriptionView{
    _descriptionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    [self.view addSubview:_descriptionView];
    _descriptionView.hidden = YES;
    _des = [[LXAlbumDescripView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    _des.backgroundColor = [UIColor clearColor];
    [_descriptionView addSubview:_des];
    UIButton *closeBt = [[UIButton alloc]initWithFrame:CGRectMake(ViewWidth-30-30, 30, 30, 30)];
    [closeBt setImage:[UIImage imageNamed:@"CLOSE"] forState:UIControlStateNormal];
    [closeBt addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.descriptionView addSubview:closeBt];
}

-(void)setUptableHeaderView{
    _headerView= [[LXAlbumHeaderView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, LXTableHeaderViewHeight)];
    _headerView.album = self.album;
    _headerView.delegate = self;
    self.tableView.tableHeaderView  = _headerView;
    self.rgbArray = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%ld",self.album.album_id]];
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
    [_manager POST:LXMUSICURL parameters:LXParams(@"method":@"baidu.ting.album.getAlbumInfo",@"album_id":@(self.album.album_id)) success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.album = [LXAlbum mj_objectWithKeyValues:responseObject[@"albumInfo"]];
        [self.des initDataWithPictureUrl:self.album.pic_small addTitle:_album.title addContent:_album.info];
        _headerView.album = self.album;
        _albumContents= [LXSong mj_objectArrayWithKeyValuesArray:responseObject[@"songlist"]];
        self.songs = _albumContents;
        _bottomView.titles  =  @[[NSString stringWithFormat:@"%ld",self.album.collect_num],[NSString stringWithFormat:@"%ld",self.album.comment_num],[NSString stringWithFormat:@"%ld",self.album.share_num],@"下载"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark  - LXOperationViewDelegate
-(void)downLoad{
    NSLog(@"开始下载");
}
-(void)addMyCollection{
    NSLog(@"收藏");
}
-(void)share{
    NSLog(@"分享");
}
-(void)comment{
    NSLog(@"评论");
}

-(void)closeClick{
    [UIView animateWithDuration:0.3f animations:^{
        self.descriptionView.hidden = YES;
    }];
    self.des.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = NO;
    }
-(void)showDesdetail{
    NSLog(@"------------show");
    
    [UIView animateWithDuration:0.3f animations:^{
        self.descriptionView.hidden = NO;
        [self.des initDataWithPictureUrl:_album.pic_small addTitle:_album.title addContent:_album.info];
    }];
    self.navigationController.navigationBarHidden = YES;

}
-(void)dealloc{
    [self.manager.operationQueue cancelAllOperations];
}
@end
