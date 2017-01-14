//
//  LXRankListCell.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/10.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXRankListCell.h"
#import "LXSong.h"
@interface LXRankListCell()
@property (nonatomic,strong) UILabel *rankChangeLb;
@property (nonatomic,strong)UILabel *rankLb;

@end
@implementation LXRankListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

      
    }
    return self;
}
-(void)initLeftView{
    self.leftView  = [[UIView alloc]init];
      self.leftView  .backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:  self.leftView  ];
    _rankChangeLb = [[UILabel alloc]init];
    [  self.leftView   addSubview:_rankChangeLb];
    _rankLb = [[UILabel alloc]init];
    _rankLb.font = [UIFont systemFontOfSize:13.0];
    _rankLb.textAlignment = NSTextAlignmentCenter;
    [  self.leftView    addSubview:_rankLb];
}
-(void)setSong:(LXSong *)song{
    [super setSong:song];
    if ([song.rank isEqualToString:@"1"]||[song.rank  isEqualToString:@"2"]||[song.rank isEqualToString:@"3"]) {
        self.rankLb.textColor = MainColor;
    }
    else
        self.rankLb.textColor = [ UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    self.rankLb.text = song.rank;
    
    NSString *Str = song.is_new;
    if (Str.length) {
        if ([Str integerValue] == 1) {
            self.rankChangeLb.text = @"NEW";
            self.rankChangeLb.textColor = [UIColor colorWithRed:63/255.0 green:164/255.0 blue:100/255.0 alpha:1.0];
        }
        else{
            if ([song.rank_change intValue] == 0) {
                self.rankChangeLb.text = @"-0";
                self.rankChangeLb.textColor = [UIColor lightGrayColor];
            }
            else if([self.song.rank_change intValue]>0){
                self.rankChangeLb.text = [NSString stringWithFormat:@"%@",song.rank_change];
                self.rankChangeLb.textColor = MainColor;
            }
            else{
                self.rankChangeLb.text = [NSString stringWithFormat:@"%@",song.rank_change];
                self.rankChangeLb.textColor = [UIColor blueColor];
            }
        }
        self.rankChangeLb.font = [UIFont systemFontOfSize:10.0];
        self.rankChangeLb.textAlignment = NSTextAlignmentCenter;
        
    }
    

}

+(LXTableViewCell *)addLXtableViewCell:(UITableView *)tableView withIdentity:(NSString *)identity{
    LXRankListCell*cell = [tableView dequeueReusableCellWithIdentifier:identity];
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
    
    [self.rankLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.width.equalTo(40);
        make.height.equalTo(self.rankLb.width);
    }];
    [self.rankChangeLb makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rankLb.centerX);
        make.top.equalTo(self.rankLb.bottom);
        make.height.equalTo(10);
    }];

}
@end
