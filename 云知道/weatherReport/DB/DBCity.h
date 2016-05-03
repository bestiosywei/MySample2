//
//  DBCity.h
//  weatherReport
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBCity : NSObject



+(DBCity *)shareDBCity;

-(NSMutableArray *)selectLikeCityArray:(NSString *)seachContent;

@end
