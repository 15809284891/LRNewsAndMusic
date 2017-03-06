//
//  LXSongMenuCollectionViewCell.h
//  LRMusicAndNews
//
//  Created by snow on 2017/1/24.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXSongMenu;
@interface LXSongMenuCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)LXSongMenu *songMenu;
@property (nonatomic,assign)CGFloat imageWidth;
@end
