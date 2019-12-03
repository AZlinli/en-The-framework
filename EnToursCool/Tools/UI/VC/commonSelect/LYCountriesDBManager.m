//
//  LYCountriesDBManager.m
//  EnToursCool
//
//  Created by Lin Li on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCountriesDBManager.h"
#import <FMDB/FMDB.h>
#import "LYCommonSelectViewController.h"

static NSString * TableName = @"AllCountriesTableName";

static NSString * CountrieName = @"countrieName";
static NSString * CountriePinYin = @"countriePinYin";
static NSString * CountrieTelcode = @"countrieTelCode";
static NSString * CountrieAllPinYin = @"countrieAllPinYin";

@implementation LYCountriesDBManager
+ (void)createCountriesTable
{
    if (![LYCountriesDBManager needCreateTableWithTableName:TableName]) {
        FMDatabase * database = [LYCountriesDBManager obtainFMDatabase];
        if ([database open]) {
            NSString *searchSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'%@' VARCHAR(255),'%@' VARCHAR(255), '%@' VARCHAR(255), '%@' VARCHAR(255))", TableName, CountrieName, CountriePinYin, CountrieTelcode, CountrieAllPinYin];
            BOOL result = [database executeUpdate:searchSql];
            if (result) {
                LYNSLog(@"%@创建成功!", TableName);
            }else{
                LYNSLog(@"%@创建失败!", TableName);
            }
            [database close];
        }
    }else{
        FMDatabase * database = [LYCountriesDBManager obtainFMDatabase];
        if ([database open]) {
            FMResultSet *res = [database executeQuery:[NSString stringWithFormat:@"PRAGMA  table_info(%@)", TableName]];
            BOOL hasCountrieAllPinYin = NO;
            while ([res next]) {
                if ([[res stringForColumn:@"name"] isEqualToString:CountrieAllPinYin]) {
                    hasCountrieAllPinYin = YES;
                    return;
                }
            }
            if (!hasCountrieAllPinYin) {
                LYNSLog(@"添加");
                [database executeUpdate:[NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ VARCHAR(255)", TableName, CountrieAllPinYin]];
            }
        }
        [database close];
    }
}

+ (void)insertAllCountries:(NSArray *)countries
{
    if (!countries.count) {
        return;
    }
    NSString * insertSQL = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@) VALUES(:%@,:%@,:%@,:%@)",TableName, CountrieName, CountriePinYin, CountrieTelcode, CountrieAllPinYin, CountrieName, CountriePinYin, CountrieTelcode, CountrieAllPinYin];
    FMDatabase * database = [LYCountriesDBManager obtainFMDatabase];
    [database open];
    [database beginTransaction];
    @try {
        [countries enumerateObjectsUsingBlock:^(LYCommonSelectModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.name.length && obj.allPinYin.length && obj.pinyin.length && obj.telcode.length) {
                [database executeUpdate:insertSQL withParameterDictionary:@{CountrieName:obj.name,CountriePinYin:obj.pinyin, CountrieTelcode:obj.telcode, CountrieAllPinYin:obj.allPinYin}];
            }
        }];
        [database commit];
    } @catch (NSException *exception) {
        LYNSLog(@"%@", exception);
        [database rollback];
    } @finally {
        [database close];
    }
}
@end
