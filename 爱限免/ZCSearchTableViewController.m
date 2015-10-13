//
//  ZCSearchTableViewController.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/13.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCSearchTableViewController.h"
#import "ZCAppCell.h"
#import "ZCAppModel.h"

@interface ZCSearchTableViewController ()
{
    NSMutableArray *_dataSource;
}

@end

@implementation ZCSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索结果";
    _dataSource = [[NSMutableArray alloc] init];
    [self downloadData];
    
    [self.tableView registerClass:[ZCAppCell class] forCellReuseIdentifier:@"ZCAppCell"];
}

- (void)downloadData {
    
    // 生成下载链接
    
    // url中有中文的话，需要转码
    self.searchKeyword = [self.searchKeyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"sk:%@", self.searchKeyword);
    
    NSString *urlString = [NSString stringWithFormat:SEARCH_URL, _searchKeyword];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *apps = dict[@"applications"];
        
        for (NSDictionary *appDict in apps) {
            ZCAppModel *model = [[ZCAppModel alloc] init];
            [model setValuesForKeysWithDictionary:appDict];
            
            model.desc = appDict[@"description"];
            
            NSLog(@"name:%@", model.name);
            
            [_dataSource addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@", error);
    }];
    
}

#pragma mark - tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
    
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return heightEx(100);
}

@end
