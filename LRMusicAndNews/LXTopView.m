//
//  LXTopView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXTopView.h"
#import "LXScrollerLable.h"
@interface LXTopView ()
@property (nonatomic,strong)UISearchBar *bar;
@property (nonatomic,strong)UIButton *listBt;
@end
@implementation LXTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bar = [[UISearchBar alloc]init];
        _bar.barStyle = UIBarStyleDefault;
        _bar.placeholder = @"搜索歌单里歌曲";
        [self addSubview:_bar];
        _listBt = [[UIButton alloc]init];
        _listBt.tag = 2;
        [_listBt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_listBt setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
        [self addSubview:_listBt];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([self.type isEqualToString:@"榜单"]) {
        _listBt.hidden = YES;
        [self.bar makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left);
            make.right.equalTo(self.right);
            make.top.equalTo(0);
            make.height.equalTo(self.height);
        }];

    }
    else{
        _listBt.hidden = NO;
    [self.bar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right).offset(-50);
        make.top.equalTo(0);
        make.height.equalTo(self.height);
    }];
    [_listBt makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-20);
        make.width.height.equalTo(30);
        make.centerY.equalTo(self.centerY);
    }];
    }
   }
-(void)buttonClick:(UIButton *)sender{
    [self.delegate LXTopViewButtonClick:sender];
}
@end
