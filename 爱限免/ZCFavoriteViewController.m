//
//  ZCFavoriteViewController.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/14.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCFavoriteViewController.h"
#import "ZCDatabaseManager.h"

@interface ZCFavoriteViewController ()

@end

@implementation ZCFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI {
    
    self.title = @"我的收藏";
    NSArray *apps = [[ZCDatabaseManager shareInstance] recordWithRecordType:ZCRecordTypeFavorite];
    
    double c = 266.0/255.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:c green:c blue:c alpha:1];
    
    int inteval = 35;
    double w = 57;
    double h = 57;
    double x = 35;
    double y = 64 + 40;
    
    
    for (int i = 0; i < apps.count; i++) {
        
        ZCAppModel *model = apps[i];
        
        UIButton *button = [self.view addImageButtonWithFrame:CGRectMake(x, y, w, h) title:nil image:nil action:^(ZTButton *button) {
            
        }];
        button.tag = i + 100;
        button.backgroundColor = [UIColor lightGrayColor];
        [button setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.iconUrl]];
        button.layer.cornerRadius = 10;
        button.clipsToBounds = YES;
        
        UILabel *label = [self.view addLabelWithFrame:CGRectMake(x, y + 40, w, h) title:model.name];
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
