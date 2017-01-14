//
//  LXTableViewCell.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/27.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXSong;
@protocol LXTableViewCellDelegate <NSObject>
-(void)cellListClickEvent:(UIButton *)btn;
@end
@interface LXTableViewCell : UITableViewCell
@property (nonatomic,strong)LXSong *song;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,weak)id<LXTableViewCellDelegate>delegate;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)UIView  *rightView;
@property (nonatomic,strong)UIView *leftView;
+(  LXTableViewCell *)addLXtableViewCell:(UITableView *)tableView withIdentity:(NSString *)identity;

-(void)initLeftView;
@end


