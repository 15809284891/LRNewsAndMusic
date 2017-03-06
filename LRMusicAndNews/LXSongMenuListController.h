//
//  LXSongMenuListController.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/25.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXTableViewController.h"
@class LXSongMenu;
@class LXSongMenuDescripView;
@interface LXSongMenuListController : LXTableViewController
@property (nonatomic,strong)NSString *listID;
@property  (nonatomic,strong)LXSongMenu *songMenu;
@end
