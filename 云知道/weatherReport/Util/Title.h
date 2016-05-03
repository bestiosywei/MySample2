//
//  Title.h
//  单例提示框.
//
//  Created by apple on 15/7/13.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Title : NSObject
{
    UIView *view1;
    UILabel * lb;
    NSString *_str;  //提示文本内容
    NSTimer *_timer; //计时器，控制隐藏
    int  _number; //持续时间
    BOOL change;
}
+(Title *)shareTitle;
-(void)setTitle:(NSString*)sender andDuration:(int)sender; //传递文本内容,显示时间
-(void)show; //显示提示框
@end
