//
//  LXDownLoadTool.m
//  LRMusicAndNews
//
//  Created by snow on 2017/1/20.
//  Copyright © 2017年 ***REMOVED***. All rights reserved.
//

#import "LXDownLoadTool.h"

@implementation LXDownLoadTool
+ (void)initialize
{
}
-(LXDownLoadTool *)shareDownLoadTool{
    static LXDownLoadTool *_downLodTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downLodTool = [[LXDownLoadTool alloc]init];
    });
    return _downLodTool;
}

@end
