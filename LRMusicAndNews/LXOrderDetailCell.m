
//
//  LXOrderDetailCell.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/11.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXOrderDetailCell.h"

@implementation LXOrderDetailCell
-(void)initLeftView{
    
}
+(LXTableViewCell *)addLXtableViewCell:(UITableView *)tableView withIdentity:(NSString *)identity{
    LXOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identity ];
    if (cell   == nil) {
        cell = [[LXOrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity ];
        
    }
    cell.backgroundColor = LXBacColor;
    return cell;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.rightView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.right.top.bottom.equalTo(0);
    }];
}
@end
