//
//  LYReviewDetailViewModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailViewModel.h"
#import "LYHTTPRequestManager.h"
#import "LYReviewDetailModel.h"

@interface LYReviewDetailViewModel()
@property(nonatomic, strong,readwrite) NSArray *dataArray;

@end
@implementation LYReviewDetailViewModel

- (NSArray *)dataArray {
    if (!_dataArray ) {
        _dataArray = [NSArray array];
        NSMutableArray *array = [NSMutableArray array];
        LYReviewDetailModel *model = [LYReviewDetailModel new];
           model.url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574145290284&di=ea4ba515e0432cad73ff2b1e5f8f7500&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20120323%2FImg338614056.jpg";
           model.type = 1;
           
           LYReviewDetailModel *model2 = [LYReviewDetailModel new];
           model2.text = @"Niagara Falls is something everyone must see in their lifetime. Mesmerizing by day and breathtaking at night when the LED lights constantly changingNiagara Falls is something everyone must see in their lifetime. Mesmerizing by day and breathtaking at night when the LED lights constantly changingNiagara Falls is something everyone must see in their lifetime. Mesmerizing by day and breathtaking at night when the LED lights constantly changing...";
           model2.type = 2;
        [array addObject:model2];
        [array addObject:model];
        [array addObject:model];
        [array addObject:model];
        _dataArray = array.copy;
    }
    return _dataArray;
}

- (RACCommand *)detailCommand {
    if (!_detailCommand) {
        
        _detailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:self.dataArray];
                [subscriber sendCompleted];
                return nil;
            }];
//            return [[LYHTTPRequestManager HTTPGetRequestWithAction:@"" parameter:parameter cacheType:NO]map:^id _Nullable(id  _Nullable value) {
//
//
//
//                return value;
//            }];
        }];
    }
    return _detailCommand;
}
@end


