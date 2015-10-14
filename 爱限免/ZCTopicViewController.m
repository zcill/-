//
//  ZCTopicViewController.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/13.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCTopicViewController.h"

#import "ZCTopicModel.h"
#import "ZCAppModel.h"
#import "ZCTopicCell.h"
#import "ZCDetailViewController.h"

@interface ZCTopicViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    int _page;
}

@end

@implementation ZCTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
    _page = 1;
    _dataSource = [[NSMutableArray alloc] init];
    [self downloadData];
    
}

- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[ZCTopicCell class] forCellReuseIdentifier:@"ZCTopicCell"];
}

- (void)downloadData {
    
    NSString *urlStr = [NSString stringWithFormat:TOPIC_URL, _page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *topics = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *topicDic in topics) {
            
//            [ZJModelTool createModelWithDictionary:dic modelName:@"ZCTopicModel"];
            
            ZCTopicModel *model = [[ZCTopicModel alloc] init];
            [model setValuesForKeysWithDictionary:topicDic];
            
            NSMutableArray *appMarr = [[NSMutableArray alloc] init];
            
            for (NSDictionary *appDic in topicDic[@"applications"]) {
                ZCAppModel *appModel = [[ZCAppModel alloc] init];
                [appModel setValuesForKeysWithDictionary:appDic];
                [appMarr addObject:appModel];
            }
            
            model.applications = appMarr;
            [_dataSource addObject:model];
            
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

#pragma mark - tableView 协议方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseID = @"ZCTopicCell";
    ZCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    ZCTopicModel *model = _dataSource[indexPath.row];
    
    cell.titleLabel.text = model.title;
    [cell.imgView setImageWithURL:[NSURL URLWithString:model.img]];
    [cell.descImageView setImageWithURL:[NSURL URLWithString:model.desc_img]];
    cell.descLabel.text = model.desc;
    
    // 从ZCTopicModel中拿出ZCAppModel数据，数值cell的4个appView
    
    for (int i = 0; i < model.applications.count; i++) {
        ZCAppModel *appModel = model.applications[i];
        ZCAppView *appView = cell.appViewArray[i];
        
        [appView.iconImageView setImageWithURL:[NSURL URLWithString:appModel.iconUrl]];
        appView.nameLabel.text = appModel.name;
        appView.shareLabel.text = appModel.shares;
        appView.downloadLabel.text = appModel.downloads;
        [appView.starView setStar:appModel.starOverall.doubleValue];
        
        // 实现点击事件
        appView.model = appModel;
        [appView setActionBlock:^(ZCAppView *view) {
            ZCDetailViewController *dvc = [[ZCDetailViewController alloc] init];
            dvc.model = appView.model;
            [self.navigationController pushViewController:dvc animated:YES];
        }];
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return heightEx(310);
}


@end
