//
//  LXMusicTool.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/12/4.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXMusicTool.h"
static LXMusicTool *_musicTool=nil;
static NSArray *_musics;
static LXSong *_playingMusic;
@implementation LXMusicTool
+(LXMusicTool *)shareMisicTool{
    dispatch_once_t token;
    dispatch_once(&token, ^{
        if (_musicTool == nil) {
            _musicTool = [[LXMusicTool alloc]init];
        }
    });
    return _musicTool;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (_musicTool == nil) {
            _musicTool = [super allocWithZone:zone];
        }
        
    });
    return _musicTool;
}
-(id)copy{
    return self;
}
-(id)mutableCopy{
    return self;
}

-(void)setPlayingMusic:(LXSong *)playingMusic{
    if ((!playingMusic ||[self.musics containsObject:playingMusic])) {
        return;
    }
    if (_playingMusic == playingMusic) {
        return;
    }
    _playingMusic = playingMusic;
}
-(LXSong *)nextMusic{
    int nextIndex = 0;
    if (!_playingMusic) {
        int playintgIndex = (int)[self.musics indexOfObject:_playingMusic];
        nextIndex = playintgIndex+1;
        if (nextIndex>=self.musics.count) {
            nextIndex = 0;
        }
    }
    return self.musics[nextIndex];
}
-(LXSong *)previousMusic{
    int previousIndex = 0;
    if (_playingMusic) {
        int playingIndex = (int)[self.musics indexOfObject:_playingMusic];
        previousIndex = playingIndex -1;
        if (previousIndex<0) {
            previousIndex = (int)self.musics.count-1;
        }
        
    }
    return self.musics[previousIndex];
}
@end
