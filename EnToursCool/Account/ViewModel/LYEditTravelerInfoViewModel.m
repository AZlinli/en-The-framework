//
//  LYEditTravelerInfoViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYEditTravelerInfoViewModel.h"
#import "LYHTTPRequestManager.h"

@interface LYEditTravelerInfoViewModel()
@property(nonatomic, readwrite, strong) RACCommand *saveCommand;
@property(nonatomic, strong) LYTravelerInformationModel *model;
@end

@implementation LYEditTravelerInfoViewModel

- (instancetype)initWithModel:(LYTravelerInformationModel*)model{
    self = [super init];
    if (self) {
        self.model = model;
        self.brithDate = model.brithDate;
        self.country = model.country;
        self.firstName = model.firstName;
        self.lastName = model.lastName;
        self.passport = model.passport;
    }
    return self;
}

- (instancetype)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (RACCommand *)saveCommand{
    if (!_saveCommand) {
        _saveCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            if(self.firstName.length == 0){
                return [RACSignal return:@{@"code":@"1",@"type":@"1"}];
            }
            
            if (self.lastName.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"2"}];
            }
            
            if (self.brithDate.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"3"}];
            }
            
            if (self.country.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"4"}];
            }
            
            if (self.passport.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"5"}];
            }
            
            
             return [RACSignal return:@{@"code":@"0",@"type":@"200"}];
 
            
        }];
    }
    return _saveCommand;
}

@end
