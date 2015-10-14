//
//  ZCDetailViewController.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/14.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCDetailViewController.h"
#import "ZCDatabaseManager.h"

@interface ZCDetailViewController ()<UIActionSheetDelegate, UMSocialUIDelegate>
// 详情页面的各个控件
{
    UIImageView *_topView;
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UILabel *_priceLabel;
    UILabel *_sizeLabel;
    UILabel *_typeLabel;
    UILabel *_starLabel;
    
    UILabel *_summaryLabel;
    // 显示截图
    UIScrollView *_snapshotScrollView;
    // 显示附近信息
    UIImageView *_buttonView;
    UIScrollView *_nearbyAppScrollView;
    
    NSMutableArray *_nearbyAppArray;
}

@end

@implementation ZCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 只是创建视图，显示数据是在加载完之后
    [self createTopView];
    // 下载数据
    [self downloadAppDetailInfo];
    // 创建附近的人也在用的app button
    [self createButtonView];
    _nearbyAppArray = [[NSMutableArray alloc] init];
    
    [self downloadAppNearbyAppInfo];
}

// 搭界面
- (void)createTopView {

    _topView = [self.view addImageViewWithFrame:CGRectMake(10, 64 + 3, 300, 280) image:@"appdetail_background.png"];
    _topView.userInteractionEnabled = YES;
    
    _iconImageView = [_topView addImageViewWithFrame:CGRectMake(10, 10, 70, 70) image:nil];
    _iconImageView.layer.cornerRadius = 10;
    _iconImageView.clipsToBounds = YES;
    [_iconImageView setImageWithURL:[NSURL URLWithString:self.model.iconUrl]];
    
    _titleLabel = [_topView addLabelWithFrame:CGRectMake(90, 10, 200, 30) title:self.model.name];
    _priceLabel = [_topView addLabelWithFrame:CGRectMake(90, 20 + 10, 200, 30) title:self.model.name];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    
    _sizeLabel = [_topView addLabelWithFrame:CGRectMake(90 + 100, 20 + 10, 200, 30) title:self.model.name];
    _sizeLabel.font = [UIFont systemFontOfSize:14];
    
    _typeLabel = [_topView addLabelWithFrame:CGRectMake(90, 20 + 10 + 20, 200, 30) title:self.model.name];
    _typeLabel.font = [UIFont systemFontOfSize:14];
    
    _starLabel = [_topView addLabelWithFrame:CGRectMake(90 + 100, 20 + 10 + 20, 200, 30) title:self.model.name];
    _starLabel.font = [UIFont systemFontOfSize:14];
    
    __weak typeof (self) weakSelf = self;
    
    // 循环创建button
    for (int i = 0; i < 3; i++) {
        NSArray *titles = @[@"分享", @"收藏", @"下载"];
        ZCDatabaseManager *dm = [ZCDatabaseManager shareInstance];
        // 如果已经收藏过
        if ([dm isExistsRecordWithZCAppModel:weakSelf.model recordType:ZCRecordTypeFavorite]) {
            titles = @[@"分享", @"已收藏", @"下载"];
        }
        
        UIButton *button = [_topView addImageButtonWithFrame:CGRectMake(i * 100, 90, 100, 40) title:titles[i] image:@"Detail_btn_left.png" action:^(ZTButton *button) {
            
            switch (button.tag) {
                case 100:{
                    // 分享
                    // 平台类的公司提供了分享SDK(QQ、微博、微信)
                    // 分享库: 友盟SDK、ShareSDK、百度分享SDK
                    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博", @"微信好友", @"微信朋友圈", @"QQ好友", @"QQ空间", @"邮件", @"短信", nil];
                    [actionSheet showInView:weakSelf.view];
                    
                    break;
                }
                case 101:{
                    // 收藏
//                    ZCDatabaseManager *dm = [ZCDatabaseManager shareInstance];
                    // 如果不存在
                    if (![dm isExistsRecordWithZCAppModel:weakSelf.model recordType:ZCRecordTypeFavorite]) {
                        [dm addRecordWithZCAppModel:weakSelf.model recordType:ZCRecordTypeFavorite];
                        [button setTitle:@"已收藏" forState:UIControlStateNormal];
                    } else {
                        // 取消收藏
                        [dm removeRecordWithZCAppModel:weakSelf.model recordType:ZCRecordTypeFavorite];
                        [button setTitle:@"收藏" forState:UIControlStateNormal];
                    }
                    
                    break;
                }
                case 102:{
                    // 下载
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weakSelf.model.itunesUrl]];
                    
                    break;
                }
                default:
                    break;
            }
            
        }];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i + 100;
    }
    
    // scrollView创建
    _snapshotScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 135, 280, 88)];
    _snapshotScrollView.showsVerticalScrollIndicator = NO;
    _snapshotScrollView.showsHorizontalScrollIndicator = NO;
    [_topView addSubview:_snapshotScrollView];
    
    _summaryLabel = [_topView addLabelWithFrame:CGRectMake(10, 230, 280, 45) title:@"test"];
    _summaryLabel.numberOfLines = 0;
    _summaryLabel.font = [UIFont systemFontOfSize:12];
    
    
}

