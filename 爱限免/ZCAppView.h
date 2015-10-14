//
//  ZCAppView.h
//  爱限免
//
//  Created by 朱立焜 on 15/10/14.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "ZCAppModel.h"

@interface ZCAppView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, strong) UILabel *downloadLabel;
@property (nonatomic, strong) StarView *starView;

@property (nonatomic, strong) ZCAppModel *model;
@property (nonatomic, copy) void (^actionBlock)(ZCAppView *view);

- (void)setActionBlock:(void (^)(ZCAppView *view))actionBlock;

@end
