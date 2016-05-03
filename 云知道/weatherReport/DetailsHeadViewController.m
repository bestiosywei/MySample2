//
//  DetailsHeadViewController.m
//  weatherReport
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "DetailsHeadViewController.h"

@interface DetailsHeadViewController ()

@end

@implementation DetailsHeadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self headInfo];
}
-(void)headInfo{
    //取出城市字典
    if ([[_weatherInfoDic objectForKey:@"reason"] isEqualToString:@"successed!"] ||[[_weatherInfoDic objectForKey:@"reason"] isEqualToString:@"查询成功"]) {
        NSMutableDictionary *dic=[[_weatherInfoDic objectForKey:@"result"] objectForKey:@"data"];
        //当前天气信息字典
        NSDictionary *realtimeDic=[dic objectForKey:@"realtime"];
        //温度
        self.lbDetailsTemperature.text=[NSString stringWithFormat:@"%@℃",[[realtimeDic objectForKey:@"weather"] objectForKey:@"temperature"] ];
        //风
        self.lbDetailsWind.text=[NSString stringWithFormat:@"%@%@",[[realtimeDic objectForKey:@"wind"] objectForKey:@"direct"],[[realtimeDic objectForKey:@"wind"] objectForKey:@"power"] ];
        //天气信息
        self.lbDetailsWeather.text=[NSString stringWithFormat:@"%@",[[realtimeDic objectForKey:@"weather"] objectForKey:@"info"]];
        //湿度
        self.lbDetailsMoisture.text=[NSString stringWithFormat:@"湿度：%@%%",[[realtimeDic objectForKey:@"weather"] objectForKey:@"humidity"]];
        //生活信息字典
        NSDictionary *lifeDic=[dic objectForKey:@"life"];
        //紫外线
        self.lbDetailsUltraviolet.text=[NSString stringWithFormat:@"紫外线：%@", [[[lifeDic objectForKey:@"info"] objectForKey:@"ziwaixian"] objectAtIndex:0] ];
        self.lbWear.text=@"穿衣";
        self.lbDetailsColdOrHot.text=[NSString stringWithFormat:@"%@", [[[lifeDic objectForKey:@"info"] objectForKey:@"chuanyi"] objectAtIndex:0] ];
        self.lbDetailsPrompt.text=[NSString stringWithFormat:@"%@", [[[lifeDic objectForKey:@"info"] objectForKey:@"chuanyi"] objectAtIndex:1] ];
        //PM2.5 字典
        NSDictionary *dicPM25=[dic objectForKey:@"pm25"];
        if (dicPM25.count) {
             self.lbPm2d5.text=@"PM2.5";
            NSDictionary *pm25Dic=[[dic objectForKey:@"pm25"] objectForKey:@"pm25"];
            self.imgDetailsPm2d5.image=[UIImage imageNamed:[NSString stringWithFormat:@"pm2d5_%i",[[pm25Dic objectForKey:@"level"] intValue]] ];
        }else{
            self.lbPm2d5.text=@"暂无PM2.5信息";
        }
    }
    
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
