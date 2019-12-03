//
//  LYAbstractBookingViewModel.h
//  ToursCool
//
//  Created by tourscool on 7/8/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAbstractBookingViewModel : NSObject

/**
 产品ID
 */
@property (nonatomic, readonly, copy) NSString * productID;
/**
 产品名称
 */
@property (nonatomic, readonly, copy) NSString * productName;
/**
 总价格
 */
@property (nonatomic, readonly, copy) NSString * totalPrice;
/**
 基础价格
 */
@property (nonatomic, readonly, copy) NSString * basePrice;
/**
 房间数组
 */
@property (nonatomic, readonly, strong) NSArray<NSArray *> * peopleArray;
/**
 房间数量
 */
@property (nonatomic, readonly, copy) NSString * roomNumber;
/**
 构建房间
 */
@property (nonatomic, copy) NSArray * rooms;
/**
 成人数量
 */
@property (nonatomic, readonly, copy) NSString * adultNumber;
/**
 儿童数量
 */
@property (nonatomic, readonly, copy) NSString * childNumber;
/**
 选择的日期
 */
@property (nonatomic, strong) NSDate * _Nullable selectDate;
/**
 选择日期字符串
 */
@property (nonatomic, readonly, copy) NSString * selectDateString;
@property (nonatomic, readonly, copy) NSString * minNumGuest;
@property (nonatomic, readonly, assign) NSInteger selfSupport;
@property (nonatomic, readonly, assign) NSInteger productEntityType;
@property (nonatomic, readwrite, copy) NSString * isSpecial;
@property (nonatomic, readonly, copy) NSArray *preferentialInformationArray;
/**
 计算总价格
 */
@property (nonatomic, readonly, strong) RACCommand * calculateTotalPriceCommand;
- (instancetype)initWithParameter:(NSDictionary *)parameter;
- (NSArray *)obtainExpenseDetail;
- (NSArray *)obtainPeopleRoom;
- (BOOL)examinePeople;
- (NSDictionary *)obtainBudgetHTTPParameters;
- (NSDictionary *)replicationNextPageParameter;
@end

NS_ASSUME_NONNULL_END
