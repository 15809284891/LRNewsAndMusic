//
//  LXMyMusicViewController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/12.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXMyMusicViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import "LXPlayerMusicTool.h"
@interface LXMyMusicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *downloadSongs;
@property (nonatomic,strong)AVPlayer *player;
@end

@implementation LXMyMusicViewController
-(NSArray *)downloadSongs{
    if (!_downloadSongs) {
        _downloadSongs= [NSArray array];
    }
    return _downloadSongs;
}
- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self setUpTableView];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.downloadSongs = [[[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:cachesPath error:nil]] pathsMatchingExtensions:[NSArray arrayWithObject:@"mp3"]];
    
//    NSArray *levelList = [[[[NSFileManager alloc] init]
//                           contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
//                           error:nil]
//                          pathsMatchingExtensions:];
//    NSLog(@"---------%@",tempFileList);
}
-(void)setUpTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"downloadCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadCell"];
    NSString *str = self.downloadSongs[indexPath.row];
    NSString *text = [str componentsSeparatedByString:@"."][0];
    cell.textLabel.text =text;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.downloadSongs.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.downloadSongs[indexPath.row];
    NSLog(@"%@",str);
    NSURL *url = [NSURL URLWithString:str];
    _player = [[AVPlayer alloc] initWithURL:url];
    if (_player == NULL)
    {
        NSLog(@"fail to play audio :(");
        return;
    }
    
    [_player setVolume:1];
    [_player play];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"rem" ofType:@"wav"];
    NSURL *audioUrl = [NSURL fileURLWithPath:audioPath];
    NSError *playerError;
//    _player = [[AVPlayer alloc] initWithContentsOfURL:audioUrl error:&playerError];
    if (_player == NULL)
    {
        NSLog(@"fail to play audio :( ");
        return;
    }
    
    [_player setVolume:1];
    [_player play];
}
@end
