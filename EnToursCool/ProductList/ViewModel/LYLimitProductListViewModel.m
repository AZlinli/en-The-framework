//
//  LYLimitProductListViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYLimitProductListViewModel.h"

@interface LYLimitProductListViewModel()
@property(nonatomic, readwrite, copy) NSArray *countryArray;
@property(nonatomic, readwrite, copy) NSArray *dataArray;

@property(nonatomic, readwrite, strong) RACCommand *getDataCommand;
@end

@implementation LYLimitProductListViewModel

- (instancetype)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (RACCommand *)getDataCommand{
    if (!_getDataCommand) {
        @weakify(self);
        _getDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return nil;
        }];
    }
    return _getDataCommand;
}

@end
