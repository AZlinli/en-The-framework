//
//  LYOrderMainListViewModel.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOrderMainListViewModel.h"
#import "LYHTTPRequestManager.h"
#import "LYTourOrderViewController.h"
#import "LYOrderListModel.h"

@interface LYOrderMainListViewModel()

@property (nonatomic, readwrite , strong) NSArray * dataArray;
@property (nonatomic, readwrite, strong) RACCommand *removeCommand;
@property (nonatomic, assign) OrderStatus status;

@end

@implementation LYOrderMainListViewModel



- (RACCommand *)mainOrderCommand
{
    if (!_mainOrderCommand)
    {
        @weakify(self);
        _mainOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input)
        {
            @strongify(self);
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            if (self.status)
//            {
//                dict[@"status"] = @(self.status);
//            }
//            // FIXME: LDL测试
//            return [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(@"orders") parameter:dict.copy cacheType:NO] map:^id _Nullable(id  _Nullable value) {
//                if ([value[@"code"] integerValue] == 0)
//                {
//                     self.dataArray = [[LYOrderListModel mj_objectArrayWithKeyValuesArray:value[@"data"]] copy];
//                }
//                return value;
//            }];
            // FIXME: LDL的假数据
            NSArray *testArray = @[@{@"createDate" : @"Jul 12,2019" , @"statusName" : @"Payment Pending"},@{@"createDate" : @"Jul 12,2019" , @"statusName" : @"Reservation pending"},@{@"createDate" : @"Jul 12,2019" , @"statusName" : @"Booking confirmed"},@{@"createDate" : @"Jul 12,2019" , @"statusName" : @"Traveling"},@{@"createDate" : @"Jul 12,2019" , @"statusName" : @"Completed"},@{@"createDate" : @"Jul 12,2019" , @"statusName" : @"Failed"}];
            self.dataArray = [[LYOrderListModel mj_objectArrayWithKeyValuesArray:testArray] copy];
            
            return [RACSignal empty];
        }];
    }
    return _mainOrderCommand;
}

- (instancetype)initWithParameter:(NSDictionary *)parameter
{
    if (self = [super init])
    {
        [self.mainOrderCommand execute:nil];
        self.status = [parameter[@"status"] integerValue];
    }
    return self;
}

- (RACCommand *)removeCommand{
    if (!_removeCommand) {
        //网络请求 删除成功后，删除array中的数据
        @weakify(self);
        _removeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString * _Nullable IDString) {
            @strongify(self);
            [self removeModel:IDString];
            return [RACSignal return:@{@"code":@"1",@"type":@"test"}];
        }];
    }
    return _removeCommand;
}

- (void)removeModel:(NSString*)IDString{
    NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.dataArray];
    for (LYOrderListModel *model in tmpArray) {
        if ([model.travelID isEqualToString:IDString]) {
            [tmpArray removeObject:model];
            break;
        }
    }
    self.dataArray = [tmpArray copy];
}

- (void)dealloc{
    
}
@end
