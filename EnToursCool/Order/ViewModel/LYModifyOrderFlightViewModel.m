//
//  LYModifyOrderFlightViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYModifyOrderFlightViewModel.h"
#import "LYHTTPRequestManager.h"

@interface LYModifyOrderFlightViewModel()
@property(nonatomic, readwrite, strong) RACCommand *submitCommand;
@end

@implementation LYModifyOrderFlightViewModel
- (instancetype)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (RACCommand *)submitCommand{
    if (!_submitCommand) {
        _submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            if (self.arrivalAirline.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"1"}];
            }
            if (self.arrivalFlightNumber.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"2"}];
            }
            if (self.arrivalLandingAirport.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"3"}];
            }
            if (self.arrivalTime.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"4"}];
            }
            if (self.departureAirline.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"5"}];
            }
            if (self.departureFlightNumber.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"6"}];
            }
            if (self.departureAirport.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"7"}];
            }
            if (self.departureTime.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"8"}];
            }
            return [RACSignal return:@{@"code":@"0",@"type":@"1"}];
        }];
    }
    return _submitCommand;
}

@end
