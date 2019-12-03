//
//  LYSearchViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//
#import "LYSearchHistoryManager.h"
#import "LYSearchHistoryRecordModel.h"
#import "LYSearchViewModel.h"

#import "LYHTTPRequestManager.h"

@interface LYSearchViewModel()
@property (nonatomic, readwrite, copy) NSArray<LYSearchSectionTitleModel *> * dataArray;
@property (nonatomic, readwrite, copy) NSArray * hotCityData;
@property (nonatomic, readwrite, copy) NSString * itemType;
@property (nonatomic, readwrite, copy) NSString * startCity;
@property (nonatomic, readwrite, copy) NSString * spanCity;
/**
 未被转换的热门城市
 */
@property (nonatomic, readwrite, copy) NSArray * notToObjectHotCityData;
@property (nonatomic, readwrite, copy) NSArray * searchHistoryRecordArray;
@property (nonatomic, readwrite, copy) NSString * lastSearchKeyWord;
@property (nonatomic, readwrite, strong) RACCommand * deleteHistoryCommand;
@property (nonatomic, readwrite, strong) RACCommand * searchCommand;
@property (nonatomic, readwrite, strong) RACCommand * hotCityCommand;
@property (nonatomic, readwrite, strong) RACCommand * didSelectItemCommand;
@end

@implementation LYSearchViewModel
- (instancetype)initWithParameter:(NSDictionary *)parameter
{
    if (self = [super init]) {
        _itemType = parameter[@"itemType"];
        if (!_itemType.length) {
            _itemType = parameter[@"item_type"];
        }
        _startCity = parameter[@"start_city"];
        _spanCity = parameter[@"span_city"];
        @weakify(self);
        
        [[[RACObserve(self, searchTitle) distinctUntilChanged] throttle:0.6] subscribeNext:^(NSString *  _Nullable x) {
            if (!x.length) {
                @strongify(self);
                [self.hotCityCommand execute:nil];
            }else{
                [self.searchCommand execute:nil];
            }
            LYNSLog(@"searchTitle -- %@", x);
        }];
        
    }
    return self;
}


//- (RACCommand *)didSelectItemCommand
//{
//    if (!_didSelectItemCommand) {
//        @weakify(self);
//        _didSelectItemCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSIndexPath *  _Nullable input) {
//            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                @strongify(self);
//                if (self.dataArray.count) {
//                    LYTourscoolBaseCellModel * model = self.dataArray[input.section].dataArray[input.item];
//                    if ([model isKindOfClass:[LYSearchHistoryRecordModel class]]) {
//                        if (input.section == 0) {
//                            [LYAnalyticsServiceManager analyticsEvent:@"HistoryRecord" attributes:nil label:nil];
//                            LYSearchHistoryRecordModel * searchHistoryRecordModel = (LYSearchHistoryRecordModel *)model;
//                            [subscriber sendNext:@{@"key":searchHistoryRecordModel.name,@"type":@"1"}];
//                        }else{
//                            [LYAnalyticsServiceManager analyticsEvent:@"HotSearch" attributes:nil label:nil];
//                            LYSearchHistoryRecordModel * searchHistoryRecordModel = (LYSearchHistoryRecordModel *)model;
//                            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//                            [dic setObject:self.notToObjectHotCityData[input.row] forKey:@"parameter"];
//                            [dic setObject:@"4" forKey:@"type"];
//                            [dic setObject:searchHistoryRecordModel.name forKey:@"key"];
//                            [subscriber sendNext:dic];
//                        }
//                        
//                    }else if ([model isKindOfClass:[LYSearchContentNumberModel class]]) {
//                        LYSearchContentNumberModel * searchContentNumberModel = (LYSearchContentNumberModel *)model;
//                        [LYAnalyticsServiceManager analyticsEvent:@"ClickSearchProductClassify" attributes:nil label:nil];
//                        if ([searchContentNumberModel.productID integerValue] > 0) {
//                            [subscriber sendNext:@{@"productID":searchContentNumberModel.productID,@"type":@"10"}];
//                        }else{
//                            [subscriber sendNext:@{@"key":searchContentNumberModel.type,@"type":@"2",@"itemType":searchContentNumberModel.type}];
//                        }
//                    }else if ([model isKindOfClass:[LYSearchContentModel class]]) {
//                        [LYAnalyticsServiceManager analyticsEvent:@"ClickSearchProduct" attributes:nil label:nil];
//                        LYSearchContentModel * searchContentModel = (LYSearchContentModel *)model;
//                        [subscriber sendNext:@{@"key":searchContentModel.name,@"type":@"3",@"productID":searchContentModel.productID}];
//                    }
//                    
//                }
//                
//                [subscriber sendCompleted];
//                return nil;
//            }];
//        }];
//    }
//    return _didSelectItemCommand;
//}

