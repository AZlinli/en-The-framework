//
//  LYDateTools.h
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

/**
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDateTools : NSObject
+ (NSCalendar *)gregorian;
+ (NSDateFormatter *)dataFormatter;
/**
 日期转字符串

 @param formatterStr 格式
 @param date 日期
 @return 字符串
 */
+ (NSString *)dateToStringWithFormatterStr:(NSString *)formatterStr date:(NSDate *)date;
/**
 字符串转换日期

 @param formatterStr 格式
 @param dateStr 字符串
 @return 日期
 */
+ (NSDate *)stringToDateWithFormatterStr:(NSString *)formatterStr dateStr:(NSString *)dateStr;

+ (NSString *)stringToStringWithFormatterStr:(NSString *)formatterStr dateStr:(NSString *)dateStr toFormatterStr:(NSString *)toFormatterStr;

/**
 获取时间戳
 
 @param date 日期
 @return 时间戳
 */
+ (NSInteger)timeIntervalSince1970WithDate:(NSDate *)date;
/**
 计算日期相隔d多少天

 @param dateOne 日期
 @param dateTwo 日期
 @return 字符串
 */
+ (NSString *)beApartDaydateOne:(NSDate *)dateOne dateTwo:(NSDate *)dateTwo;
+ (NSString *)beApartMinuteOne:(NSDate *)dateOne dateTwo:(NSDate *)dateTwo;
+ (NSString *)beApartSecondOne:(NSDate *)dateOne dateTwo:(NSDate *)dateTwo;
/**
 获取周几

 @param date 日期
 @return 周一
 */
//+ (NSString *)dateToWeekWith:(NSDate *)date;
/**
 获取某个月多少天

 @param year 年
 @param month 月
 @return 多少天
 */
+ (NSInteger)getSumOfDaysInMonth:(NSString *)year month:(NSString *)month;
/**
 日期比较

 @param startDate 开始日期
 @param endDate 结束日期
 @return 1 -1 0
 */
+ (int)compareDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end

NS_ASSUME_NONNULL_END
