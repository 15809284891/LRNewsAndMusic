//
//  LXGetLRCData.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/15.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXGetLRCData.h"
#import "LXSong.h"
#import "LXLRC.h"
@interface LXGetLRCData()
@property (nonatomic,strong)NSMutableArray *lrcArray;
@end
@implementation LXGetLRCData

-(NSArray *)lrcArray{
    if (!_lrcArray) {
        _lrcArray = [NSMutableArray array];
    }
    return _lrcArray;
}

-(void)getLRCarray:(LXSong *)song :(LXGetLRCDataBlock)block{
    if (song.lrcLink.length== 0) {
        block(nil);
    }
    else{
    NSString *cachePayh = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *savePath = [cachePayh stringByAppendingString:song.songName];
    BOOL result = [[NSFileManager defaultManager]fileExistsAtPath:savePath];
    if (result) {
        NSString *str = [NSString stringWithContentsOfFile:savePath encoding:NSUTF8StringEncoding error:nil];
        [self parseLrc:str];
        block(self.lrcArray);
    }
    
    else{
        NSURL *url = [NSURL URLWithString:song.lrcLink];
        NSURLRequest *req = [[NSURLRequest alloc]initWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:req completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSError *saveError;
                NSURL *saveURL = [NSURL fileURLWithPath:savePath];
                [[NSFileManager defaultManager]copyItemAtURL:location toURL:saveURL error:&saveError];
                if (!saveError) {
                    NSString *str = [NSString stringWithContentsOfFile:savePath encoding:NSUTF8StringEncoding error:nil];
                    [self parseLrc:str];
                    block(self.lrcArray);
                }
                else{
                    NSLog(@"下载失败  %@",cachePayh);
                }
                
            }
            
        }];
        [downLoadTask resume];
    }
    }

}

-(void)parseLrc:(NSString*)lrc{
      if (![lrc isEqualToString:nil]) {
              NSArray *seprray = [lrc componentsSeparatedByString:@"["];
            NSArray *lineArray = [[NSArray alloc]init];
        for (int i = 0; i<seprray.count; i++) {
            
            lineArray = [seprray[i] componentsSeparatedByString:@"]"];
            
            if (![lineArray[0] isEqualToString:@"\n"]) {
                
                LXLRC *lrc = [[LXLRC alloc]init ];
                
                lrc.time = lineArray[0];
                
                lrc.content = lineArray.count>1?lineArray[1]:@"";
                
                [self.lrcArray addObject:lrc];
                
            }
            
        }
        
    }
    
}



@end

