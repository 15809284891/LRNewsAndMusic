//
//  AppDelegate.m
//  LXMusicPlayer
//
//  Created by    karisli on 16/10/29.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "AppDelegate.h"
#import "LXMusicOperationView.h"
#import <AVFoundation/AVFoundation.h>
#import "LXOnlineMusicController.h"
#import "LXTabBarViewController.h"
#import <AFNetworkActivityIndicatorManager.h>
@interface AppDelegate ()
{
    UIBackgroundTaskIdentifier _bg_TakID;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    LXnavigationController*nav = [[LXnavigationController alloc]initWithRootViewController:[[LXOnlineMusicController alloc]init]];
//    [AFNetworkingactivi]
    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    self.window.rootViewController = [[LXTabBarViewController alloc]init];
    [self.window makeKeyAndVisible];
   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   //开启后台处理多媒体事件
    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    _bg_TakID= [AppDelegate backgroundPlayerID:_bg_TakID];
    
}
+(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)baTaskID{
    //设置并激活音频回话类别
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                   error:nil];
    //会话激活
    [session setActive:YES error:nil];
    //设置后台任务id
    UIBackgroundTaskIdentifier newTaskID = UIBackgroundTaskInvalid;
    newTaskID = [[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:nil];
    if (newTaskID != UIBackgroundTaskInvalid &&baTaskID != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication]endBackgroundTask:baTaskID];
    }
    return newTaskID;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
