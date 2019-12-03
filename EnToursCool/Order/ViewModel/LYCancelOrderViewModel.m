//
//  LYCancelOrderViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCancelOrderViewModel.h"
#import "LYHTTPRequestManager.h"

@interface LYCancelOrderViewModel()
@property(nonatomic, readwrite, strong) RACCommand *submitCommand;
@end

@implementation LYCancelOrderViewModel

- (instancetype)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (RACCommand *)submitCommand{
    if (!_submitCommand) {
        @weakify(self);
        _submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            if (self.reason.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"1"}]; //未选择reason
            }
            return [RACSignal return:@{@"code":@"0",@"type":@"1"}];;
        }];
    }
    return _submitCommand;
}

@end
