//
//  LXNavigationListTableView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/28.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXNavigationListTableView.h"
#import "LXOrderTableView.h"
@interface LXNavigationListTableView()
@property (nonatomic,strong)NSArray *text;
@property (nonatomic,strong)NSArray *images;
@end
@implementation LXNavigationListTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource  =self;
        _text = @[@"选择排序方式",@"清空下载文件",@"举报"];
        _images = @[@"排序",@"清空",@"举报"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = _text[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height/3.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        LXOrderTableView *orderTable = [[LXOrderTableView    alloc]initWithFrame:CGRectMake((mainScreenWidth-230)/2.0,(mainScreenHeight- 250)/2.0, 200, 230) style:UITableViewStyleGrouped];
        [self.superview addSubview:orderTable];
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [orderTable selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        _orderTable = orderTable;
        [self removeFromSuperview];
    }
    
}
@end
