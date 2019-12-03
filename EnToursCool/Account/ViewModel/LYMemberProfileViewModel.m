//
//  LYMemberProfileViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/29.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYMemberProfileViewModel.h"

@interface LYMemberProfileViewModel()
@property(nonatomic, readwrite, strong) RACCommand *saveCommand;
@end

@implementation LYMemberProfileViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (RACCommand *)saveCommand{
    if (!_saveCommand) {
        @weakify(self);
        _saveCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
             
           if (self.name.length == 0) {
               return [RACSignal return:@{@"code":@"1",@"type":@"1"}];
           }
           if (self.birthDate.length == 0) {
               return [RACSignal return:@{@"code":@"1",@"type":@"2"}];
           }

           return [RACSignal return:@{@"code":@"0",@"type":@"1"}];
        }];
    }
    return _saveCommand;
}

@end
