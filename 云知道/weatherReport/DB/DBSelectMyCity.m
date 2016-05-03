//
//  DBSelectMyCity.m
//  weatherReport
//
//  Created by Lxrent201 on 15/9/24.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "DBSelectMyCity.h"
#import "Path.h"
#import "CityWeatherInfo.h"
#import <sqlite3.h>

DBSelectMyCity *singleDBSelectMyCity;
@implementation DBSelectMyCity
{
    sqlite3 *_database;
}

+(DBSelectMyCity *)shareDBSelectMyCity{
    @synchronized(self){
        if (singleDBSelectMyCity==nil) {
            singleDBSelectMyCity=[[DBSelectMyCity alloc]init];
        }
    }
    return singleDBSelectMyCity;
}







-(NSMutableArray *)SelectMyCity{
    
    if (![self openDB]) {
        NSLog(@"数据库打开失败");
    }
    
    sqlite3_stmt *statement;
    NSString *sql=@"SELECT * FROM tb_cityInfo ";
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, nil)!=SQLITE_OK) {
        NSLog(@"预编译失败");
    }
    NSMutableArray *myCity=[NSMutableArray array];
    while (sqlite3_step(statement)==SQLITE_ROW) {
        CityWeatherInfo *cityInfo=[[CityWeatherInfo alloc]init];
        char *city_name=(char *)sqlite3_column_text(statement, 0);
        char *city_info=(char *)sqlite3_column_text(statement, 1);
        if (city_name) {
            cityInfo.cityName=[NSString stringWithUTF8String:city_name];
        }
        if (city_info) {
            cityInfo.cityInfo=[NSString stringWithUTF8String:city_info];
            
        }
        [myCity addObject:cityInfo];
    }
    sqlite3_finalize(statement);
    sqlite3_close(_database);
    return myCity;
    
}

-(NSMutableArray *)SelectMyCityName{
    
    if (![self openDB]) {
        NSLog(@"数据库打开失败");
    }
    
    sqlite3_stmt *statement;
    NSString *sql=@"SELECT city_name FROM tb_cityInfo ";
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



-(BOOL)deleteCity:(NSString *)cityName{
    
    if (![self openDB]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    sqlite3_stmt *statement;
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM tb_cityInfo WHERE city_name='%@'",cityName];
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, nil)!=SQLITE_OK) {
        NSLog(@"预编译失败");
        return NO;
    }
    char *error;
    if (sqlite3_exec(_database, [sql UTF8String], nil, nil, &error)!=SQLITE_OK) {
        NSLog(@"删除失败");
        return NO;
    }

    sqlite3_finalize(statement);
    sqlite3_close(_database);
    return YES;
    
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
