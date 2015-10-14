//
//  ZCTopicCell.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/14.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCTopicCell.h"

@implementation ZCTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    [self.contentView addImageViewWithFrame:CGRectMake(5, 0, 310, 308) image:@"topic_Cell_Bg.png"];
    _imgView = [self.contentView addImageViewWithFrame:CGRectMake(10, 50, 122, 186) image:nil];
    _titleLabel = [self.contentView addLabelWithFrame:CGRectMake(10, 15, 320, 30) title:nil];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    
    _descLabel = [self.contentView addLabelWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) title:<#(NSString *)#>]
    
}

@end
