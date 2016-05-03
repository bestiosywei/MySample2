//
//  Path.m
//  超值购
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "Path.h"

@implementation Path


+(NSString *)path:(NSString *)fileName{
    NSString *path=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),fileName];
    return path;
}



@end
