//
//  LXSelectListTableViewCell.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/28.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXSelectListTableViewCell.h"
@interface LXSelectListTableViewCell()

@end
@implementation LXSelectListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         }
    return self;
}
-(void)initLeftView{
    UIButton *selectedBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [selectedBt setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    [selectedBt setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:selectedBt];
    selectedBt.selected = NO;
    _selectedBt = selectedBt;

}
+(LXTableViewCell *)addLXtableViewCell:(UITableView *)tableView withIdentity:(NSString *)identity{
    LXSelectListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    cell.backgroundColor = LXBacColor;
    cell.title = @"selected";
    return cell;

}
-(void)setIsSelected:(BOOL)isSelected{
    self.selectedBt.selected = isSelected;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_selectedBt makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(40);
        make.left.equalTo(0);
        make.centerY.equalTo(self.centerY);
    }];
}
@end
