//
//  LXSoneMenuDescripView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/11.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXSongMenuDescripView.h"
@interface LXSongMenuDescripView()
@property (nonatomic,strong)UIImageView *pictureImageView;
@property (nonatomic,strong)UILabel *titleLb;
@property (nonatomic,strong)UILabel *desLb;
@end
@implementation LXSongMenuDescripView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.userInteractionEnabled = YES;
        _pictureImageView.backgroundColor = [UIColor redColor];
        [self addSubview:_pictureImageView];
        
        _titleLb = [[UILabel alloc]init];
        _titleLb.font = [UIFont systemFontOfSize:25.0];
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.numberOfLines = 0;
        _titleLb.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLb];
        _desLb = [[UILabel alloc]init];
        _desLb.numberOfLines = 0;
        _desLb.lineBreakMode = NSLineBreakByCharWrapping;
        _desLb.textColor = [UIColor whiteColor];
        [self addSubview:_desLb];
    }
    return self;
}
-(void)initDataWithPictureUrl:(NSString *)url addTitle:(NSString *)title addContent:(NSString *)content{
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"playBac"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIColor *color = [image colorAtPixel:CGPointMake(3, 3)];
        
        CGFloat red = 0.0;
        CGFloat green = 0.0;
        CGFloat blue = 0.0;
        CGFloat alpha = 0.0;
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
        
        if (red>0.99&&green>0.99&blue>0.99) {
            red = 204/255.0;
            green = red;
            blue= green;
        }
       [UIView animateWithDuration:2 animations:^{
            self.backgroundColor = color;
       }];
        
    }];
    _desLb.text = title;
    _titleLb.text = content;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_pictureImageView makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(300);
        make.centerX.equalTo(self.centerX);
        make.centerY.equalTo(self.centerY).offset(-100);
    }];
    [_titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pictureImageView.left);
        make.right.equalTo(self.pictureImageView.right);
        make.top.equalTo(self.pictureImageView.bottom);
        make.height.equalTo(60);
    }];
    [_desLb  makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pictureImageView.left);
        make.right.equalTo(_pictureImageView.right);
        make.top.equalTo(self.titleLb.bottom);
    }];
    self.contentSize  =CGSizeMake(0, CGRectGetMaxY(_desLb.frame));
}

@end
