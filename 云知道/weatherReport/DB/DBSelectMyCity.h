//
//  DBSelectMyCity.h
//  weatherReport
//
//  Created by Lxrent201 on 15/9/24.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBSelectMyCity : NSObject


+(DBSelectMyCity *)shareDBSelectMyCity;

-(NSMutableArray *)SelectMyCity; //查找城市
-(BOOL)deleteCity:(NSString *)cityName; //删除指定城市
-(NSMutableArray *)SelectMyCityName; //查询城市名






@end