// actionSheet 协议代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", buttonIndex);
    if (buttonIndex < 7) {
        NSArray *sharePlatforms = @[
                                    UMShareToSina,
                                    UMShareToWechatSession,
                                    UMShareToWechatTimeline,
                                    UMShareToQQ,
                                    UMShareToQzone,
                                    UMShareToEmail,
                                    UMShareToSms
                                    ];
        // 微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、易信好友、易信朋友圈、Facebook、Twitter、Line等平台，如果需要接入，参考各自的文档
        
        
        NSString *shareText = [NSString stringWithFormat:@"这蠢应用你们来看看有多垃圾，%@，地址是%@", self.model.name, self.model.itunesUrl];

        // 设置分享内容和回调对象
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:_iconImageView.image socialUIDelegate:self];
        
        // 选择分享方式进行分享
        [UMSocialSnsPlatformManager getSocialPlatformWithName:sharePlatforms[buttonIndex]].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
        
    }
}

// 下载数据
- (void)downloadAppDetailInfo {
    NSString *urlStr = [NSString stringWithFormat:DETAIL_URL, self.model.applicationId.intValue];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.model setValuesForKeysWithDictionary:dict];
        self.model.desc = dict[@"description"];
        
        [self refreshUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@", error);
    }];
    
    
}
// 刷新界面
- (void)refreshUI {
    // 加载数据
    
    [_iconImageView setImageWithURL:[NSURL URLWithString:self.model.iconUrl]];
    _titleLabel.text = self.model.name;
    _priceLabel.text = [NSString stringWithFormat:@"原价%.2f 限免中", self.model.lastPrice.doubleValue];
    _sizeLabel.text = [NSString stringWithFormat:@"%.2fMB", self.model.fileSize.doubleValue];
    _typeLabel.text = [NSString stringWithFormat:@"类型:%@", self.model.categoryName];
    _starLabel.text = [NSString stringWithFormat:@"评分:%@", self.model.starOverall];
    _summaryLabel.text = self.model.desc;
    
    // scrollView上显示数据
    NSArray *array = self.model.photos;
    
    double inteval = 5.0;
    double w = (280 - inteval * 6) / 5;
    double h = 80;
    double x = inteval;
    double y = inteval;
    
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageView = [_snapshotScrollView addImageViewWithFrame:CGRectMake(x, y, w, h) image:nil];
        [imageView setImageWithURL:[NSURL URLWithString:array[i][@"smallUrl"]]];
        
        x += (w + inteval);
    }
    // 设置滚动大小
    _snapshotScrollView.contentSize = CGSizeMake(10 + (w + inteval) * array.count, h);
    
}

- (void)createButtonView {
    
    _buttonView = [self.view addImageViewWithFrame:CGRectMake(10, 285 + 64, 300, 80) image:@"appdetail_recommend.png"];
    _buttonView.userInteractionEnabled = YES;
    
    _nearbyAppScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 15, 290, 60)];
    [_buttonView addSubview:_nearbyAppScrollView];
    
}

- (void)downloadAppNearbyAppInfo {
    
    double longitude = 128.4523;
    double latitude = 35.4013;
    NSString *urlStr = [NSString stringWithFormat:NEARBY_APP_URL, longitude, latitude];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = dict[@"applications"];
        for (NSDictionary *appDict in array) {
            ZCAppModel *model = [[ZCAppModel alloc] init];
            [model setValuesForKeysWithDictionary:appDict];
            [_nearbyAppArray addObject:model];
        }
        // 刷新 显示数据
        [self refreshButtonUI];
        
        [self.model setValuesForKeysWithDictionary:dict];
        self.model.desc = dict[@"description"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@", error);
    }];
    
}

- (void)refreshButtonUI {
    
    double w = 45;
    double h = 45;
    // 间隔
    double inteval = (290 - 45 * 5) / 6;
    double x = inteval;
    double y = 2;
    
    for (int i = 0; i < _nearbyAppArray.count; i++) {
        
        ZCAppModel *model = _nearbyAppArray[i];
        UIImageView *imageView = [_nearbyAppScrollView addImageViewWithFrame:CGRectMake(x, y, w, h) image:nil];
        imageView.layer.cornerRadius = 5;
        imageView.clipsToBounds = YES;
        
        [imageView setImageWithURL:[NSURL URLWithString:model.iconUrl]];
        
        // 图标下方的标题label
        UILabel *label = [_nearbyAppScrollView addLabelWithFrame:CGRectMake(x, y + 29, w, h) title:model.name];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        
        // 打开用户交互
        imageView.userInteractionEnabled = YES;
        imageView.tag = i + 200;
        // 加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        x += (w + inteval);
    }
    // 让scrollView可以滑动
    _nearbyAppScrollView.contentSize = CGSizeMake(10 + inteval + (w + inteval) * _nearbyAppArray.count, h);
    _nearbyAppScrollView.showsHorizontalScrollIndicator = NO;
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    ZCAppModel *model = _nearbyAppArray[tap.view.tag - 200];
    ZCDetailViewController *dvc = [[ZCDetailViewController alloc] init];
    
    dvc.model = model;
    
    [self.navigationController pushViewController:dvc animated:YES];
}


@end
