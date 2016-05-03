//
//  ViewController.h
//  weatherReport
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)IBOutlet UITableView *tbView;


@end
