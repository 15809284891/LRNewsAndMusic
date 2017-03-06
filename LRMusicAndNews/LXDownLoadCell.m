//
//  LXDownLoadCell.m
//  LRMusicAndNews
//
//  Created by snow on 2017/1/20.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "LXDownLoadCell.h"
@interface LXDownLoadCell()
@property (nonatomic,strong)UILabel *songNameLB;
@property (nonatomic,strong)UIProgressView *progressView;
@property (nonatomic,strong)UIButton *cancleBt;
@end
@implementation LXDownLoadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _songNameLB = [[UILabel alloc]init];
        [self.contentView addSubview:_songNameLB];
        _progressView = [[UIProgressView alloc]init];
        [self.contentView addSubview:_progressView];
        _cancleBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBt addTarget:self action:@selector(cancleOrContinue:) forControlEvents:UIControlEventTouchUpInside];
        [_cancleBt setImage:[UIImage imageNamed:@"正在下载"] forState:UIControlStateSelected];
        [_cancleBt setImage:[UIImage imageNamed:@"暂停下载"] forState:UIControlStateNormal];
        _cancleBt.selected = YES;
        [self.contentView addSubview:_cancleBt];
    }
    return self;
}
+(LXDownLoadCell *)addDownLoCell:(UITableView *)tableView withIdentity:(NSString *)identity{
    LXDownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[LXDownLoadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;

}
-(void)setSongName:(NSString *)songName{
    _songNameLB.text = songName;
}
-(void)setProgressValue:(CGFloat)progressValue{
    _progressView.progress = progressValue;
}
-(void)cancleOrContinue:(UIButton *)sender{
    [self.delegate downLoadSong:sender];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _songNameLB.frame = CGRectMake(10, 0, self.contentView.frame.size.width-80,48);
    _progressView.frame = CGRectMake(10, 48, self.contentView.frame.size.width-80, 2);
    _cancleBt.frame = CGRectMake(CGRectGetMaxX(_progressView.frame), 0, 48, 48);
}
@end
