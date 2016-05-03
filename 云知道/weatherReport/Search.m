//
//  Search.m
//  weatherReport
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import "Search.h"
#import "HotCityCollectionViewCell.h"
#import "DBCity.h"
#import "WeatherInfoViewController.h"
#import "DBHotCity.h"
#import "DBSelectMyCity.h"

@interface Search ()
{
    NSArray *array; //推荐数组
    NSArray *searchArray;   //检索结果的数组
    BOOL isSearch;  //搜索状态
    NSArray *myCityArry;
}
@end
#define hotCityCell @"hotCityCell"
@implementation Search

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    //我的数组
    myCityArry=[[DBSelectMyCity shareDBSelectMyCity]SelectMyCityName];
    [_CollectionHotCity reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //适配
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    //标题颜色
     self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    for (UIView *view in [[_seaBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view  setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    isSearch=NO;
    _btnCancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnCancel setFrame:_tbView.frame];
    [_btnCancel setBackgroundColor:[UIColor blackColor]];
    _btnCancel.alpha=0.6f;
    [_btnCancel addTarget:self action:@selector(closeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCancel];
    _btnCancel.hidden=YES;
    
    //推荐城市数据
    array=[[DBHotCity shareDBHotCity] SelectHotCity];
    
    //热门城市网格视图
    UINib *nib=[UINib nibWithNibName:@"HotCityCollectionViewCell" bundle:[NSBundle mainBundle]];
    [_CollectionHotCity registerNib:nib forCellWithReuseIdentifier:hotCityCell];
    
    
}
-(IBAction)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)closeKeyBoard{
    [_seaBar resignFirstResponder];
    _btnCancel.hidden=YES;
}
#pragma mark UISearchBar
//点击搜索以后进入
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _btnCancel.hidden=YES;
    [_seaBar resignFirstResponder];
    isSearch=YES;
    
    
    searchArray=[[DBCity shareDBCity] selectLikeCityArray:_seaBar.text];

    [_tbView reloadData];
}

//点击取消
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _seaBar.text=@"";
    [_seaBar resignFirstResponder];
    _btnCancel.hidden=YES;
    isSearch=NO;
    [_tbView reloadData];
    _CollectionHotCity.hidden=NO;
}
//文本框内容改变时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    isSearch=YES;
    
    searchArray=[[DBCity shareDBCity] selectLikeCityArray:_seaBar.text];
    
    [_tbView reloadData];
    _CollectionHotCity.hidden=YES;
}


//将要开始编辑以后进入
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    _btnCancel.hidden=NO;
    return YES;
}
#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=[searchArray objectAtIndex:indexPath.row];
    return cell;

}
//点击以后
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    WeatherInfoViewController *weather=[story instantiateViewControllerWithIdentifier:@"weatherInfo"];
    weather.cityName=[searchArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:weather animated:YES];
   
}

#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotCityCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:hotCityCell forIndexPath:indexPath];
    NSString *hotCity=[array objectAtIndex:indexPath.row];
    cell.lb.text=hotCity;
    if([myCityArry containsObject:hotCity]){
        cell.imgView.hidden=NO;
    }else{
        cell.imgView.hidden=YES;
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    static NSString *headerId=@"header";
    UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];

    return view;
}
//选中后
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cityName=[array objectAtIndex:indexPath.row];
    if (![myCityArry containsObject:cityName]) {
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        WeatherInfoViewController *weather=[story instantiateViewControllerWithIdentifier:@"weatherInfo"];
        weather.cityName=cityName;
        [self.navigationController pushViewController:weather animated:YES];
    }else{
        if([[DBSelectMyCity shareDBSelectMyCity] deleteCity:cityName]){
            //我的数组
            myCityArry=[[DBSelectMyCity shareDBSelectMyCity]SelectMyCityName];
            [_CollectionHotCity reloadData];
        }
    }
    NSLog(@"%@",indexPath);
   }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
