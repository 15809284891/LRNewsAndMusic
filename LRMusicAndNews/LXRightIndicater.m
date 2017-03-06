//
//  LXRightIndicater.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/29.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXRightIndicater.h"

@implementation LXRightIndicater
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor  = [UIColor colorWithRed:69/255.0 green:73/255.0 blue:75/255.0 alpha:0.5];
        self.layer.cornerRadius = 10;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate =self;
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:10.0];
      cell.contentView.backgroundColor  = [UIColor colorWithRed:69/255.0 green:73/255.0 blue:75/255.0 alpha:0.3];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (mainScreenHeight-60)/_titles.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"right" object:cell.textLabel.text];
}

@end
