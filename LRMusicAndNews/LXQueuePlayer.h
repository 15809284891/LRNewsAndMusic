//
//  LXQueuePlayer.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/19.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface LXQueuePlayer : AVQueuePlayer
+(LXQueuePlayer *)shareQueuePlayer;
@end
