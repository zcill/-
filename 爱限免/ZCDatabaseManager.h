//
//  ZCDatabaseManager.h
//  爱限免
//
//  Created by 朱立焜 on 15/10/14.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCAppModel.h"

// 定义一个枚举 ZCRecordType
typedef NS_ENUM(NSUInteger, ZCRecordType) {
    ZCRecordTypeFavorite,
    ZCRecordTypeDownload,
    ZCRecordTypeBrowser,
};
@interface ZCDatabaseManager : NSObject

+ (instancetype)shareInstance;

// 记录保存到数据库中(收藏、下载、浏览)
- (void)addRecordWithZCAppModel:(ZCAppModel *)model recordType:(ZCRecordType)type;

// 数据库删除记录(取消收藏)
- (void)removeRecordWithZCAppModel:(ZCAppModel *)model recordType:(ZCRecordType)type;

// 查看一个应用是否被记录过
- (BOOL)isExistsRecordWithZCAppModel:(ZCAppModel *)model recordType:(ZCRecordType)type;

// 获取所有的记录
- (NSArray *)recordWithRecordType:(ZCRecordType)type;

@end
