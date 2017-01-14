//
//  LXLRCTableView.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/14.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXLRCTableView.h"
#import "LXGetLRCData.h"
#import "LXLRC.h"
@interface LXLRCTableView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end
@implementation LXLRCTableView
int currentRow =0 ;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self seupTableView];
    }
    return self;
}
-(void)setCurrentTime:(NSString *)currentTime{
    _currentTime = currentTime;
    if (self.lrcArray.count!=0) {
        NSArray *arr1 = [_currentTime componentsSeparatedByString:@":"];
        CGFloat currentTime1 = [arr1[0] integerValue]*60 + [arr1[1] floatValue];
        int index;
        for (int i = currentRow; i<self.lrcArray.count; i++) {
            LXLRC *lrc = self.lrcArray[i];
            if (lrc.time.length<=0) {
                continue;
            }
            NSArray *arr = [lrc.time componentsSeparatedByString:@"."];
            NSString *str1 = arr[0];
            NSArray*arr2 = [str1 componentsSeparatedByString:@":"];
            CGFloat compTime = [arr2[0] integerValue]*60 + [arr2[1] floatValue];
            if (currentTime1 >=compTime)
            {
                currentRow = i;
            }
            else
            {
                break;
            }
        }
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
   
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [self seupTableView];
    }
    return self;
}
-(void)setLrcArray:(NSArray *)lrcArray{
    _lrcArray = lrcArray;
    [self.tableView reloadData];
}
-(void)seupTableView{
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = NO;
//    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:_tableView];
}
-(void)dismiss{
    [UIView animateWithDuration:1 animations:^{
        self.alpha  = 0;
    }];
    [self.delegate showImageContentView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    LXLRC *lrc=_lrcArray[indexPath.row];
    cell.textLabel.text = lrc.content;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    if (indexPath.row == currentRow) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _lrcArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35.0f;
}
@end
