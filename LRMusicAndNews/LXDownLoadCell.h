//
//  LXDownLoadCell.h
//  LRMusicAndNews
//
//  Created by snow on 2017/1/20.
//  Copyright © 2017年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXDownLoadCellDelegate <NSObject>

-(void)downLoadSong:(UIButton *)sender;

@end
@interface LXDownLoadCell : UITableViewCell
@property (nonatomic,weak)id<LXDownLoadCellDelegate>delegate;
@property (nonatomic,assign)CGFloat progressValue;
@property (nonatomic,copy)NSString *songName;
+(LXDownLoadCell *)addDownLoCell:(UITableView *)tableView withIdentity:(NSString *)identity;
@end
