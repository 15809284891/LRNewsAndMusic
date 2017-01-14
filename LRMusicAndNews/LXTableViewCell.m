



//
//  LXTableViewCell.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/27.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXTableViewCell.h"
#import "LXSong.h"
#import "LXVerticalButton.h"
@interface LXTableViewCell ()
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *artistLb;
@property (nonatomic,strong)UILabel *albumLb;
@property (nonatomic,strong) UIButton *hasMVBt;
//@property (nonatomic,strong) UILabel *rankChangeLb;
//@property (nonatomic,strong)UILabel *rankLb;
@property (nonatomic,strong)UIButton *listBT;

@end
@implementation LXTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initLeftView];
        [self initRightView];
    }
    return self;
}
-(void)initRightView{
    _rightView = [[UIView alloc]init];
    _rightView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_rightView];
    _lineView= [[UIView alloc]init];
    _lineView.backgroundColor= LXcellLineColor;
    [_rightView addSubview:_lineView];
    _titleLb = [[UILabel alloc]init];
    _titleLb.font = [UIFont systemFontOfSize:14.0];
    _titleLb.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_rightView  addSubview:_titleLb];
    _artistLb = [[UILabel alloc]init];
    _artistLb.font = [UIFont systemFontOfSize:12.0];
    _artistLb.textColor =[ UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    [_rightView addSubview:_artistLb];
    _albumLb = [[UILabel alloc]init];
    [_rightView addSubview:_albumLb];
    _albumLb.font = [UIFont systemFontOfSize:12.0];
    _albumLb.textColor = [ UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    _hasMVBt = [[UIButton alloc]init];
    [_hasMVBt setImage:[UIImage imageNamed:@"MV"] forState:UIControlStateNormal];
    [_rightView addSubview:_hasMVBt];
    
    _listBT = [[UIButton alloc]init];
    [_listBT setImage:[UIImage imageNamed:@"gray-list"] forState:UIControlStateNormal];
    [_listBT addTarget:self action:@selector(cellListClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightView addSubview:_listBT];
    
}
-(void)setTitle:(NSString *)title{
    _title = title;
}
-(void)setSong:(LXSong *)song{
    _song = song;
    self.titleLb.text = _song.title;
    _albumLb.text = _song.album_title;
    self.artistLb.text = [NSString stringWithFormat:@"%@ - %@",self.song.author,_song.album_title];
    self.hasMVBt.hidden = !(self.song.has_mv);

}

-(void)layoutSubviews{
    [super layoutSubviews];
        [self.rightView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(40);
            make.right.equalTo(self.right);
            make.top.bottom.equalTo(0);
        }];
      [_lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightView.left);
        make.right.equalTo(self.rightView.right);
        make.height.equalTo(1);
        make.bottom.equalTo(self.rightView.bottom);
    }];
    [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lineView.left);
        make.top.equalTo(0);
        make.height.equalTo(30);
        make.right.equalTo(0);
    }];
    [self.hasMVBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.right).offset(3);
        make.width.height.equalTo(20);
        make.centerY.equalTo(self.titleLb.centerY);
    }];
    [self.artistLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.left);
        make.top.equalTo(self.titleLb.bottom);
        make.height.equalTo(20);
    }];
    [_listBT makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(40);
        make.right.equalTo(self.rightView.right).offset(-20);
        make.top.equalTo(_titleLb.top).offset(10);
    }];
}
-(void)cellListClick:(UIButton *)sender{
    [self.delegate cellListClickEvent:sender];
}
@end







