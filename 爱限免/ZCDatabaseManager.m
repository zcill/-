//
//  ZCDatabaseManager.m
//  爱限免
//
//  Created by 朱立焜 on 15/10/14.
//  Copyright (c) 2015年 zcill. All rights reserved.
//

#import "ZCDatabaseManager.h"
#import "FMDatabase.h"

@interface ZCDatabaseManager ()
{
    FMDatabase *_database;
}

@end

@implementation ZCDatabaseManager

+ (instancetype)shareInstance {
    static ZCDatabaseManager *dm = nil;
    if (dm == nil) {
        dm = [[ZCDatabaseManager alloc] init];
    }
    return dm;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configDatabase];
    }
    return self;
}

- (void)configDatabase {
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/record.rdb", NSHomeDirectory()];
    
    // 打开或者创建数据库
    _database = [[FMDatabase alloc] initWithPath:path];
    
    if (!_database.open) {
        NSLog(@"打开数据库失败");
        return;
    }
    
    // 创建数据表
    NSString *sql = @"create table if not exists ZCAppList(applicationID, iconUrl, name, recordType)";
    BOOL ret = [_database executeUpdate:sql];
    if (!ret) {
        NSLog(@"创建表失败");
        return;
    }
    NSLog(@"数据库创建成功");
    
}

// 记录保存
- (void)addRecordWithZCAppModel:(ZCAppModel *)model recordType:(ZCRecordType)type {
    
    if ([self isExistsRecordWithZCAppModel:model recordType:type]) {
        NSLog(@"已经保存过了");
        return;
    }
    NSString *sql = @"insert into ZCAppList(applicationID, iconUrl, name, recordType) values(?, ?, ?, ?)";
    BOOL ret = [_database executeUpdate:sql, model.applicationId, model.iconUrl, model.name, @(type).stringValue];
    if (!ret) {
        NSLog(@"添加数据失败");
        return;
    }
    
}

// 数据库的删除
- (void)removeRecordWithZCAppModel:(ZCAppModel *)model recordType:(ZCRecordType)type {
    
    NSString *sql = @"delete from ZCAppList where applicationID = ? and recordType = ?";
    BOOL ret = [_database executeUpdate:sql, model.applicationId, @(type).stringValue];
    
    if (!ret) {
        NSLog(@"删除数据失败");
        return;
    }
}

// 查看是否存在
- (BOOL)isExistsRecordWithZCAppModel:(ZCAppModel *)model recordType:(ZCRecordType)type {
    
    NSString *sql = @"select * from ZCAppList where applicationID = ? and recordType = ?";
    FMResultSet *result = [_database executeQuery:sql, model.applicationId, @(type).stringValue];
    while ([result next]) {
        return YES;
    }
    return NO;
    
}

// 获取所有记录
- (NSArray *)recordWithRecordType:(ZCRecordType)type {
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    NSString *sql = @"select * from ZCAppList where recordType = ?";
    FMResultSet *result = [_database executeQuery:sql, @(type).stringValue];
    while ([result next]) {
        ZCAppModel *model = [[ZCAppModel alloc] init];
        model.applicationId = [result stringForColumn:@"applicationID"];
        
        model.iconUrl = [result stringForColumn:@"iconUrl"];
        model.name = [result stringForColumn:@"name"];
        
        [mutableArray addObject:model];
    }
    return mutableArray;
    
}


@end