- (RACCommand *)searchCommand
{
    if (!_searchCommand) {
        @weakify(self);
        _searchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            NSMutableDictionary * para = @{}.mutableCopy;
//            if (self.spanCity.length) {
//                para[@"span_city"] = self.spanCity;
//            }
//            if (self.startCity.length) {
//                para[@"start_city"] = self.startCity;
//            }
            para[@"keyword"] = self.searchTitle;
            return [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(@"associate") parameter:[para copy] cacheType:YES] map:^id _Nullable(id  _Nullable value) {
                if ([value[@"code"] integerValue] == 0) {
                    NSArray * category = value[@"data"][@"category"];
                    NSMutableArray * array = [NSMutableArray array];
                    LYSearchSectionTitleModel * searchSectionTitleModel = [[LYSearchSectionTitleModel alloc] init];
   
                    searchSectionTitleModel.isSearchMatch = YES;
//                  todo
//                    if (category.count) {
//                        searchSectionTitleModel.dataArray = [LYSearchContentNumberModel mj_objectArrayWithKeyValuesArray:category];
//                    }
//                    [array addObject:searchSectionTitleModel];
//
//                    NSArray * product = value[@"data"][@"product"];
//                    if (product.count) {
//                        LYSearchSectionTitleModel * hotSearchSectionTitleModel = [[LYSearchSectionTitleModel alloc] init];
//                        LYSearchShowAllItemModel * searchShowAllItemModel = [[LYSearchShowAllItemModel alloc] init];
//                        NSMutableArray * searchContentModelMutableArray = [LYSearchContentModel mj_objectArrayWithKeyValuesArray:product];
//                        [searchContentModelMutableArray addObject:searchShowAllItemModel];
//                        hotSearchSectionTitleModel.dataArray = [searchContentModelMutableArray copy];
//                        hotSearchSectionTitleModel.title = @"";
//                        hotSearchSectionTitleModel.itemWidth = kScreenWidth;
//                        hotSearchSectionTitleModel.itemHeight = 10.f;
//                        [array addObject:hotSearchSectionTitleModel];
//                    }
                    self.dataArray = [array copy];
                }
                if (!self.dataArray.count) {
                    [self addDefaultData];
                }
                return value;
            }];
        }];
    }
    return _searchCommand;
}

- (RACCommand *)deleteHistoryCommand
{
    if (!_deleteHistoryCommand) {
        @weakify(self);
        _deleteHistoryCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSString *title = input;
            return [[LYSearchHistoryManager deleteOneSearchHistorySignalWithSearchTitle:title] doCompleted:^{
                @strongify(self);
                [self addDefaultData];
            }];
        }];
    }
    return _deleteHistoryCommand;
}

- (RACCommand *)hotCityCommand{
    if (!_hotCityCommand) {
         @weakify(self);
       _hotCityCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           @strongify(self);
           if (self.hotCityData.count) {
               [self addDefaultData];
               return [RACSignal return:nil];
           }
           return [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(@"search") parameter:@{} cacheType:NO] map:^id _Nullable(id  _Nullable value) {
               
               if ([value[@"code"] integerValue] == 0) {
                   self.notToObjectHotCityData = value[@"data"];
                   self.hotCityData = [[LYSearchHistoryRecordModel mj_objectArrayWithKeyValuesArray:self.notToObjectHotCityData] copy];
               }
               [self addDefaultData];
               return value;
           }];
       }];
    }
    return  _hotCityCommand;
}

