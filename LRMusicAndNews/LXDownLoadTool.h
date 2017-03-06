//
//  LXDownLoadTool.h
//  LRMusicAndNews
//
//  Created by snow on 2017/1/20.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDownLoadTool : NSObject
@property (nonatomic,strong)NSMutableDictionary *downLoadDic;
-(LXDownLoadTool *)shareDownLoadTool;
@end
