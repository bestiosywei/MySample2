//
//  ViewController.m
//  weatherReport
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "WeatherInfoViewController.h"
#import "CityWeatherInfo.h"
#import "DBSelectMyCity.h"
#import "CityWeatherInfo.h"
#import "SBJsonParser.h"
@interface ViewController ()
{
    NSArray *_cityArray;

}
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
     _cityArray=[[DBSelectMyCity shareDBSelectMyCity]SelectMyCity];
    [_tbView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};

//适配
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];

    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
     _cityArray=[[DBSelectMyCity shareDBSelectMyCity]SelectMyCity];
 
    
 
}




-(void)search:(NSNotification *)sener{
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    WeatherInfoViewController *weather=[story instantiateViewControllerWithIdentifier:@"weatherInfo"];
    weather.cityName=sener.object;
    [self.navigationController pushViewController:weather animated:YES];

    
    
}

#pragma mark tableView
//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cell";
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    CityWeatherInfo *cityInfo=[_cityArray objectAtIndex:indexPath.row];
    //取出城市字典
    SBJsonParser *json=[[SBJsonParser alloc]init];
    NSDictionary *muDic=[json objectWithString:cityInfo.cityInfo];
    
        NSMutableDictionary *dic=[[muDic objectForKey:@"result"] objectForKey:@"data"];
        //当前天气信息字典
        NSDictionary *realtimeDic=[dic objectForKey:@"realtime"];
        cell.lbCityName.text=[realtimeDic objectForKey:@"city_name"];
        cell.lbTemperature.text=[NSString stringWithFormat:@"%@℃",[[realtimeDic objectForKey:@"weather"] objectForKey:@"temperature"] ];
        cell.lbWeatherImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"w%i",[[[realtimeDic objectForKey:@"weather"] objectForKey:@"img"] intValue]]];
        //PM2.5 字典
    NSDictionary *dicPM25=[dic objectForKey:@"pm25"];
    if (dicPM25.count) {
        NSDictionary *pm25Dic=[[dic objectForKey:@"pm25"] objectForKey:@"pm25"];
        cell.lbPm2d5.text=[NSString stringWithFormat:@"PM2.5：%@",[pm25Dic objectForKey:@"pm25"]];
        cell.lbPm2d5Img.image=[UIImage imageNamed:[NSString stringWithFormat:@"pm2d5_%i",[[pm25Dic objectForKey:@"level"] intValue]]];

    }
    
    return cell;
}
//点击cell后执行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    WeatherInfoViewController *weather=[story instantiateViewControllerWithIdentifier:@"weatherInfo"];
    weather.cityName=((CityWeatherInfo *)[_cityArray objectAtIndex:indexPath.row]).cityName;
    [self.navigationController pushViewController:weather animated:YES];
}
#pragma mark UITableView 删除

//选择编辑模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
//设置不可 编辑

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    CityWeatherInfo *city=[_cityArray objectAtIndex:indexPath.row];
    [[DBSelectMyCity shareDBSelectMyCity]deleteCity:city.cityName];
    _cityArray=[[DBSelectMyCity shareDBSelectMyCity]SelectMyCity];
    [_tbView reloadData];
    
}





#pragma mark 添加城市
-(IBAction)addCity:(id)sender{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *con=[story instantiateViewControllerWithIdentifier:@"search"];
    [self presentViewController:con animated:YES completion:nil];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
