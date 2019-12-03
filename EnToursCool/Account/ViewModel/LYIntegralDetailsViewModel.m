//
//  LYIntegralDetailsViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYIntegralDetailsViewModel.h"
#import "LYIntegralDetailsModel.h"

@implementation LYIntegralDetailsInfoModel


@end

@interface LYIntegralDetailsViewModel()
@property(nonatomic, strong, readwrite) LYIntegralDetailsInfoModel *infoModel;
@property(nonatomic, strong, readwrite) RACCommand *getDataCommand;
@property(nonatomic, copy, readwrite) NSArray *dataArray;
@end

@implementation LYIntegralDetailsViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        LYIntegralDetailsInfoModel *infoModel = [[LYIntegralDetailsInfoModel alloc] init];
        infoModel.total = @"5000";
        infoModel.received = @"4000";
        infoModel.pending = @"1000";
        infoModel.receviedMoney = @"About US$ 400";
        self.infoModel = infoModel;
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        LYIntegralDetailsModel *model0 = [[LYIntegralDetailsModel alloc] init];
        model0.title = @"Daily check-in points";
        model0.date = @"7/14/2019  20:36";
        model0.status = IntegralDetailsStatus_Get;
        model0.number = @"+5";
        [tmpArray addObject:model0];
        
        LYIntegralDetailsModel *model1 = [[LYIntegralDetailsModel alloc] init];
        model1.title = @"Daily check-in points";
        model1.date = @"7/14/2019  20:36";
        model1.status = IntegralDetailsStatus_Pending;
        model1.number = @"+15";
        model1.desc = @"Accountd after the order is completed";
        [tmpArray addObject:model1];
        
        LYIntegralDetailsModel *model2 = [[LYIntegralDetailsModel alloc] init];
        model2.title = @"Daily check-in points";
        model2.date = @"7/14/2019  20:36";
        model2.status = IntegralDetailsStatus_Pay;
        model2.number = @"-5";
        [tmpArray addObject:model2];
        self.dataArray = [tmpArray copy];
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
