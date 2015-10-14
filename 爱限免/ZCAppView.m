//
//  ZCAppView.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/14.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCAppView.h"

@implementation ZCAppView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    _iconImageView = [self addImageViewWithFrame:CGRectMake(3, 3, 44, 44) image:nil];
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.clipsToBounds = YES;
    
    _nameLabel = [self addLabelWithFrame:CGRectMake(50, 0, 200, 20) title:nil];
    
    [self addImageViewWithFrame:CGRectMake(50, 18, 13, 9) image:@"topic_Comment.png"];
    
    _shareLabel = [self addLabelWithFrame:CGRectMake(50 + 13, 15, 100, 20) title:nil];
    _shareLabel.font = [UIFont systemFontOfSize:12];
    
    [self addImageViewWithFrame:CGRectMake(100, 18, 10, 11) image:@"topic_Download.png"];
    
    _downloadLabel = [self addLabelWithFrame:CGRectMake(100 + 13, 15, 100, 20) title:nil];
    _downloadLabel.font = [UIFont systemFontOfSize:12];
    
    _starView = [[StarView alloc] initWithFrame:CGRectMake(50, 30, 80, 10)];
    [self addSubview:_starView];
}
// 能响应事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"被点了");
    if (self.actionBlock) {
        self.actionBlock(self);
    }
    
}


@end
