//
//  LYSearchViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYSearchSectionTitleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSearchViewModel : NSObject
@property (nonatomic, readonly, copy) NSArray<LYSearchSectionTitleModel *> * dataArray;
@property (nonatomic, copy) NSString * searchTitle;
@property (nonatomic, readonly, strong) RACCommand * deleteHistoryCommand;
@property (nonatomic, readonly, strong) RACCommand * searchCommand;
@property (nonatomic, readonly, strong) RACCommand * didSelectItemCommand;

@property (nonatomic, readonly, copy) NSString * itemType;
@property (nonatomic, readonly, copy) NSString * startCity;
@property (nonatomic, readonly, copy) NSString * spanCity;

- (instancetype)initWithParameter:(NSDictionary *)parameter;
- (void)addSearchHistoryWithDic:(NSDictionary *)dic;
- (void)saveSearchHistoryWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
