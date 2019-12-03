//
//  LYOrderDetialViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYOrderDetailInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYOrderDetialViewModel : NSObject
@property(nonatomic, readonly, strong) LYOrderDetailInfoModel *infoModel;
@property(nonatomic, readonly, strong) LYOrderDetailTravelPackageModel *travelPackageModel;
@property(nonatomic, readonly, strong) RACCommand *getDataCommand;
@property(nonatomic, readonly, strong) RACCommand *removeOrderCommand;
//buttonType 0 无按钮 1 cancel 2 Proceed to payment 3 Edit Flight Info 4 Write a Review 5 Remove
//Payment Pending 对应 1，2
//Reservation pending 对应 1
//Booking confirmend 对应 1 3（并且用户选择接驳）
//Traveling 对应 4
//Failed 对应 5
//Completed 对应 5 4
@property(nonatomic, readonly, assign) NSInteger leftButtonType;
@property(nonatomic, readonly, assign) NSInteger rightButtonType;
- (instancetype)initWithParameter:(NSDictionary *)parameter;
@end

NS_ASSUME_NONNULL_END
