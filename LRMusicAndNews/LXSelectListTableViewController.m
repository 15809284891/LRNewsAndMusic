//
//  LXSelectListTableViewController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/28.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXSelectListTableViewController.h"
#import "LXSelectListTableViewCell.h"
#import "LXSong.h"
#import "LXHorizontalButton.h"
@interface LXSelectListTableViewController ()
@property (nonatomic,strong)UIView *navigationBar;

@end
static NSString *identity = @"selectCell";
@implementation LXSelectListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[LXSelectListTableViewCell class] forCellReuseIdentifier:identity];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.navigationController.navigationBar.barTintColor = MainColor;
   }
-(void)setUpNavigationBar{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXSong  *song = self.songList[indexPath.row];
    LXSelectListTableViewCell *cell = [LXSelectListTableViewCell addLXtableViewCell:tableView withIdentity:identity ];
    cell.song = song;
    cell.type = @"选择";
    cell.isSelected = song.isSelected;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.songList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 60)];
    footerView.backgroundColor = [UIColor whiteColor];
    CGFloat width = 80;
    CGFloat marginX  =(ViewWidth-width*3)/4.0;
    CGFloat Y = 0;
    CGFloat height = 60;
    NSArray *images = @[@"next-black",@"joinSongMenu",@"download-black"];
    NSArray *titles = @[@"播放下一首",@"加入歌单",@"下载"];
    for (int i = 0; i<3; i++) {

        LXHorizontalButton *button = [[LXHorizontalButton alloc]initWithFrame:CGRectMake(marginX*(i+1)+width*i, 0, width, height)];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button  setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footerView addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(footerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return footerView;
}
-(void)footerButtonClick:(UIButton *)sender{
    if (sender.tag == 0) {
        NSLog(@"播放下一首");
    }
    else if(sender.tag == 1){
        NSLog(@"加入歌单");
    }
    else if (sender.tag == 2){
        NSLog(@"下载");
    }
}

-(void)closeClick{
    [self.tableView removeFromSuperview];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXSong *song = self.songList[indexPath.row];
    song.isSelected = !song.isSelected;
    LXSelectListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = song.isSelected;

    for (int i = 0; i<self.songList.count; i++) {
        LXSong *song = self.songList[i];
//        NSLog(@"------%@----%d",song.title,song.isSelected?YES:NO);
    }
    cell.selectedBt.selected= song.isSelected ;
    [self.tableView reloadData];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
