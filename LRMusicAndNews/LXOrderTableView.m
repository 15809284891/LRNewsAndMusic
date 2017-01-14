//
//  LXOrderTableView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/28.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXOrderTableView.h"
@interface LXOrderTableView()
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,strong)NSArray *texts;
@end
@implementation LXOrderTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate =self;
        self.dataSource =self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        _images = @[@"默认排序",@"单曲排序",@"专辑排序",@"歌手排序"];
        _texts = @[@"默认",@"按单曲名",@"按专辑名",@"按歌手名"];
    }
    return self;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.frame.size.height-60)/4.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell  *cell = [[UITableViewCell alloc]init];
    cell.backgroundColor = LXBacColor;
    cell.textLabel.text = _texts[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    cell.tintColor = MainColor;
    if (indexPath.row == 0) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark ];
    }
   
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth-10, 60)];
    lable.font =[UIFont systemFontOfSize:18.0];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"请选择排序方式";
    lable.textColor = [UIColor blackColor];
    return lable;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [tableView visibleCells];
    
    for (UITableViewCell *cell in array) {
        // 不打对勾
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
  
    // 打对勾
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"order" object:cell.textLabel.text];
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
@end
