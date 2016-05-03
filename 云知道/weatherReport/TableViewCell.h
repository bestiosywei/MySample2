//
//  TableViewCell.h
//  weatherReport
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIImageView *lbWeatherImg;  //天气图片
@property(nonatomic,weak) IBOutlet UILabel *lbTemperature; //温度
@property(nonatomic,weak) IBOutlet UILabel *lbCityName; //城市
@property(nonatomic,weak) IBOutlet UIImageView *lbPm2d5Img; //PM2.5图片
@property(nonatomic,weak) IBOutlet UILabel *lbPm2d5; //PM2.5

@end
