//
//  LXQueuePlayer.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/19.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import "LXQueuePlayer.h"

@implementation LXQueuePlayer
static LXQueuePlayer *queuePlayer = nil;
+(LXQueuePlayer *)shareQueuePlayer{
  
    if (nil == queuePlayer) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            queuePlayer = [[LXQueuePlayer alloc]init];
        });

    }
      return queuePlayer;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (queuePlayer == nil) {
            queuePlayer = [super allocWithZone:zone];
        }
    });
    return queuePlayer;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(id)copy{
    return self;
}
-(id)mutableCopy{
    return self;
}
@end
