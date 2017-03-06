//
//  LXSongMenuCollectionViewCell.m
//  LRMusicAndNews
//
//  Created by snow on 2017/1/24.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "LXSongMenuCollectionViewCell.h"
#import "LXSongMenuImageView.h"
#import "LXSongMenu.h"
@interface LXSongMenuCollectionViewCell()
@property (nonatomic,strong)LXSongMenuImageView *menuImageView;
@property (nonatomic,strong)UILabel *lb;
@end
@implementation LXSongMenuCollectionViewCell
-(void)prepareForReuse{
    [super prepareForReuse];
//    NSLog(@"wddddddddddddd");

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _menuImageView = [[LXSongMenuImageView alloc]init];
        _menuImageView.backgroundColor = [UIColor colorWithRed:242/255.20 green:244/255.0 blue:245/255.0 alpha:1.0];
        [self.contentView addSubview:_menuImageView];
        _lb = [[UILabel alloc]init];
        _lb.font = [UIFont systemFontOfSize:13.0];
        _lb.numberOfLines = 0;
        _lb.lineBreakMode = NSLineBreakByCharWrapping;
        _lb.layer.masksToBounds = YES;
        _lb.backgroundColor = [UIColor colorWithRed:242/255.20 green:244/255.0 blue:245/255.0 alpha:1.0];
        [self.contentView addSubview:_lb];
 NSLog(@"调用我了吗");
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

-(void)setSongMenu:(LXSongMenu *)songMenu{
     _songMenu = songMenu;
    _menuImageView.songmenu = songMenu;
     _lb.text =songMenu.title;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _menuImageView.frame =  CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    _lb.frame = CGRectMake(0, _menuImageView.frame.size.height, self.contentView.frame.size.width, 40);
}
@end
