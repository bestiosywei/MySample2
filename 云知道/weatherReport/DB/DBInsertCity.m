//
//  DBInsertCity.m
//  weatherReport
//
//  Created by Lxrent201 on 15/9/24.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "DBInsertCity.h"
#import "Path.h"
#import <sqlite3.h>
DBInsertCity *singleInstance1;
@implementation DBInsertCity
{
    sqlite3 *_database;
}

+(DBInsertCity *)shareDBInsertCity{
    @synchronized(self){
        if (singleInstance1==nil) {
            singleInstance1=[[DBInsertCity alloc]init];
        }
    }
    return singleInstance1;
}


-(BOOL)insertCity:(NSString *)cityName cityInfo:(NSString *)cityInfo{
    if (![self openDB]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    sqlite3_stmt *statement1;
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM tb_cityInfo WHERE city_name='%@'",cityName];
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement1, nil)!=SQLITE_OK) {
        NSLog(@"预编译失败");
    }
    
    if (sqlite3_step(statement1)==SQLITE_ROW) {
       
        NSString *sql=[NSString stringWithFormat:@"UPDATE tb_cityInfo SET city_info='%@' WHERE city_name='%@'",cityInfo,cityName];
        char *error;
        if (sqlite3_exec(_database, [sql UTF8String], nil, nil, &error)!=SQLITE_OK) {
            NSLog(@"修改失败");
            sqlite3_close(_database);
            return NO;
        }
        sqlite3_finalize(statement1);
        sqlite3_close(_database);
        return YES;
    
    } else {
        sqlite3_stmt *statement;
        NSString *sql1=@"INSERT INTO tb_cityInfo(city_name,city_info) VALUES(?,?)";
        if (sqlite3_prepare_v2(_database, [sql1 UTF8String], -1, &statement, nil)!=SQLITE_OK) {
            NSLog(@"预编译失败");
            return NO;
        }
        sqlite3_bind_text(statement, 1, [cityName UTF8String], -1, nil);
        sqlite3_bind_text(statement, 2, [cityInfo UTF8String], -1, nil);
        if (sqlite3_step(statement)==SQLITE_ERROR) {
            NSLog(@"插入失败");
            sqlite3_finalize(statement);
            sqlite3_close(_database);
            return NO;
        }
        sqlite3_finalize(statement1);
        sqlite3_finalize(statement);
        sqlite3_close(_database);
        return YES;
  
    }
}









-(BOOL)openDB{
    NSString *path=[Path path:@"Citys"];
    if (sqlite3_open([path UTF8String], &_database)==SQLITE_OK) {
        return YES;
    }else{
        return NO;
    }
    
}
@end
