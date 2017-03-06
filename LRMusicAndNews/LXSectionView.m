//
//  LXSectionView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/28.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXSectionView.h"
@interface LXSectionView()
@property (nonatomic,strong)UIButton *playBt;
@property (nonatomic,strong)UIButton *listButton;
@property (nonatomic,strong)UILabel *lable;
@property (nonatomic,strong)UILabel *countLb;
@end
@implementation LXSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *playBt = [[UIButton alloc]init];
        [playBt setImage:[UIImage imageNamed:@"play-red"] forState:UIControlStateNormal];
        [self addSubview:playBt];
        _playBt = playBt;
        
        UILabel *lable = [[UILabel alloc]init];
        lable.text = @"播放全部";
        [self addSubview:lable];
        _lable = lable;
        UILabel *countLb = [[UILabel alloc]init];
        [self addSubview:countLb];
        countLb.textColor = [UIColor lightGrayColor];
        _countLb = countLb;
        UIButton *listButton = [[UIButton alloc]init];
        [self  addSubview:listButton];
        [listButton setImage:[UIImage imageNamed:@"section-list"] forState:UIControlStateNormal];
        [listButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        _listButton = listButton;

    }
    return self;
}
-(void)setCount:(NSInteger)count{
    _countLb.text = [NSString stringWithFormat:@"(共%ld首)",count];
}
-(void)click{
    [self.delegate sectionShowList];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _playBt.frame = CGRectMake(15, 10, 20, 20);
    _lable.frame = CGRectMake(50, 0, 80, 40);
    [_countLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lable.right);
        make.height.equalTo(self.height);
        make.top.equalTo(self.top);
    }];
    [_listButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.right).offset(-45);
        make.width.height.equalTo(20);
        make.centerY.equalTo(self.centerY);
    }];

}
@end
