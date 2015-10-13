//
//  ZCSortTableViewController.h
//  爱限免
//
//  Created by 朱立焜 on 15/10/13.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCSortTableViewController : UITableViewController

// 反向传值block
// 保存ApplistController传入的block，点击分类cell，执行block，来改变Applist显示的app列表对应响应的分类
@property (nonatomic, copy) void (^changeSortBlock)(NSString * categoryID);

- (void)setChangeSortBlock:(void (^)(NSString *))changeSortBlock;

@end
