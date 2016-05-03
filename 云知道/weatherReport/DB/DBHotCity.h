//
//  DBHotCity.h
//  weatherReport
//
//  Created by Lxrent201 on 15/9/24.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHotCity : NSObject



+(DBHotCity *)shareDBHotCity;

-(NSMutableArray *)SelectHotCity; //查询热门城市

@end
