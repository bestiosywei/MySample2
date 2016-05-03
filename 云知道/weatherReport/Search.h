//
//  Search.h
//  weatherReport
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 孟家豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Search : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    IBOutlet UISearchBar *_seaBar;
    IBOutlet UITableView *_tbView;
    IBOutlet UICollectionView *_CollectionHotCity;
    UIButton *_btnCancel;//透明背景.
}
@end
