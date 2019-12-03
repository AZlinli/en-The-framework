//
//  LYDBManager.h
//  ToursCool
//
//  Created by tourscool on 3/1/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
NS_ASSUME_NONNULL_BEGIN

@interface LYDBManager : NSObject

+ (NSString *)obtainDatabaseFilePath;
+ (BOOL)needCreateTableWithTableName:(NSString *)tableName;
+ (FMDatabase *)obtainFMDatabase;
+ (void)deleteTableWithTableName:(NSString *)tableName;
@end

NS_ASSUME_NONNULL_END
