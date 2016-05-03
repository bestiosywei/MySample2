//
//  DetailsHeadViewController.h
//  weatherReport
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsHeadViewController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property(nonatomic,weak) IBOutlet UILabel *lbDetailsWeather; //天气
@property(nonatomic,weak) IBOutlet UILabel *lbDetailsTemperature; //温度
@property(nonatomic,weak) IBOutlet UIImageView *imgDetailsPm2d5; //PM2.5
@property(nonatomic,weak) IBOutlet UILabel *lbDetailsColdOrHot;  //冷热
@property(nonatomic,weak) IBOutlet UILabel *lbDetailsPrompt;  //穿衣提示
@property(nonatomic,weak) IBOutlet UILabel *lbDetailsWind;   //风向
@property(nonatomic,weak) IBOutlet UILabel *lbDetailsUltraviolet; //紫外线
@property(nonatomic,weak) IBOutlet UILabel *lbDetailsMoisture;  //湿度

@property(nonatomic,weak) IBOutlet UILabel *lbPm2d5; //pm2.5
@property(nonatomic,weak) IBOutlet UILabel *lbWear; //穿衣提示

@property (nonatomic, assign)NSDictionary *weatherInfoDic;
@end
