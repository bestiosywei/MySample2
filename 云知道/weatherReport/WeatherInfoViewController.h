//
//  WeatherInfoViewController.h
//  weatherReport
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,weak)IBOutlet UITableView *tbInfoView;

@property (nonatomic, copy) NSString *cityName;

@end
