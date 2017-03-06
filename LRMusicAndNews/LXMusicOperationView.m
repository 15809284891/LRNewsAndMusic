//
//  LXMusicOperationView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/20.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXMusicOperationView.h"
@interface LXMusicOperationView()
@property (nonatomic,strong)UIButton *playMusicBt;
@property (nonatomic,strong)UIButton *perVBt;
@property (nonatomic,strong)UIButton *nextBt;
@property (nonatomic,strong)UIButton *randomPlayBt;
@property (nonatomic,strong)UIButton *playListBt;

@end
@implementation LXMusicOperationView
- (instancetype)init
{
    self = [super init];
    if (self) {
        _playListBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playListBt setImage:[UIImage imageNamed:@"musicList"] forState:UIControlStateNormal];
        [_playListBt addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        _playListBt.tag = 101;
        [self addSubview:_playListBt];
        _perVBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_perVBt addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        _perVBt.tag = 102;
        [_perVBt setImage:[UIImage imageNamed:@"prev"] forState:UIControlStateNormal];
        [self addSubview:_perVBt];
        _playMusicBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playMusicBt addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        _playMusicBt.tag = 103;
        [_playMusicBt setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [_playMusicBt setImage:[UIImage imageNamed:@"playing"] forState:UIControlStateSelected];
        _playMusicBt.selected = YES;
        [self addSubview:_playMusicBt];
        _nextBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBt  addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        [_nextBt setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        _nextBt.tag = 104;
        [self addSubview:_nextBt];
        _randomPlayBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_randomPlayBt addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        [_randomPlayBt setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        _randomPlayBt.tag =105;
        [self addSubview:_randomPlayBt];
       }
    return self;
}

-(void)operationAction:(UIButton *)sender{
    
}
-(void)playAction:(UIButton *)sender{
    [self.delegate addButtonTarget:sender];
  }
-(void)layoutSubviews{
    [super layoutSubviews];

    [self.playMusicBt makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(48);
        make.centerX.equalTo(self.centerX);
        make.centerY.equalTo(self.centerY);
    }];
    [self.perVBt makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.playMusicBt.left).offset(-30);
        make.width.height.equalTo(32);
        make.centerY.equalTo(self.centerY);
    }];
    [self.nextBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playMusicBt.right).offset(30);
        make.width.height.equalTo(32);
        make.centerY.equalTo(self.centerY);
    }];
    
    [self.randomPlayBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(30);
        make.width.height.equalTo(32);
        make.centerY.equalTo(self.centerY);
    }];
    [self.playListBt makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-30);
        make.height.width.equalTo(32);
        make.centerY.equalTo(self.centerY);
    }];
}
@end
