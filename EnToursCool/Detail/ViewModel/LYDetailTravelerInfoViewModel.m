//
//  LYDetailTravelerInfoViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailTravelerInfoViewModel.h"

@interface LYDetailTravelerInfoViewModel()
@property(nonatomic, readwrite, copy) NSArray *dataArray;
@property(nonatomic, readwrite, strong) RACCommand *getDataCommand;
@end

@implementation LYDetailTravelerInfoViewModel

- (instancetype)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (RACCommand *)getDataCommand{
    if (!_getDataCommand) {
        
    }
    return _getDataCommand;
}

@end
