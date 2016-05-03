//
//  Title.m
//  单例提示框.
//
//  Created by apple on 15/7/13.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "Title.h"
#import "AppDelegate.h"
static Title *title=nil;
@implementation Title
+(Title *)shareTitle{
    @synchronized(self){
    if (title==nil) {
        title=[[Title alloc]init];
    }
    }
    return title;
}
-(void)setTitle:(NSString*)sender andDuration:(int)sender1{
     _str=sender;
    _number=sender1;
    [self show];
}

-(void)show{
    if (!change) {
        change=YES;
    UIFont *font=[UIFont systemFontOfSize:16];
    CGRect rect=[_str boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil ];
    lb=[[UILabel alloc]initWithFrame:CGRectMake(0,0, rect.size.width, rect.size.height)];
    lb.font=font;
    lb.textColor=[UIColor whiteColor];
    lb.numberOfLines=0;
    lb.text=_str;
    NSLog(@"%@",lb.text);
    view1=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height, rect.size.width+20, rect.size.height+20)];
    view1.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    view1.layer.cornerRadius=5.0f;
    view1.layer.masksToBounds=YES;
    view1.alpha=1;
    lb.center=CGPointMake(view1.bounds.size.width/2, view1.bounds.size.height/2);
    view1.backgroundColor=[UIColor blackColor];
    [view1 addSubview:lb];
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view1];
    _timer=[NSTimer scheduledTimerWithTimeInterval:_number target:self selector:@selector(remove) userInfo:nil repeats:NO];
    }else{
        UIFont *font=[UIFont systemFontOfSize:16];
        CGRect rect=[_str boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil ];
        lb.text=_str;
        lb.frame=CGRectMake(0,0, rect.size.width, rect.size.height);
        view1.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height, rect.size.width+20, rect.size.height+20);
        view1.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        lb.center=CGPointMake(view1.bounds.size.width/2, view1.bounds.size.height/2);
        [_timer invalidate];
        _timer=[NSTimer scheduledTimerWithTimeInterval:_number target:self selector:@selector(remove) userInfo:nil repeats:NO];
    }

}
-(void)remove{

    change=NO;
    [view1 removeFromSuperview];

}

@end
