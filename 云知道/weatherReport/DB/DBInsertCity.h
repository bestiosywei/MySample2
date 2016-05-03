//
//  DBInsertCity.h
//  weatherReport
//
//  Created by Lxrent201 on 15/9/24.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBInsertCity : NSObject

+(DBInsertCity *)shareDBInsertCity;


-(BOOL)insertCity:(NSString *)cityName cityInfo:(NSString *)cityData;

@end
