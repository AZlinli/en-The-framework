//
//  LYRACWeightsTableViewViewModel.m
//  LYBook
//
//  Created by luoyong on 2018/8/15.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import "LYRACWeightsTableViewViewModel.h"
#import "LYHTTPRequestManager.h"
#import "LYRACWeightsTableViewViewModel.h"
#import "LYBaseModel.h"
@interface LYRACWeightsTableViewViewModel()
/**
 分页
 */
@property (assign, readwrite, nonatomic) NSInteger page;
/**
 一页多少个
 */
@property (assign, readwrite, nonatomic) NSInteger limitPage;
/**
 数据
 */
@property (strong, readwrite, nonatomic) NSMutableArray * dataMutableArray;
@property (strong, readwrite, nonatomic) NSString * total;
@property (assign, readwrite, nonatomic) BOOL moreData;
@property (strong, readwrite, nonatomic) RACCommand * requestDataCommand;
@property (strong, readwrite, nonatomic) RACCommand * didSelectRowCommand;
@property (strong, readwrite, nonatomic) RACCommand * didTapButtonCommand;
@property (strong, readwrite, nonatomic) RACCommand * didTapViewCommand;
@property (copy, readwrite, nonatomic) NSArray * dataArray;
@property (strong, readwrite, nonatomic) NSString * urlString;
@property (strong, readwrite, nonatomic) NSDictionary * parameter;
@end
@implementation LYRACWeightsTableViewViewModel

- (instancetype)initUrlString:(NSString *)urlString parameter:(NSDictionary *)parameter page:(NSInteger)page limitPage:(NSInteger)limitPage
{
    if (self = [super init]) {
        _moreData = YES;
        _urlString = urlString;
        _parameter = parameter;
        _page = page;
        _limitPage = limitPage;
        _total = @"0";
        if (!_page) {
            _page = 1;
        }
        if (!_limitPage) {
            _limitPage = 10;
        }
    }
    return self;
}

- (void)updateParameterWithDic:(NSDictionary *)dic
{
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:self.parameter];
    [mutableDictionary addEntriesFromDictionary:dic];
    self.parameter = [mutableDictionary copy];
}

- (RACCommand *)requestDataCommand
{
    if (!_requestDataCommand) {
        @weakify(self);
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *  _Nullable input) {
            @strongify(self);
            
            if ([input boolValue]) {
                self.page = 1;
                self.moreData = YES;
            }
            if (!self.moreData) {
                return [RACSignal return:@(2)];
            }
            NSMutableDictionary * parametersDic = [NSMutableDictionary dictionaryWithDictionary:self.parameter];
            if (self.limitPage != 0) {
                [parametersDic setObject:@(self.page) forKey:@"page"];
                [parametersDic setObject:@(self.limitPage) forKey:@"page_size"];
            }
            
            return [[LYHTTPRequestManager HTTPGetRequestWithAction:self.urlString parameter:parametersDic cacheType:NO] map:^id _Nullable(NSDictionary *  _Nullable value) {
                if ([[NSString stringWithFormat:@"%@", value[@"code"]] isEqualToString:@"0"]) {
                    NSArray * datas = value[@"data"][@"items"];
                    LYNSLog(@"%@", datas);
                    if ([input boolValue] || self.page == 1) {
                        if (!self.onlyUseData) {
                            [self.dataMutableArray removeAllObjects];
                        }else{
                            [self addDatasWithDictionary:nil type:input];
                        }
                    }
                    if (!datas.count) {
                        if ([input boolValue]) {
                            if (!self.onlyUseData) {
                                self.dataArray = self.dataMutableArray;
                            }
                            return @(0);
                        }
                    }
//                    self.moreData = [[NSString stringWithFormat:@"%@", value[@"data"][@"pagination"][@"more"]] boolValue];
                    self.total = [NSString stringWithFormat:@"%@", @([[NSString stringWithFormat:@"%@", value[@"data"][@"pagination"][@"total_record"]] integerValue])];
                    [self addDatasWithDictionary:value type:input];
                    if (self.page * self.limitPage >= [[NSString stringWithFormat:@"%@", value[@"data"][@"pagination"][@"total_record"]] integerValue]) {
                        self.moreData = NO;
                        return @(2);
                    }
                    
                    if (self.page * self.limitPage < [[NSString stringWithFormat:@"%@", value[@"data"][@"pagination"][@"total_record"]] integerValue]) {
                        self.moreData = YES;
                        self.page ++;
                        return @(1);
                    }
                }
                self.total = @"0";
                LYNSLog(@"%@", value);
                return @(0);
            }];
        }];
    }
    return _requestDataCommand;
}

- (void)insertOneData:(id)model
{
    if (model) {
        [self.dataMutableArray insertObject:model atIndex:0];
        NSInteger total = [self.total integerValue] + 1;
        self.total = [@(total) stringValue];
        self.dataArray = [self.dataMutableArray copy];
    }
}

- (void)deleteAllData
{
    [self.dataMutableArray removeAllObjects];
    self.total = @"0";
    self.dataArray = self.dataMutableArray;
}

- (void)deleteOneData:(id)model
{
    if (model) {
        if ([self.dataMutableArray containsObject:model]) {
            [self.dataMutableArray removeObject:model];
            NSInteger totalInteger = [self.total integerValue];
            NSInteger count =  totalInteger - 1;
            if (count < 0) {
                count = 0;
            }
            self.total = [NSString stringWithFormat:@"%@", @(count)];
            self.dataArray = self.dataMutableArray;
        }
    }
}

/**
 添加数据
 
 @param value 字典
 */
- (void)addDatasWithDictionary:(NSDictionary *)value type:(NSNumber *)type
{
    NSCAssert(self.dataClass, @"dataClass == nil");
    if (!self.onlyUseData) {
        [self.dataMutableArray addObjectsFromArray:[self.dataClass mj_objectArrayWithKeyValuesArray:value[@"data"][@"items"]]];
        self.dataArray = [self.dataMutableArray copy];
    }else{
        NSArray * array = [[self.dataClass mj_objectArrayWithKeyValuesArray:value[@"data"][@"items"]] copy];
        if (array.count) {
            self.onlyUseDataDictionary = @{@"models":array, @"type":type};
        }else{
            self.onlyUseDataDictionary = @{@"type":type};
        }
    }
    
    
}

- (RACCommand *)didSelectRowCommand
{
    if (!_didSelectRowCommand) {
        _didSelectRowCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal return:input];
        }];
    }
    return _didSelectRowCommand;
}

- (RACCommand *)didTapButtonCommand
{
    if (!_didTapButtonCommand) {
        _didTapButtonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal return:nil];
        }];
    }
    return _didTapButtonCommand;
}

- (RACCommand *)didTapViewCommand
{
    if (!_didTapViewCommand) {
        _didTapViewCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal return:nil];
        }];
    }
    return _didTapViewCommand;
}
- (NSMutableArray *)dataMutableArray
{
    if (!_dataMutableArray) {
        _dataMutableArray = [[NSMutableArray alloc] init];
    }
    return _dataMutableArray;
}

@end
