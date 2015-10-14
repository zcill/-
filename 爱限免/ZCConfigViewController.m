//
//  ZCConfigViewController.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/13.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCConfigViewController.h"
#import "ZTQuickControl.h"
#import "ZCFavoriteViewController.h"

@interface ZCConfigViewController ()

@end

@implementation ZCConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)createUI {
    
    self.title = @"配置";
    
    double c = 266.0/255.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:c green:c blue:c alpha:1];
    
    NSArray *images = @[
                        @"account_setting", @"account_favorite",
                        @"account_user", @"account_collect",
                        @"account_download", @"account_comment",
                        @"account_help", @"account_candou"
                        ];
    NSArray *titles = @[
                        @"我的设置", @"我的关注",
                        @"我的账户", @"我的收藏",
                        @"我的下载", @"我的评论",
                        @"我的帮助", @"蚕豆应用"
                        ];
    
    int inteval = 35;
    double w = 57;
    double h = 57;
    double x = 35;
    double y = 64 + 40;
    
    __weak typeof(self) weakSelf = self;
    
    for (int i = 0; i < 8; i++) {
        UIButton *button = [self.view addImageButtonWithFrame:CGRectMake(x, y, w, h) title:nil image:images[i] action:^(ZTButton *button) {
            
            if (button.tag == 103) {
                // 进入我的收藏页面
                ZCFavoriteViewController *fvc = [[ZCFavoriteViewController alloc] init];
                [weakSelf.navigationController pushViewController:fvc animated:YES];
                
            }
            
        }];
        button.tag = i + 100;
        
        UILabel *label = [self.view addLabelWithFrame:CGRectMake(x, y + 40, w, h) title:titles[i]];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;

#if 0
        if (i % 3 != 2) {
            x += (w + inteval);
            NSLog(@"i取模3 = %d", i%3);
        } else {
            x = 35;
            y += (h + inteval);
        }
        
#else
        
        i % 3 != 2 ? (x += (w + inteval)) : (x = 35, y += (h + inteval));
     
#endif
        
    }
    
}

@end
