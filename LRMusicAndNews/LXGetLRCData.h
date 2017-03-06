//

//  LXGetLRCData.h

//  LRMusicAndNews

//

//  Created by    karisli on 16/12/15.

//  Copyright © 2016年 lixue. All rights reserved.

//



#import <UIKit/UIKit.h>

@class LXSong;

typedef void(^LXGetLRCDataBlock ) (NSArray*lrcArray);

@interface LXGetLRCData : UITableView

-(void)getLRCarray:(LXSong *)song :(LXGetLRCDataBlock)block;

@end

