//
//  WeatherInfoViewController.m
//  weatherReport
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "WeatherInfoViewController.h"
#import "DetailsCell.h"
#import "DetailsHeadViewController.h"
#import "DBInsertCity.h"
#import "SBJsonParser.h"

#warning 更换key
//这里需要一个key，这个key可以在聚合数据申请https://www.juhe.cn/docs/api/id/73   免费的.
static NSString * const juheKey = @"";
@interface WeatherInfoViewController ()
{
    NSMutableDictionary *_weatherInfoDic;
    NSMutableData*_responseData;
    NSMutableArray *_otherCity;
}
@end

@implementation WeatherInfoViewController

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
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.title=_cityName;
    _otherCity=[NSMutableArray array];
    //请求数据
    NSString*requestStr=[NSString stringWithFormat:@"http://op.juhe.cn/onebox/weather/query?key=%@&dtype=json&cityname=%@",juheKey,_cityName];
    NSString*encoding=[requestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //转成utf8
    NSURL*url=[NSURL URLWithString:encoding];
    //通过URL转成NSURLRequest的对象
    NSURLRequest*request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    //建立一个已补请求
    NSURLConnection*connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (connection==nil) {
        NSLog(@"请求错误");
    }

}


#pragma mark NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
   
    _responseData=[NSMutableData data];
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);

}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_responseData appendData:data];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *error;
    _weatherInfoDic=[NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&error];
    if (_weatherInfoDic!=nil) {
        //添加到数据库
        if ([[_weatherInfoDic objectForKey:@"reason"] isEqualToString:@"successed!"] ||[[_weatherInfoDic objectForKey:@"reason"] isEqualToString:@"查询成功"]) {
            NSString *responseStr=[[NSString alloc]initWithData:_responseData encoding:NSUTF8StringEncoding];
            if(![[DBInsertCity shareDBInsertCity]insertCity:_cityName cityInfo:responseStr]){
                NSLog(@"添加失败");
            }
        NSDictionary *dic=[[_weatherInfoDic objectForKey:@"result"] objectForKey:@"data"];
        //后6天天气信息字典
        NSArray *weatherArr=[dic objectForKey:@"weather"];
            for (int i=1; i<weatherArr.count; i++) {
                NSDictionary *dic=[weatherArr objectAtIndex:i];
                [_otherCity addObject:dic];
            }
            [_tbInfoView reloadData];
        }else{
            
//            NSLog(@"%@",[_weatherInfoDic objectForKey:@"reason"]);
        }
    }
}


#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _otherCity.count;
}
//页眉view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIStoryboard *story=[UIStoryboard  storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailsHeadViewController * controller=[story instantiateViewControllerWithIdentifier:@"DetailsHead"];
    controller.weatherInfoDic=_weatherInfoDic;
    return controller.view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 185;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cell";
    DetailsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"DetailsCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //天气信息
    NSDictionary *dic=[_otherCity objectAtIndex:indexPath.row];
    //早、中、晚天气信息
    NSDictionary *timeDic=[dic  objectForKey:@"info"];
    cell.lbWeekDay.text=[dic objectForKey:@"week"];
    //早，天气信息
    NSArray *arrDawn=[timeDic objectForKey:@"dawn"];
    cell.imgMorning.image=[UIImage imageNamed:[NSString stringWithFormat:@"w%@.png",[arrDawn objectAtIndex:0]]];
    cell.lbMorningWeather.text=[NSString stringWithFormat:@"%@℃%@",[arrDawn objectAtIndex:2],[arrDawn objectAtIndex:4]];
    
    //中，天气信息
    NSArray *arrDay=[timeDic objectForKey:@"day"];
    cell.imgMidday.image=[UIImage imageNamed:[NSString stringWithFormat:@"w%@.png",[arrDay objectAtIndex:0]]];
    cell.lbMiddayWeather.text=[NSString stringWithFormat:@"%@℃%@",[arrDay objectAtIndex:2],[arrDay objectAtIndex:4]];
    
    //晚，天气信息
    NSArray *arrNight=[timeDic objectForKey:@"night"];
    cell.imgNight.image=[UIImage imageNamed:[NSString stringWithFormat:@"w%@.png",[arrNight objectAtIndex:0]]];
    cell.lbNightWeather.text=[NSString stringWithFormat:@"%@℃%@",[arrNight objectAtIndex:2],[arrNight objectAtIndex:4]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 62;
}


//跳转
-(IBAction)addCity:(id)sender{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *con=[story instantiateViewControllerWithIdentifier:@"search"];
    
    [self presentViewController:con animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
