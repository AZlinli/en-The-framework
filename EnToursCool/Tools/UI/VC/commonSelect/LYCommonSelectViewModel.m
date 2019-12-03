//
//  LYCommonSelectViewModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCommonSelectViewModel.h"
#import "LYHTTPRequestManager.h"
#import "LYCommonSelectViewController.h"
#import "LYTourscoolCache.h"
#import "LYCountriesDBManager.h"

@interface LYCommonSelectViewModel()
@property (nonatomic, readwrite, copy) NSArray * dataArray;
@property (nonatomic, readwrite, copy) NSArray * allDataArray;
@property (nonatomic, readwrite, copy) NSDictionary<NSString *, NSArray *> * dataDictionary;
@property (nonatomic, readwrite, copy) RACCommand * httpRequestCountriesCommand;

@end

@implementation LYCommonSelectViewModel

+ (void)updateCacheAllCountries
{
    [[LYCommonSelectViewModel httpRequestAllCountries] subscribeNext:^(id  _Nullable x) {
        
    }];
}

+ (RACSignal *)httpRequestAllCountries
{
    return [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(@"allcountries") parameter:@{} cacheType:YES] map:^id _Nullable(id  _Nullable value) {
        if ([value[@"code"] integerValue] == 0) {
            NSArray * array = [LYCommonSelectModel mj_objectArrayWithKeyValuesArray:value[@"data"]];
            [LYCountriesDBManager insertAllCountries:array];
            NSMutableDictionary * dataMutableDictionary = [NSMutableDictionary dictionary];
            [array enumerateObjectsUsingBlock:^(LYCommonSelectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.key.length) {
                    NSMutableArray * array = [NSMutableArray arrayWithArray:dataMutableDictionary[obj.key]];
                    [array addObject:obj];
                    [dataMutableDictionary setObject:array forKey:obj.key];
                }
            }];
            if (dataMutableDictionary.count) {
                NSMutableDictionary * dataDictionary = [dataMutableDictionary copy];
                NSArray * dataArray = [[dataMutableDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
                if (dataArray) {
                    [LYTourscoolCache saveRequestWithPath:@"allcountries" parameter:@{@"LYCountries":@"LYdataDictionary"} obejct:dataDictionary];
                    [LYTourscoolCache saveRequestWithPath:@"allcountries" parameter:@{@"LYCountries":@"LYdataArray"} obejct:dataArray];
                }
            }
        }
        return value;
    }];
}

- (BOOL)obtainCache
{
    NSDictionary * dictionary = [LYTourscoolCache lcyGetCacheWithPath:@"allcountries" parameter:@{@"LYCountries":@"LYdataDictionary"}];
    NSArray * array =  [LYTourscoolCache lcyGetCacheWithPath:@"allcountries" parameter:@{@"LYCountries":@"LYdataArray"}];
    if (dictionary && array) {
        self.dataDictionary = dictionary;
        self.dataArray = array;
        return YES;
    }
    return NO;
}

- (RACCommand *)httpRequestCountriesCommand
{
    if (!_httpRequestCountriesCommand) {
        @weakify(self);
        _httpRequestCountriesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            if ([self obtainCache]) {
                return [RACSignal return:@{@"code":@"0"}];
            }
            return [[LYCommonSelectViewModel httpRequestAllCountries] map:^id _Nullable(id  _Nullable value) {
                [self obtainCache];
                return value;
            }];
        }];
    }
    return _httpRequestCountriesCommand;
}
@end
