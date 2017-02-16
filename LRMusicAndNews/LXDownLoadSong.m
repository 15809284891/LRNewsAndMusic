//
//  LXDownLoadSong.m
//  LRMusicAndNews
//
//  Created by snow on 2017/1/17.
//  Copyright © 2017年 ***REMOVED***. All rights reserved.
//

#import "LXDownLoadSong.h"
#import <AFURLSessionManager.h>
@interface LXDownLoadSong()<NSURLSessionDownloadDelegate>
@property(nonatomic,strong)NSURLSessionDownloadTask *task;
@property(nonatomic,strong)NSData *resumeData;
@property(nonatomic,strong)NSURLSession *session;
@end
@implementation LXDownLoadSong
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
//-(void)downFileWithURL:(NSString *)urlStr{
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSLog(@"%@",url);
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSLog(@"%@",request);
//    _downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        CGFloat progerss= 1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount;
//        NSLog(@"%lf",progerss);
//        [self.delegate getDownLoadProgress:progerss];
//        
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
//        NSLog(@"%@",path);
//        return [NSURL fileURLWithPath:path];
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
////        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
//NSFileManager *fileManager = [NSFileManager defaultManager];
//NSArray *tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:cachesPath error:nil]];
//        NSLog(@"%@",tempFileList);
////        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
////        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
////        NSLog(@"%@",);
//    }];
//    [_downLoadTask resume];
//}
//-(void)pauseDownloadWithURL:(NSString *)urlStr{
//    
//}
-(void)downFileWithURL:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session  = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //创建任务
    _task = [_session downloadTaskWithURL:url];
    //开始任务
    [_task resume];
}
-(void)continueDownLoad{
    self.task = [self.session downloadTaskWithURL:self.resumeData];
    [self.task resume];
}
-(void)pauseDownloadWithURL:(NSString *)urlStr{
    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
    }];
}
//下载后文件默认保存在tmp中，但是下载完成后会删除临时文件，所以将其移动到cahces中
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:NULL];
}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    NSLog(@"下载进度%lf",1.0*totalBytesWritten/totalBytesExpectedToWrite);
    NSString *progressStr = [NSString stringWithFormat:@"%lf",1.0*totalBytesWritten/totalBytesExpectedToWrite];
    
}
@end
