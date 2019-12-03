//
//  LYSearchHistoryManager.h
//  ToursCool
//
//  Created by tourscool on 11/28/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYDBManager.h"
@class LYSearchHistoryModel;
NS_ASSUME_NONNULL_BEGIN

@interface LYSearchHistoryManager : LYDBManager
+ (void)createUserSearchTable;
+ (NSArray <NSDictionary *> * )obtainSearchHistory;
/**
 插入数据

 @param dic SearchKey SearchName
 @return YES
 */
+ (BOOL)inserOneSearchHistoryWithDic:(NSDictionary *)dic;
+ (NSArray <LYSearchHistoryModel *> * )obtainAllSearchHistory;
+ (BOOL)inserOneSearchHistoryWithSearchHistoryModel:(LYSearchHistoryModel *)searchHistoryModel;
+ (BOOL)deleteOneSearchHistoryWithSearchHistoryID:(NSInteger)searchHistoryID;
+ (BOOL)deleteOneSearchHistoryWithSearchTitle:(NSString *)searchName;
+ (RACSignal *)deleteAllSearchHistory;
+ (RACSignal *)deleteOneSearchHistorySignalWithSearchTitle:(NSString *)searchName;
@end

NS_ASSUME_NONNULL_END
