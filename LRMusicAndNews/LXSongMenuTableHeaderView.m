//
//  LXSongMenuTableHeaderView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/26.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXSongMenuTableHeaderView.h"
#import "LXVerticalButton.h"
#import "LXSongMenu.h"
@interface LXSongMenuTableHeaderView()
@property (nonatomic,strong) UIImageView*pictureImageView;
@property (nonatomic,strong)LXVerticalButton *lisentBt;
@property (nonatomic,strong)UILabel *titleLb;
@property (nonatomic,strong)UIButton *detailBT;
@property (nonatomic,strong)UIImageView *userImageView;
@property(nonatomic,strong) UIButton *userButton;
@end
@implementation LXSongMenuTableHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.userInteractionEnabled = YES;
        [self addSubview:_pictureImageView];
        UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureClick)];
        [_pictureImageView addGestureRecognizer:tg];
        _lisentBt = [[LXVerticalButton alloc]init];
        [_lisentBt setImage:[UIImage imageNamed:@"listen"] forState:UIControlStateNormal];
        [self.pictureImageView addSubview:_lisentBt];
        
        _detailBT = [[UIButton alloc]init];
        [_detailBT setImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
        [self.pictureImageView addSubview:_detailBT];
        
        self.titleLb = [[UILabel alloc]init];
        _titleLb.numberOfLines = 0;
        _titleLb.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:_titleLb];
        
        self.userImageView = [[UIImageView alloc]init];
        [self addSubview:self.userImageView];
        
        _userButton = [[UIButton alloc] init];
        [_userButton addTarget:self action:@selector(userclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_userButton];
    }
    return self;
}
-(void)setSongMenu:(LXSongMenu *)songMenu{
    _songMenu = songMenu;
    self.titleLb.text = _songMenu.title;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.songMenu.pic_300] placeholderImage:[UIImage imageNamed:@"playBac"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIColor *color = [image mostColor];
        CGFloat red = 0.0;
        CGFloat green = 0.0;
        CGFloat blue = 0.0;
        CGFloat alpha = 0.0;
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
        
        if (red>0.9&&green>0.9&blue>0.9) {
            color = [UIColor lightGrayColor];
        }
        self.backgroundColor = color;

        const CGFloat *components = CGColorGetComponents(color.CGColor);
        NSArray *array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%f",components[0]],[NSString stringWithFormat:@"%f",components[1]],[NSString stringWithFormat:@"%f",components[2]], nil];
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:self.songMenu.listid];

    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_pictureImageView  makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.centerY.equalTo(self.centerY);
        make.width.height.equalTo(150);
    }];
    
    [_lisentBt  makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pictureImageView.right);
        make.height.equalTo(30);
        make.width.equalTo(60);
        make.top.equalTo(self.pictureImageView.top);
    }];
    
    [_detailBT makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pictureImageView.right);
        make.bottom.equalTo(self.pictureImageView.bottom);
        make.width.height.equalTo(30);
    }];
    
    [_titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pictureImageView.right).offset(20);
        make.right.equalTo(self.right).offset(-10);
        make.top.equalTo(self.pictureImageView.top).offset(10);
    }];
    
    [_userImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.left);
        make.top.equalTo(self.titleLb.bottom).offset(10);
        make.width.height.equalTo(50);
    }];
    [_userButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userImageView.right).offset(10);
        make.right.equalTo(self.titleLb.right);
        make.height.equalTo(40);
        make.top.equalTo(self.userImageView.top);
    }];
}
-(void)gestureClick{
    [self.delegate showDesDetail];
}
-(void)userclick{
    [self.delegate showuserInfo];
}
@end
