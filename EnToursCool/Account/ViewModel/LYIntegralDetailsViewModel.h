//
//  LYIntegralDetailsViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface LYIntegralDetailsInfoModel : NSObject

@property(nonatomic, copy) NSString *total;
@property(nonatomic, copy) NSString *received;
@property(nonatomic, copy) NSString *pending;
@property(nonatomic, copy) NSString *receviedMoney;
@end

@interface LYIntegralDetailsViewModel : NSObject
@property(nonatomic, copy, readonly) NSArray *dataArray;
@property(nonatomic, strong, readonly) LYIntegralDetailsInfoModel *infoModel;
@property(nonatomic, strong, readonly) RACCommand *getDataCommand;
@end

NS_ASSUME_NONNULL_END
