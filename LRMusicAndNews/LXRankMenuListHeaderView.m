//
//  LXRankMenuListHeaderView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXRankMenuListHeaderView.h"
#import "LXBlurViewTool.h"
#import "LXRankMenu.h"
@interface LXRankMenuListHeaderView () 
@property (nonatomic,strong)UIImageView *picture;
@property (nonatomic,strong)UIButton *detailBt;
@property (nonatomic,strong)UILabel *detailLb;
@property (nonatomic,strong)UILabel *uppdateLb;
@end
@implementation LXRankMenuListHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [LXBlurViewTool blurView:self :UIBarStyleBlackOpaque];
        self.userInteractionEnabled = YES;
        _picture = [[UIImageView alloc]init];
        _picture.userInteractionEnabled = YES;
        [self addSubview:_picture];
        _uppdateLb = [[UILabel alloc]init];
        _uppdateLb.font = [UIFont systemFontOfSize:13.0];
        _uppdateLb.textColor = [UIColor whiteColor];
        [self  addSubview:_uppdateLb];
        _detailBt = [[UIButton alloc]init];
        [_detailBt addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
        [_detailBt setImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
        [self addSubview:_detailBt];
        _detailLb = [[UILabel alloc]init];
        _detailLb.hidden = YES;
        _detailLb.layer.cornerRadius = 5;
        _detailLb.clipsToBounds = YES;
        _detailLb.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _detailLb.textColor = [UIColor whiteColor];
        _detailLb.font = [UIFont systemFontOfSize:15.0];
        _detailLb.numberOfLines = 0;
        _detailLb.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_detailLb];
       
    }
    return self;
}
-(void)showDetail:(UIButton *)sender{

    [UIView animateWithDuration:0.2 animations:^{
                _detailLb.hidden = !_detailLb.hidden;
    }];
}
-(void)setUpdateTime:(NSString *)updateTime{
    _updateTime = updateTime;
    NSLog(@"-%@",updateTime);
    if (_updateTime.length == 0) {
        _uppdateLb.text = @"暂无更新";
    }
    else 
    _uppdateLb.text = [NSString stringWithFormat:@"最近更新:%@",updateTime];
    if (self.rankMenu.comment.length == 0) {
        _detailLb.text = @"没有相关信息";
    }
    else
    _detailLb.text = self.rankMenu.comment;
}
-(void)setRankMenu:(LXRankMenu *)rankMenu{
    _rankMenu = rankMenu;
    //取图片主色调；
    [_picture sd_setImageWithURL:[NSURL URLWithString:_rankMenu.pic_s192] placeholderImage:[UIImage imageNamed:@"playBac"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIColor *color = [image colorAtPixel:CGPointMake(1, 1)];
        self.backgroundColor = color;
        CGFloat red = 0.0;
        CGFloat green = 0.0;
        CGFloat blue = 0.0;
        CGFloat alpha = 0.0;
        [color  getRed:&red green:&green blue:&blue alpha:&alpha];
        NSArray *array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%f",red],[NSString stringWithFormat:@"%f",green],[NSString stringWithFormat:@"%f",blue], nil];
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:self.rankMenu.type];

    }];
    self.detailLb.text = _rankMenu.comment;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_picture makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.width.equalTo(200);
        make.height.equalTo(150);
        make.centerY.equalTo(self.centerY);
    }];
    
    [_uppdateLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picture.left).offset(20);
        make.right.equalTo(self.picture.right);
        make.top.equalTo(self.picture.bottom);
        make.height.equalTo(40);
    }];

    [_detailBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picture.right);
        make.width.height.equalTo(30);
        make.bottom.equalTo(self.picture.bottom).offset(-10);
    }];
    [_detailLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picture.left);
        make.right.equalTo(self.right).offset(-30);
        make.top.equalTo(self.detailBt.bottom);
    }];
   }

@end
