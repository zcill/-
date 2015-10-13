//
//  ZCAppListViewController.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/12.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCAppListViewController.h"
//// 接口
//#import "NetInterface.h"
//// 网络
//#import "AFNetworking.h"
//#import "UIKit+AFNetworking.h"
//// model工具
//#import "ZJModelTool.h"
#import "ZCAppModel.h"
#import "ZCAppCell.h"
//
//// 适配
//#import "ZJScreenAdaptation.h"
//#import "ZJScreenAdaptaionMacro.h"
#import "ZCSortTableViewController.h"

@interface ZCAppListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    // tableView
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    
    // URL参数
    int _page;
    NSString *_categoryID;
}
@end

@implementation ZCAppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    _categoryID = @"";
    _dataSource = [[NSMutableArray alloc] init];
    
    [self downloadData];
    [self createTableView];
    
    [self configNavigation];
}

// 先下载数据
- (void)downloadData {
    
    // 清空数组，否则选择分类之后，回调的数据都会接在之前的数据之后
    [_dataSource removeAllObjects];
    
    NSString *urlStr = [NSString stringWithFormat:self.urlString, _page, _categoryID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *apps = dict[@"applications"];
        for (NSDictionary *appDict in apps) {
//            NSLog(@"name = %@", appDict[@"name"]);
            
//            [ZJModelTool createModelWithDictionary:appDict modelName:@"ZCAppModel"];
            
            ZCAppModel *model = [[ZCAppModel alloc] init];
            // 用字典为model赋值
            [model setValuesForKeysWithDictionary:appDict];
            model.desc = appDict[@"description"];
            [_dataSource addObject:model];
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

// 配置导航
- (void)configNavigation {
    
    UIBarButtonItem *sortBarButtonItem = [self createItemWithSize:CGSizeMakeEx(40, 28) imageName:@"buttonbar_action.png" title:@"分类" target:self action:@selector(doSort)];
    
    UIBarButtonItem *pageConfigBarButtonItem = [self createItemWithSize:CGSizeMakeEx(40, 28) imageName:@"buttonbar_action.png" title:@"配置" target:self action:@selector(doConfig)];
    
    self.navigationItem.leftBarButtonItem = sortBarButtonItem;
    self.navigationItem.rightBarButtonItem = pageConfigBarButtonItem;
}

- (void)doSort {
    
    ZCSortTableViewController *sortVC = [[ZCSortTableViewController alloc] initWithNibName:@"ZCSortTableViewController" bundle:nil];
    [sortVC setChangeSortBlock:^(NSString *categoryID) {
        
        _categoryID = categoryID;
        _page = 1;
        [self downloadData];
        
    }];
    
    [self.navigationController pushViewController:sortVC animated:YES];
    
}

- (void)doConfig {
    

    
}

// 定制BarItem，传入必要的参数
- (UIBarButtonItem *)createItemWithSize:(CGSize)size imageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMakeEx(0, 0, size.width, size.height);
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
    
}


// 创建tableView
- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[ZCAppCell class] forCellReuseIdentifier:@"ZCAppCell"];
}

// 代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZCAppCell"];
    
    ZCAppModel *model = _dataSource[indexPath.row];
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld.%@", indexPath.row + 1, model.name];
    [cell.starView setStar:model.starOverall.doubleValue];
    cell.categoryLabel.text = model.categoryName;
    cell.priceLabel.text = [NSString stringWithFormat:@"价格:%.2f", model.lastPrice.doubleValue];
    cell.sharesLabel.text = [NSString stringWithFormat:@"分享:%@次", model.shares];
    cell.favoriteLabel.text = [NSString stringWithFormat:@"收藏:%@次", model.favorites];
    cell.downloadLabel.text = [NSString stringWithFormat:@"下砸:%@次", model.downloads];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return heightEx(100);
}


@end