- (void)addDefaultData
{
    self.searchHistoryRecordArray = [[LYSearchHistoryRecordModel mj_objectArrayWithKeyValuesArray:[LYSearchHistoryManager obtainSearchHistory]] copy];
    NSMutableArray * array = [NSMutableArray array];
    if (self.searchHistoryRecordArray.count) {
        LYSearchSectionTitleModel * searchSectionTitleModel = [[LYSearchSectionTitleModel alloc] init];
        NSMutableArray *tmpArray = [NSMutableArray array];
        [self.searchHistoryRecordArray enumerateObjectsUsingBlock:^(LYSearchHistoryRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LYSearchItemModel *itemModel = [[LYSearchItemModel alloc] init];
            itemModel.showDeleteState = YES;
            itemModel.title = obj.name;
            [tmpArray addObject:itemModel];
        }];
    
        searchSectionTitleModel.dataArray = tmpArray;
        searchSectionTitleModel.title = [LYLanguageManager ly_localizedStringForKey:@"Search_Recent_Searches"];
//        searchSectionTitleModel.itemWidth = kScreenWidth;
//        searchSectionTitleModel.itemHeight = 40.f;
        [array addObject:searchSectionTitleModel];
    }
    if (self.hotCityData.count) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        [self.hotCityData enumerateObjectsUsingBlock:^(LYSearchHistoryRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LYSearchItemModel *itemModel = [[LYSearchItemModel alloc] init];
            itemModel.title = obj.name;
            [tmpArray addObject:itemModel];
        }];
        
        LYSearchSectionTitleModel * hotSearchSectionTitleModel = [[LYSearchSectionTitleModel alloc] init];
        hotSearchSectionTitleModel.dataArray = tmpArray;
        hotSearchSectionTitleModel.title = [LYLanguageManager ly_localizedStringForKey:@"Search_Trending_Destinations"];
        hotSearchSectionTitleModel.itemWidth = kScreenWidth;
//        hotSearchSectionTitleModel.itemHeight = 40.f;
        [array addObject:hotSearchSectionTitleModel];
    }
    self.dataArray = [array copy];
}


- (void)saveSearchHistoryWithDic:(NSDictionary *)dic
{
    [self saveSearchHistoryDBWithDic:dic];
    [self setupSearchHistoryArrayWithDic:dic];
    [self addDefaultData];
}

- (void)addSearchHistoryWithDic:(NSDictionary *)dic
{
    if (dic.count) {
        if (![self.lastSearchKeyWord isEqualToString:self.searchTitle]) {
            self.searchTitle = dic[@"name"];
            self.lastSearchKeyWord = self.searchTitle;
            [self saveSearchHistoryDBWithDic:dic];
            [self setupSearchHistoryArrayWithDic:dic];
            [self addDefaultData];
            [self.searchCommand execute:nil];
        }
    }
}

- (NSInteger)saveSearchHistoryDBWithDic:(NSDictionary *)dic
{
    BOOL result = [LYSearchHistoryManager inserOneSearchHistoryWithDic:dic];
    if (!result) {
        BOOL resultdelete = [LYSearchHistoryManager deleteOneSearchHistoryWithSearchTitle:dic[@"name"]];
        if (resultdelete) {
            [LYSearchHistoryManager inserOneSearchHistoryWithDic:dic];
        }
    }
    return 1;
}

- (void)setupSearchHistoryArrayWithDic:(NSDictionary *)dic
{
    self.searchHistoryRecordArray = [[LYSearchHistoryRecordModel mj_objectArrayWithKeyValuesArray:[LYSearchHistoryManager obtainSearchHistory]] copy];
    if (self.searchHistoryRecordArray.count > 8) {
        LYSearchHistoryRecordModel * model = self.searchHistoryRecordArray.lastObject;
        [LYSearchHistoryManager deleteOneSearchHistoryWithSearchHistoryID:model.searchHistoryRecordid];
        NSMutableArray * searchHistoryRecordArray = [NSMutableArray arrayWithArray:self.searchHistoryRecordArray];
        [searchHistoryRecordArray removeLastObject];
        self.searchHistoryRecordArray = [searchHistoryRecordArray copy];
    }
    
    LYSearchHistoryRecordModel * model = [LYSearchHistoryRecordModel mj_objectWithKeyValues:dic];
    if (!self.searchHistoryRecordArray.count) {
        NSMutableArray * searchHistoryRecordArray = [NSMutableArray array];
        [searchHistoryRecordArray addObject:model];
        self.searchHistoryRecordArray = [searchHistoryRecordArray copy];
    }else{
        NSMutableArray * searchHistoryRecordArray = [NSMutableArray arrayWithArray:self.searchHistoryRecordArray];
        [searchHistoryRecordArray insertObject:model atIndex:0];
        self.searchHistoryRecordArray = [searchHistoryRecordArray copy];
    }
}

@end
