//
//  LYHotelDetailsDatePickerViewModel.h
//  SouthEastProject
//
//  Created by luoyong on 2018/8/7.
//  Copyright © 2018年 Daqsoft. All rights reserved.
//

#import "LYAbstractBookingViewModel.h"
@class EKEvent, LYSelectDatePriceModel;
@interface LYSelectDateViewModel : LYAbstractBookingViewModel
/**
 日期事件数组
 */
@property (nonatomic, readonly, strong) NSArray<EKEvent *> *events;
/**
 缓存
 */
@property (nonatomic, readonly, strong) NSCache *cache;
/**
 最小日期
 */
@property (nonatomic, readonly, strong) NSDate *minimumDate;
/**
 最大日期
 */
@property (nonatomic, readonly, strong) NSDate *maximumDate;


@property (nonatomic, readonly, strong) NSArray * monthArray;
@property (nonatomic, readonly, strong) NSArray * datePriceArray;

@property (nonatomic, readonly, copy) NSString * durationDays;
@property (nonatomic, readonly, copy) NSString * maxNumGuest;
@property (nonatomic, readonly, assign) BOOL isKids;
@property (nonatomic, readonly, assign) BOOL isSinglePu;

/**
 加载日期事件
 */
@property (nonatomic, readonly, strong) RACCommand *loadCalendarEventsCommand;
@property (nonatomic, readonly, strong) RACCommand *addPeopleCommand;
@property (nonatomic, readonly, strong) RACCommand *selectDateCommand;
@property (nonatomic, readonly, strong) RACCommand *immediateBookingButtonCommand;
@property (nonatomic, readonly, strong) RACCommand *httpRequestDateCommand;


/**
 获取事件
 
 @param date 时间
 @return 日期事件
 */
- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date;
/**
 删除缓存
 */
- (void)removeCacheData;
- (NSString *)obtainPriceWithDate:(NSDate *)date;
- (LYSelectDatePriceModel *)obtainSelectDatePriceModelWithDate:(NSDate *)date;
@end
