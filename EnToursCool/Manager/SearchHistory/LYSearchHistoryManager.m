//
//  LYSearchHistoryManager.m
//  ToursCool
//
//  Created by tourscool on 11/28/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSearchHistoryManager.h"
#import "LYSearchHistoryModel.h"
#import <FMDB/FMDB.h>

static NSString * TableName = @"UserSearchHistoryTableName";

static NSString * SearchKey = @"SearchKey";
static NSString * SearchName = @"SearchName";

@implementation LYSearchHistoryManager

+ (void)createUserSearchTable
{
    if (![LYSearchHistoryManager needCreateTableWithTableName:TableName]) {
        FMDatabase * database = [LYSearchHistoryManager obtainFMDatabase];
        if ([database open]) {
            NSString *searchSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'%@' VARCHAR(255),'%@' VARCHAR(255) UNIQUE)", TableName, SearchKey, SearchName];
            BOOL result = [database executeUpdate:searchSql];
            [database close];
            if (result) {
                LYNSLog(@"创建成功!");
            }else{
                LYNSLog(@"创建失败!");
            }
        }
    }
}

+ (NSArray <NSDictionary *> * )obtainSearchHistory
{
    NSMutableArray<NSDictionary *> *dataArray = [[NSMutableArray<NSDictionary *> alloc] init];
    FMDatabase * database = [LYSearchHistoryManager obtainFMDatabase];
    [database open];
    [database beginTransaction];
    
    NSString * selectSQL = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY ID DESC", TableName];
    @try{
        FMResultSet *res = [database executeQuery:selectSQL];
        while ([res next]) {
            NSString * searchName = [res stringForColumn:SearchName];
            NSString * searchKey = [res stringForColumn:SearchKey];
            NSInteger searchID = [res intForColumn:@"id"];
            NSDictionary * dic = @{@"name":searchName?:@"",@"key":searchKey?:@"",@"id":@(searchID)};
            [dataArray addObject:dic];
        }
    }
    @catch(NSException *exception){
        [database rollback];
        [database close];
    }
    @finally {
        [database commit];
        [database close];
    }
    return dataArray;
}

+ (NSArray <LYSearchHistoryModel *> * )obtainAllSearchHistory
{
    NSMutableArray<LYSearchHistoryModel *> *dataArray = [[NSMutableArray<LYSearchHistoryModel *> alloc] init];
    FMDatabase * database = [LYSearchHistoryManager obtainFMDatabase];
    [database open];
    [database beginTransaction];
    
    NSString * selectSQL = [NSString stringWithFormat:@"SELECT * FROM %@", TableName];
    @try{
        FMResultSet *res = [database executeQuery:selectSQL];
        while ([res next]) {
            LYSearchHistoryModel * model = [[LYSearchHistoryModel alloc] init];
            model.searchName = [res stringForColumn:SearchName];
            model.searchKey = [res stringForColumn:SearchKey];
            model.searchID = [res intForColumn:@"id"];
            [dataArray addObject:model];
        }
        [database commit];
    }
    @catch(NSException *exception){
        [database rollback];
        [database close];
    }
    @finally {
        [database close];
    }
    return dataArray;
}

+ (BOOL)inserOneSearchHistoryWithDic:(NSDictionary *)dic
{
    LYSearchHistoryModel * model = [[LYSearchHistoryModel alloc] init];
    if ([dic[@"name"] length]) {
        model.searchName = dic[@"name"];
    }
    if ([dic[@"key"] length]) {
        model.searchKey = dic[@"key"];
    }
    return [LYSearchHistoryManager inserOneSearchHistoryWithSearchHistoryModel:model];
}

+ (BOOL)inserOneSearchHistoryWithSearchHistoryModel:(LYSearchHistoryModel *)searchHistoryModel
{
    NSString * insertSQL = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@) VALUES(:%@,:%@)",TableName,SearchName, SearchKey, SearchName, SearchKey];
    FMDatabase * database = [LYSearchHistoryManager obtainFMDatabase];
    [database open];
    [database beginTransaction];
    BOOL result = NO;
    @try{
        result = [database executeUpdate:insertSQL withParameterDictionary:@{SearchName:searchHistoryModel.searchName,SearchKey:searchHistoryModel.searchKey.length?searchHistoryModel.searchKey:@""}];
    }
    @catch(NSException *exception){
        LYNSLog(@"catch");
        [database rollback];
        [database close];
    }
    @finally {
        LYNSLog(@"finally");
        if (result) {
            [database commit];
        }else{
            [database rollback];
        }
        [database close];
    }
    
    [database close];
    return result;
}

+ (BOOL)deleteOneSearchHistoryWithSearchHistoryID:(NSInteger)searchHistoryID
{
    NSString * deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = %@", TableName, @(searchHistoryID)];
    FMDatabase * database = [LYSearchHistoryManager obtainFMDatabase];
    [database open];
    BOOL result = [database executeUpdate:deleteSQL];
    [database close];
    return result;
}

+ (BOOL)deleteOneSearchHistoryWithSearchTitle:(NSString *)searchName
{
    NSString * deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'", TableName, SearchName,searchName];
    FMDatabase * database = [LYSearchHistoryManager obtainFMDatabase];
    [database open];
    BOOL result = [database executeUpdate:deleteSQL];
    [database close];
    return result;
}

+ (RACSignal *)deleteAllSearchHistory
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        FMDatabase * database = [LYSearchHistoryManager obtainFMDatabase];
        [database open];
        [database executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", TableName]];
        [database executeUpdate:[NSString stringWithFormat:@"UPDATE sqlite_sequence set seq=0 where name='%@'", TableName]];
        [database close];
        [subscriber sendCompleted];
        return nil;
    }];
}

+ (RACSignal *)deleteOneSearchHistorySignalWithSearchTitle:(NSString *)searchName{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSString * deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'", TableName, SearchName,searchName];
        FMDatabase * database = [LYSearchHistoryManager obtainFMDatabase];
        [database open];
        [database executeUpdate:deleteSQL];
        [database close];

        [subscriber sendCompleted];
        return nil;
    }];
}


@end
