//
//  LXMusicController.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXOnlineMusicController.h"
#import "LXRankMenuController.h"
#import "LXNewSongController.h"
#import "LXSongMenuController.h"
#import "LXGradientButton.h"
#import "LXnavigationController.h"
@interface LXOnlineMusicController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIScrollView *scrollerView;
@property (nonatomic,strong) UIView *titleViews;
@property (nonatomic,strong) UIView *indicator;
@property (nonatomic, assign)BOOL isCanUseSideBack;  // 手势是否启动
//@property (nonatomic, assign)BOOL isCanSideBack;  // 手势是否启动
@property (nonatomic,strong) LXGradientButton *indicatorBT;

@end
@implementation LXOnlineMusicController
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self cancelSideBack];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self startSideBack];
}

/**
 * 关闭ios右滑返回
 */
-(void)cancelSideBack{
    self.isCanUseSideBack = NO;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    }
}
/*
 开启ios右滑返回
 */
- (void)startSideBack {
    self.isCanUseSideBack=YES;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的音乐";
        _titles = @[@"排行榜",@"歌单",@"个性推荐"];
           }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LXBacColor;
    [self setUpNavigation];
    [self addChildControllers];
    [self setUpTitleViews];
    [self setUpScrollerView];
}
-(void)setUpNavigation{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = MainColor;
    [self.view addSubview:view];
//    self.navigationController.navigationBar.barTintColor = MainColor;
    //设置字体颜色以及大小
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18.0];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];

}
//添加子控制器
-(void)addChildControllers{
    LXRankMenuController *songRankV = [[LXRankMenuController alloc]init];
    [self addChildViewController:songRankV];
    LXSongMenuController *songListV = [[LXSongMenuController alloc]init];
    [self addChildViewController:songListV];
    LXNewSongController *newSongV = [[LXNewSongController alloc]init];
    [self addChildViewController:newSongV];
}
//初始化标签view
-(void)setUpTitleViews{
    _titleViews = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ViewWidth, 30)];
    _titleViews.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [self.view addSubview:_titleViews];
    CGFloat width =ViewWidth/3.0;
    CGFloat height = self.titleViews.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i<self.childViewControllers.count; i++) {
                x = i*width;
        LXGradientButton *button = [[LXGradientButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
         [self.titleViews addSubview:button];
        if (i==0) {
            CGRect frame = _indicator.frame;
            frame.origin.x = i;
            _indicator.frame = frame;
             self.indicatorBT = button;
            self.indicatorBT.selected = YES;
            self.indicatorBT.scale = 1;
        }
    }
    _indicator = [[UIView alloc]initWithFrame:CGRectMake(0, 64+28, self.view.frame.size.width/3.0, 2)];
    _indicator.backgroundColor = MainColor;
    [self.view addSubview:_indicator];
}
-(void)setUpScrollerView{
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ViewWidth, ViewHeight)];
    _scrollerView.backgroundColor = LXBacColor;
    _scrollerView.pagingEnabled = YES;
    _scrollerView.delegate = self;
    _scrollerView.contentSize = CGSizeMake(self.scrollerView.frame.size.width*self.childViewControllers.count, self.scrollerView.frame.size.height);
    [self.view insertSubview:_scrollerView belowSubview:self.titleViews];
    //一开始告诉scrollerView我的动画结束了
    [self scrollViewDidEndScrollingAnimation:self.scrollerView];
   
}
//切换view
-(void)changeView:(LXGradientButton *)sender{
    self.indicatorBT.selected = NO;
    sender.selected = !sender.selected;
    self.indicatorBT = sender;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.indicator.frame;
     
        frame.origin.x = sender.tag*(ViewWidth/3.0);
        self.indicator.frame = frame;
    }];
    //设置偏移量
    [self.scrollerView setContentOffset:CGPointMake(sender.tag*ViewWidth, 0) animated:YES];
}

#pragma mark - UIScrollerViewDelegate
//滚动动画完毕后会调用，如果不是人为拖拽导致滚动调用完毕，才会调用这个方法，比如这个动画完毕会会调用  [self.scrollerView setContentOffset:CGPointMake(sender.tag*self.scrollerView.width, 0) animated:YES];
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat contenX = self.scrollerView.contentOffset.x;
    NSInteger index = contenX/ViewWidth;
    UIViewController *viewVc = self.childViewControllers[index];
    //如果这个controller的view已经被加载过，无需再次加载
    if (viewVc.isViewLoaded)
        return;
    viewVc.view.frame = CGRectMake(index*scrollView.frame.size.width, 30, scrollView.frame.size.width, scrollView.frame.size.height);
    [self.scrollerView addSubview:viewVc.view];
}

//  滚动完毕会调用，如果是人为拖拽scrollerView导致滚动完毕，才会调用这个方法，人为触发
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //手放开告诉动画结束
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = self.scrollerView.contentOffset.x/self.scrollerView.frame.size.width;
    //改变选中的button
    [self changeView:self.titleViews.subviews[index]];
}
//实时监控滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scale = scrollView.contentOffset.x/scrollView.frame.size.width;//小数部分是右边的比例
    NSInteger leftIndex =scrollView.contentOffset.x/scrollView.frame.size.width;
    CGFloat rightScale = scale - leftIndex;
    CGFloat leftScale  =1-rightScale;
    NSInteger rightIndex ;
    if (leftIndex <self.titleViews.subviews.count-1) {
        rightIndex = leftIndex+1;
    }
    else
        return;
    LXGradientButton *leftBt = self.titleViews.subviews[leftIndex];
    leftBt.scale = leftScale;
    LXGradientButton *rightBt = self.titleViews.subviews[rightIndex];
    rightBt.scale = rightScale;
    CGRect frame = self.indicator.frame;
    frame.origin.x = scale*(ViewWidth/3.0);
    self.indicator.frame = frame;
}

@end
