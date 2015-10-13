//
//  ZCAppCell.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/12.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCAppCell.h"
#import "ZTQuickControl.h"
#import "ZJScreenAdaptation.h"
#import "ZJScreenAdaptaionMacro.h"

@implementation ZCAppCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addImageViewWithFrame:CGRectMake(0, 0, 320, 100) image:@"cate_list_bg1.png"];
    _iconImageView = [self.contentView addImageViewWithFrame:CGRectMake(14, 10, 60, 60) image:nil];
    
    _iconImageView.layer.cornerRadius = 10;
    _iconImageView.clipsToBounds = YES;
    
    _nameLabel = [self.contentView addLabelWithFrame:CGRectMake(80, 5, 200, 30) title:nil];
    _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    
    _starView = [[StarView alloc] initWithFrame:CGRectMake(80, 50, 100, 30)];
    [self.contentView addSubview:_starView];
    
    _priceLabel = [self.contentView addLabelWithFrame:CGRectMake(240, 25, 200, 30) title:nil];
    UILabel *label = [_priceLabel addLabelWithFrame:CGRectMake(0, 14, 45, 2) title:nil];
    label.backgroundColor = [UIColor grayColor];
    
    _categoryLabel = [self.contentView addLabelWithFrame:CGRectMake(240, 45, 200, 30) title:nil];
    _sharesLabel = [self.contentView addLabelWithFrame:CGRectMake(10, 70, 200, 30) title:nil];
    _sharesLabel.font = [UIFont systemFontOfSize:14];
    
    _favoriteLabel = [self.contentView addLabelWithFrame:CGRectMake(110, 70, 200, 30) title:nil];
    _favoriteLabel.font = [UIFont systemFontOfSize:14];
    
    _downloadLabel = [self.contentView addLabelWithFrame:CGRectMake(210, 70, 200, 30) title:nil];
    
    
}

@end
