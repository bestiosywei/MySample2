//
//  DBCity.m
//  weatherReport
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "DBCity.h"
#import "Path.h"
#import <sqlite3.h>
DBCity *singleInstance;
@implementation DBCity

{
    sqlite3 *_database;
}


+(DBCity *)shareDBCity{
    @synchronized(self){
        if (singleInstance==nil) {
            singleInstance=[[DBCity alloc]init];
        }
    }
    return singleInstance;
}

-(NSMutableArray *)selectLikeCityArray:(NSString *)seachContent{
    NSMutableArray *muArray=[NSMutableArray array];
    
    if (![self openDB]) {
         NSLog(@"打开失败");
    }
    
    sqlite3_stmt *statement;
    
    NSString *selectStr=[NSString stringWithFormat:@"SELECT cityName FROM citys WHERE  cityCode LIKE   '%%%@%%' OR cityName LIKE '%%%@%%'",seachContent,seachContent];
    if (sqlite3_prepare(_database, [selectStr UTF8String], -1, &statement, nil)==SQLITE_OK) {
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *cityName=(char *)sqlite3_column_text(statement, 0);
            if (cityName) {
                NSString *city=[NSString stringWithUTF8String:cityName];
                [muArray addObject:city];
            }
        }
    }else{
        NSLog(@"预编译失败");
        return nil;
    }
    sqlite3_finalize(statement);
    sqlite3_close(_database);
    return muArray;
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
