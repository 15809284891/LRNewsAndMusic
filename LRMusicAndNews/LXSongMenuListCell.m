//
//  LXSongMenuListCell.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/10.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXSongMenuListCell.h"
#import "LXSong.h"
@interface LXSongMenuListCell  ()
@property (nonatomic,strong)UILabel *num_lb;
@end
@implementation LXSongMenuListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}
-(void)initLeftView{
    self.leftView  = [[UIView alloc]init];
    self.leftView  .backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:  self.leftView  ];
    
    _num_lb = [[UILabel alloc]init];
    _num_lb.textAlignment   = NSTextAlignmentCenter;
    [self.leftView addSubview:_num_lb];
}
-(void)setNum:(NSString *)num{
    _num  = num;
    self.num_lb.text = num;
}
+(LXTableViewCell *)addLXtableViewCell:(UITableView *)tableView withIdentity:(NSString *)identity{
    LXSongMenuListCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = LXBacColor;
    return cell;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.leftView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(40);
        make.top.bottom.equalTo(0);
    }];
    [self.num_lb makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.leftView);
    }];
    
    
}

@end
