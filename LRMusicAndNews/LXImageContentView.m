//
//  LXImageContentView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXImageContentView.h"
#import "LXOperationSongView.h"
#import "LXHorizontalButton.h"
#import "LXSong.h"
@interface LXImageContentView()<LXOperationSongViewDelegate>
@property (nonatomic,strong)UIImageView *albumImageView;
@property (nonatomic,strong)LXOperationSongView  *operationView;
@property (nonatomic,strong)CADisplayLink *link ;
@property (nonatomic,strong)UILabel *authorLb;
@end
@implementation LXImageContentView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initContent];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
           [self initContent];
    }
    return self;
}
-(void)initContent{
    [self setupAuthorLb];
    [self setupAlbumImageView];
    [self setupOperationView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopRotating) name:@"stopRotating" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startRotating) name:@"startRotating" object:nil];
}
-(void)setSong:(LXSong *)song{
    _song = song;
    [_albumImageView  sd_setImageWithURL:[NSURL URLWithString:_song.songPicRadio] placeholderImage:[UIImage circleImage:[UIImage imageNamed:@"test1.jpg"] borderWidth:30 borderColor:[UIColor whiteColor]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _albumImageView.image =     [UIImage circleImage:image borderWidth:30 borderColor:[UIColor whiteColor]];
    }];
   
    

}
-(void)setupAuthorLb{
    self.authorLb = [[UILabel alloc]init];
    self.authorLb.textColor = [UIColor whiteColor];
    self.authorLb.text = _song.artistName;
    [self addSubview:_authorLb];
   }
-(void)setupAlbumImageView{
    
    _albumImageView = [[UIImageView alloc]init];
    _albumImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showLRC)];
    [_albumImageView  addGestureRecognizer:tp];
    [self addSubview:_albumImageView];
}
-(void)setupOperationView{
    NSArray *images1 = @[@"love",@"download",@"comment",@"list"];
    _operationView = [[LXOperationSongView alloc] init];
    _operationView.images = images1;
    _operationView.clos = images1.count;
    _operationView.titles = @[@"",@"",@"",@""];
    _operationView.width = 30;
    _operationView.height = 30;
    _operationView.delegate = self;
    [_operationView setupOperationSongView];
    [self addSubview:_operationView];

}
//开始
- (void)startRotating
{
    if (self.link) return;
    
    // 1秒内刷新60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

//停止
- (void)stopRotating
{
    [self.link invalidate];
    self.link = nil;
}

//刷新
- (void)update
{
    self.albumImageView.transform = CGAffineTransformRotate(self.albumImageView.transform, M_PI / 500);
    
}

-(void)LXOperationSongViewButtonClick:(LXHorizontalButton *)sender{
    [self.delegate LXImageContentViewClickButton:sender];
}
-(void)showLRC{
    [self.delegate LXImageContentViewTouchImage];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_authorLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(70);
        make.height.equalTo(30);
        make.top.equalTo(0);
        make.width.equalTo(0);
    }];
    [_albumImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(60);
        make.right.equalTo(self.right).offset(-60);;
        make.height.equalTo(self.albumImageView.width);
        make.centerY.equalTo(self.centerY);
    }];
    [_operationView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.bottom).offset(-10);
        make.height.equalTo(45);
    }];
}

@end
