//
//  LXMyMusicViewController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/12.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXMyMusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LXDownLoadCell.h"
#import "LXDownLoadSong.h"
#import "LXPlayerMusicTool.h"
#import "LXPlayMusicController.h"
#import "LXSong.h"
//#import "LXPlayerMusicTool.h"
@interface LXMyMusicViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    AVAudioPlayer *myBackMusic;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *downloadSongs;
@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)NSMutableArray *downLoadingSong;
@end
static NSString *identity= @"downLoadCell";
@implementation LXMyMusicViewController

-(NSArray *)downloadSongs{
    if (!_downloadSongs) {
        _downloadSongs= [NSArray array];
    }
    return _downloadSongs;
}
-(void)addprogressView:(NSNotification *)notify{
    LXSong *song = (LXSong *)notify.object;
    [_downLoadingSong addObject:song];
}
- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self setUpTableView];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@(addprogressView:)name:addDownloadSongProgress object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addprogressView:) name:addDownloadSongProgress object:nil];
    self.view.backgroundColor = [UIColor redColor];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.downloadSongs = [[[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:cachesPath error:nil]] pathsMatchingExtensions:[NSArray arrayWithObject:@"mp3"]];
 }
-(void)setUpTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXDownLoadCell *cell = [LXDownLoadCell addDownLoCell:tableView withIdentity:identity];
//    NSString *str = self.downloadSongs[indexPath.row];
//    NSString *text = [str componentsSeparatedByString:@"."][0];
//    cell.songName = text;
    LXSong *song = self.downLoadingSong[indexPath.row];
    cell.songName = song.songName;
//    cell.progressValue = rr
    cell.progressValue = 0.9;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.downloadSongs.count;
    return self.downLoadingSong.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.downloadSongs[indexPath.row];
    //初始化音乐
    //创建音乐文件路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *musicFilePath = [NSString stringWithFormat:@"%@/%@",cachesPath,self.downloadSongs[indexPath.row]];
    NSURL *videoURL = [NSURL fileURLWithPath:musicFilePath];
    LXPlayerMusicTool *tool = [LXPlayerMusicTool shareMusicPlay];
    [tool preparePlayMusicWithFilePath:musicFilePath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end
