//
//  LXSongRankCell.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXRankMenuCell.h"
#import "LXRankMenu.h"
#import "LXSong.h"
@interface LXRankMenuCell()
@property (nonatomic,strong) UIImageView *RankImage;
@property (nonatomic,strong) UIView *contentListsView;
@end
@implementation LXRankMenuCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _RankImage = [[UIImageView alloc]init];
        _RankImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_RankImage];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(105, 99,[UIScreen mainScreen].bounds.size.width-105, 1)];
        lineView.backgroundColor = LXcellLineColor;
        [self.contentView addSubview:lineView];
        _contentListsView = [[UIView alloc]init];
        [self.contentView addSubview:_contentListsView];
        for (int i = 0; i<3; i++) {
            UILabel *lable = [[UILabel alloc]init];
            lable.font = [UIFont systemFontOfSize:12.0];
            lable.textColor = [UIColor darkGrayColor];
            [_contentListsView  addSubview:lable];
        }
    }
    return self;
}
-(void)setRankMenu:(LXRankMenu *)rankMenu{
    _rankMenu = rankMenu;
    [_RankImage sd_setImageWithURL:[NSURL URLWithString:_rankMenu.pic_s260] placeholderImage:[UIImage imageNamed:@"test1.jpg"]];
    for (int i = 0; i<self.contentListsView.subviews.count; i++) {
        UILabel *lable = self.contentListsView.subviews[i];
        LXSong *song = _rankMenu.contents[i];
        lable.text = [NSString stringWithFormat:@"%d.%@ - %@",i+1,song.title,song.author];
    }
}
+(LXRankMenuCell *)addRankMenuCell:(UITableView *)tableView withIdentity:(NSString *)identity{
    LXRankMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.RankImage.frame = CGRectMake(10, 10, 80, 80);
    self.contentListsView.frame = CGRectMake(105, 0, [UIScreen mainScreen].bounds.size.width - 105, 99);
    CGFloat width = self.contentListsView.frame.size.width;
    CGFloat beginY = 15;
    CGFloat height = (self.contentListsView.frame.size.height - beginY*2)/3.0;
    CGFloat x = 0;
    for (int i = 0; i<self.contentListsView.subviews.count; i++) {
        CGFloat y = beginY + i *height;
        UILabel *lable = self.contentListsView.subviews[i];
        lable.frame = CGRectMake(x,y, width, height);
    }
}
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    
    
    return result;
    
}


@end
