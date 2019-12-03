//
//  LYDBManager.m
//  ToursCool
//
//  Created by tourscool on 3/1/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYDBManager.h"
#import <FMDB/FMDB.h>

static NSString * APPDBName = @"ToursCoolModel.sqlite";

@implementation LYDBManager

+ (NSString *)obtainDatabaseFilePath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:APPDBName];
}

+ (FMDatabase *)obtainFMDatabase
{
    return [FMDatabase databaseWithPath:[LYDBManager obtainDatabaseFilePath]];
}

+ (void)deleteTableWithTableName:(NSString *)tableName
{
    NSString * deleteTable = [NSString stringWithFormat:@"DELETE FROM '%@'", tableName];
    FMDatabase * database = [LYDBManager obtainFMDatabase];
    [database open];
    [database executeUpdate:deleteTable];
    [database close];
}

+ (BOOL)needCreateTableWithTableName:(NSString *)tableName
{
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName];
    FMDatabase * database = [LYDBManager obtainFMDatabase];
    [database open];
    if ([database open]) {
        FMResultSet *rs = [database executeQuery:existsSql];
        if ([rs next]) {
            NSInteger count = [rs intForColumn:@"countNum"];
            [database close];
            if (count == 1) {
                LYNSLog(@"存在");
                return YES;
            }
        }
    }
    
    return NO;
}

@end
