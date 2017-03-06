//
//  LXDatabase.m
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/24.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXDatabase.h"
#import "sqlite3.h"
#import "LXSongMenu.h"
static NSString *dataBaseName = @"musicDataBase";
@implementation LXDatabase
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(NSString *)dataFilePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [path objectAtIndex:0];
    return [document stringByAppendingPathComponent:dataBaseName];
}
-(BOOL)openDataBase{
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath]UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"open database faild");
        NSLog(@"数据库创建失败");
        return NO;
    }
    NSLog(@"--创建成功");
    return YES;
}
//-(BOOL)createTable{
//    
////    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS SONGMENU ()"
//}
@end
