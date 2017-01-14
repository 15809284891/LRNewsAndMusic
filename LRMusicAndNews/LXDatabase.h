//
//  LXDatabase.h
//  LRMusicAndNews
//
//  Created by    karisli on 16/11/24.
//  Copyright © 2016年 ***REMOVED***. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDatabase : NSObject
/**
 *  返回当前应用程序的沙盒目录，将数据库保存在里面
 
 */
@property (nonatomic,strong)NSArray *songMenus;
-(NSString *)dataFilePath;
-(BOOL)openDataBase;
-(BOOL)createTable;
-(BOOL)insertData;
@end
