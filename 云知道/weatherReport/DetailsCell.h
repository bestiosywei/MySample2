//
//  DetailsCell.h
//  weatherReport
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel *lbWeekDay;
@property(nonatomic,weak) IBOutlet UILabel *lbMorningWeather;
@property(nonatomic,weak) IBOutlet UILabel *lbMiddayWeather;
@property(nonatomic,weak) IBOutlet UILabel *lbNightWeather;
@property(nonatomic,weak) IBOutlet UIImageView *imgMorning;
@property(nonatomic,weak) IBOutlet UIImageView *imgMidday;
@property(nonatomic,weak) IBOutlet UIImageView *imgNight;

@end
