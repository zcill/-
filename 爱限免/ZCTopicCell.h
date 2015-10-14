//
//  ZCTopicCell.h
//  爱限免
//
//  Created by 朱立焜 on 15/10/14.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCAppView.h"

@interface ZCTopicCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *descImageView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, copy) NSMutableArray *appViewArray;

@end
