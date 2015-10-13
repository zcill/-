//
//  ZCAppCell.h
//  爱限免
//
//  Created by 朱立焜 on 15/10/12.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface ZCAppCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) StarView *starView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UILabel *sharesLabel;
@property (nonatomic, strong) UILabel *favoriteLabel;
@property (nonatomic, strong) UILabel *downloadLabel;

@end
