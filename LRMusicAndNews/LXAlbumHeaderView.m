//
//  LXAlbumHeaderView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/27.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXAlbumHeaderView.h"
#import "LXVerticalButton.h"
#import "LXAlbum.h"
@interface LXAlbumHeaderView()
@property (nonatomic,strong)UIImageView *pictureImageView;
@property (nonatomic,strong)UIButton *authorBT;
@property (nonatomic,strong)UILabel *publishTimeLb;
@property (nonatomic,strong)UIButton *detailBT;
@property (nonatomic,strong)UILabel *titleLb;
@property (nonatomic,strong)UILabel *lable;
@property (nonatomic,strong)UILabel *styleLb;
@property (nonatomic,strong)UILabel *languigeLb;
@property (nonatomic,strong)UILabel *contryLb;
//@property (nonatomic,strong)
@end
@implementation LXAlbumHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.userInteractionEnabled = YES;
        [self addSubview:_pictureImageView];
        UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureClick)];
        [_pictureImageView addGestureRecognizer:tg];
        
        
        _detailBT = [[UIButton alloc]init];
        [_detailBT setImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
        [self.pictureImageView addSubview:_detailBT];
        
        self.titleLb = [[UILabel alloc]init];
        _titleLb.numberOfLines = 0;
        _titleLb.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:_titleLb];
        
        _authorBT = [[UIButton alloc]init];
        _authorBT.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_authorBT];

        _publishTimeLb = [[UILabel alloc]init];
        _publishTimeLb.font = [UIFont systemFontOfSize:13.0];
        _publishTimeLb.textColor = [UIColor whiteColor];
        [self addSubview:_publishTimeLb];
        _lable = [[UILabel alloc]init];
        _lable.text = @"标签";
        _lable.font = [UIFont systemFontOfSize:13.0];
        _lable.textColor = [UIColor whiteColor];
        _lable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        [self addSubview:_lable];
        _styleLb = [self setUpLable];
        _contryLb = [self setUpLable];
        _languigeLb = [self setUpLable];
        
    }
    return self;
}
-(void)setAlbum:(LXAlbum *)album{
    _album = album;
    _titleLb.text = _album.title;
    [_authorBT setTitle:[NSString stringWithFormat:@"歌手: %@ >",_album.author] forState:UIControlStateNormal];
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.album.pic_small] placeholderImage:[UIImage imageNamed:@"playBac"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIColor *color = [image colorAtPixel:CGPointMake(5, 5)];
        CGFloat red = 0.0;
        CGFloat green = 0.0;
        CGFloat blue = 0.0;
        CGFloat alpha = 0.0;
        [color  getRed:&red green:&green blue:&blue alpha:&alpha];
        if (red>0.9&&green>0.9&blue>0.9) {
            color = [UIColor lightGrayColor];
        }
        self.backgroundColor = color;
        NSArray *array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%f",red],[NSString stringWithFormat:@"%f",green],[NSString stringWithFormat:@"%f",blue], nil];
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:[NSString stringWithFormat:@"%ld",self.album.album_id]];
        
    }];
    _publishTimeLb.text = _album.publishtime;
    _styleLb.text = _album.styles;
    _contryLb.text = _album.country;
    _languigeLb.text = _album.language;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_pictureImageView  makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.centerY.equalTo(self.centerY);
        make.width.height.equalTo(150);
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
    [_authorBT makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.left);
        make.height.equalTo(25);
        make.top.equalTo(self.titleLb.bottom).offset(10);
    }];
    [_publishTimeLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorBT.left);
        make.height.equalTo(25);
        make.top.equalTo(self.authorBT.bottom);
    }];
    [_lable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.publishTimeLb.left);
        make.height.equalTo(25);
        make.top.equalTo(_publishTimeLb.bottom).offset(5);
        make.width.equalTo(30);
    }];
    [_styleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lable.right).offset(5);
        make.height.equalTo(_lable.height);
        make.top.equalTo(_lable.top);
     }];
    
    [_contryLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_styleLb.right).offset(5);
        make.height.equalTo(_styleLb.height);
        make.top.equalTo(_styleLb.top);
    }];
    
    [_languigeLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contryLb.right).offset(5  );
        make.top.equalTo(_contryLb.top);
        make.height.equalTo(_contryLb.height);
    }];
}
-(void)gestureClick{
    NSLog(@"---------------------");
    [self.delegate showDesdetail];
}
-(void)userclick{
    [self.delegate showartistDetail];
}
-(UILabel *)setUpLable{

    UILabel *lable =  [[UILabel alloc]init];
    lable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:lable];
    return lable;

}
@end

