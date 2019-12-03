//
//  LYTravelerInformationViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTravelerInformationViewModel.h"
#import "LYTravelerInformationModel.h"

@interface LYTravelerInformationViewModel()
@property(nonatomic, readwrite, copy) NSArray *dataArray;

@property(nonatomic, readwrite, strong) RACCommand *getDataCommand;
@property(nonatomic, readwrite, strong) RACCommand *removeCommand;
@end

@implementation LYTravelerInformationViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        LYTravelerInformationModel *model = [[LYTravelerInformationModel alloc] init];
        model.title = @"dhasdiuh";
        model.brithDate = @"Jul.8.1996";
        model.IDString = @"1";
        [array addObject:model];

        LYTravelerInformationModel *model1 = [[LYTravelerInformationModel alloc] init];
        model1.title = @"dhasdiuh";
        model1.brithDate = @"Jul.8.1996";
        model1.IDString = @"2";
        [array addObject:model1];

        LYTravelerInformationModel *model2 = [[LYTravelerInformationModel alloc] init];
        model2.title = @"dhasdiuh";
        model2.brithDate = @"Jul.8.1996";
        model2.IDString = @"3";
        [array addObject:model2];
        
        self.dataArray = [array copy];
    }
    return self;
}

- (RACCommand *)getDataCommand{
    if (!_getDataCommand) {
        
    }
    return _getDataCommand;
}

- (RACCommand *)removeCommand{
    if (!_removeCommand) {
        //网络请求 删除成功后，c删除array中的数据
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
    for (LYTravelerInformationModel *model in tmpArray) {
        if ([model.IDString isEqualToString:IDString]) {
            [tmpArray removeObject:model];
            break;
        }
    }
    self.dataArray = [tmpArray copy];
}
@end
