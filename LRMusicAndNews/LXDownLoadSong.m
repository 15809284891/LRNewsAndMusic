//
//  LXDownLoadSong.m
//  LRMusicAndNews
//
//  Created by snow on 2017/1/17.
//  Copyright © 2017年 ***REMOVED***. All rights reserved.
//

#import "LXDownLoadSong.h"
#import <AFURLSessionManager.h>
@implementation LXDownLoadSong
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)downFileWithURL:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"%@",url);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",request);
    _downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat progerss= 1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount;
        NSLog(@"%lf",progerss);
        [self.delegate getDownLoadProgress:progerss];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@",path);
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
NSFileManager *fileManager = [NSFileManager defaultManager];
NSArray *tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:cachesPath error:nil]];
        NSLog(@"%@",tempFileList);
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
//        NSLog(@"%@",);
    }];
    [_downLoadTask resume];
}
-(void)pauseDownloadWithURL:(NSString *)urlStr{
    
}
@end
