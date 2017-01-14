//
//  LXNewSongController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXNewSongController.h"
#import "LXSongMenuImageView.h"
#import "LXAlbum.h"
#import "LXVerticalButton.h"
#import "LXRecommmandListViewController.h"
static NSString *identity = @"newSongCell";
@interface LXNewSongController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSMutableArray *newSongs;
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation LXNewSongController
-(NSMutableArray *)newSongs{
    if (!_newSongs) {
        _newSongs  = [NSMutableArray array];
    }
    return _newSongs;
}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor lightGrayColor];
    [self setUpCollectionView];
    [[AFHTTPSessionManager manager]POST:LXMUSICURL parameters:LXParams(@"method":@"baidu.ting.plaza.getRecommendAlbum",@"offset":@0,@"limit":@50,@"type":@4) success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"-----%@",responseObject);
        NSMutableArray *array = [NSMutableArray array];
        array=[LXAlbum mj_objectArrayWithKeyValuesArray:responseObject[@"plaze_album_list"][@"RM"][@"album_list"][@"list"]];
        for (LXAlbum*newSong in array) {
//            if (newSong.is_recommend_mis) {
                [self.newSongs addObject:newSong];
//            }
        }
        [self.collectionView  reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)setUpCollectionView{
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-30-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _collectionView.backgroundColor = [UIColor redColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor colorWithRed:242/255.20 green:244/255.0 blue:245/255.0 alpha:1.0];
    [_collectionView  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identity];
    [self.view addSubview:_collectionView];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    LXAlbum *newSong = self.newSongs[indexPath.row];
    UIImageView *bacImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.width)];
    [bacImage sd_setImageWithURL:[NSURL URLWithString:newSong.pic_big] placeholderImage:[UIImage imageNamed:@"playBac"]];
    [cell.contentView addSubview:bacImage];
    UILabel *contryLb = [[UILabel alloc]init];
    contryLb.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    contryLb.font = [UIFont systemFontOfSize:15.0];
    contryLb.textColor = [UIColor whiteColor];
    [bacImage addSubview:contryLb];
    [contryLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(bacImage.bottom);
        make.height.equalTo(30);
        make.width.equalTo(100);
    }];
    contryLb.text = newSong.country;
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, bacImage.frame.size.height, cell.contentView.frame.size.width,20)];
    lb.text =newSong.title;
    lb.font = [UIFont systemFontOfSize:13.0];
    [cell.contentView addSubview:lb];
    
    return cell;

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGSize size = CGSizeMake((ViewWidth-30)/2.0,ViewWidth/2.0+40);
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insets =UIEdgeInsetsMake(15,  5, 5,5);
    return insets;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.newSongs.count;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LXAlbum *newSong = self.newSongs[indexPath.row];
    LXRecommmandListViewController *reCommandVc = [[LXRecommmandListViewController alloc]init];
    reCommandVc.album= newSong;
    [self.navigationController pushViewController:reCommandVc animated:YES]
    ;}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
