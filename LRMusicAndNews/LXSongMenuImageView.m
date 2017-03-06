//
//  LXSongMenuImageView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/24.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXSongMenuImageView.h"
#import "LXVerticalButton.h"
#import "LXSongMenu.h"
@interface LXSongMenuImageView()
@property (nonatomic,strong)UIImageView *bacImage;
@property (nonatomic,strong)LXVerticalButton  *authorBT;
@property (nonatomic,strong)LXVerticalButton *listeningBT;
@end
@implementation LXSongMenuImageView
- (instancetype)init
{
    self = [super init];
    if (self) {
        _bacImage = [[UIImageView alloc]init];
        [self addSubview:_bacImage];
        _authorBT = [[LXVerticalButton alloc] init];
        [_authorBT setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
        [self.bacImage addSubview:_authorBT];
        _listeningBT = [[LXVerticalButton alloc]init];
        [_listeningBT setImage:[UIImage imageNamed:@"listen"] forState:UIControlStateNormal];
        [self.bacImage addSubview:_listeningBT];
    }
    return self;
}
-(void)setSongmenu:(LXSongMenu *)songmenu{
    _songmenu = songmenu;
    [self.bacImage sd_setImageWithURL:self.songmenu.pic_300 placeholderImage:[UIImage imageNamed:@"test1.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImage compressionSizeWithImage:image size:CGSizeMake((mainScreenWidth-30)/2.0, (mainScreenWidth-30)/2.0)];
    }];
    [self.authorBT setTitle:self.songmenu.tag forState:UIControlStateNormal   ];
    [self.listeningBT setTitle:self.songmenu.collectnum forState:UIControlStateNormal];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height  = self.frame.size.height;
    _bacImage.frame = CGRectMake(0, 0, width,width);
    self.authorBT.dis = 4;
    self.authorBT.textalightment = NSTextAlignmentLeft;
   [self.authorBT makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.left);
       make.width.equalTo(self.width).offset(-20);
       make.height.equalTo(30);
       make.bottom.equalTo(self.bottom).offset(-5);
   }];
    self.listeningBT.dis = 0;
    self.listeningBT.textalightment  =NSTextAlignmentRight;
    [self.listeningBT makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right);
        make.height.equalTo(30);
        make.width.equalTo(50);
        make.top.equalTo(self.top);
    }];
}
@end
