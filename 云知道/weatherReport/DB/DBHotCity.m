//
//  DBHotCity.m
//  weatherReport
//
//  Created by Lxrent201 on 15/9/24.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "DBHotCity.h"
#import "Path.h"
#import "CityWeatherInfo.h"
#import <sqlite3.h>

DBHotCity *singleDBHotCity;
@implementation DBHotCity
{
    sqlite3 *_database;
}

+(DBHotCity *)shareDBHotCity{
    @synchronized(self){
        if (singleDBHotCity==nil) {
            singleDBHotCity=[[DBHotCity alloc]init];
        }
    }
    return singleDBHotCity;
}



-(NSMutableArray *)SelectHotCity{
    
    if (![self openDB]) {
        NSLog(@"数据库打开失败");
    }
    
    sqlite3_stmt *statement;
    NSString *sql=@"SELECT * FROM tb_hotCity";
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, nil)!=SQLITE_OK) {
        NSLog(@"预编译失败");
    }
    NSMutableArray *myCity=[NSMutableArray array];
    while (sqlite3_step(statement)==SQLITE_ROW) {
        NSString *cityName=@"";
        char *city_name=(char *)sqlite3_column_text(statement, 0);
        if (city_name) {
            cityName=[NSString stringWithUTF8String:city_name];
        }
        [myCity addObject:cityName];
    }
    sqlite3_finalize(statement);
    sqlite3_close(_database);
    return myCity;
    
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
