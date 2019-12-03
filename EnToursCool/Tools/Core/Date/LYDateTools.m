//
//  LYDateTools.m
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYDateTools.h"
static NSString *const kCurrentDateFormatter = @"toursCoolCurrentDateFormatter";
static NSString *const kCurrentGregorian = @"toursCoolCurrentGregorian";
static LYDateTools * dateUtil = nil;
@interface LYDateTools()

@end
@implementation LYDateTools

+ (NSDate *)stringToDateWithFormatterStr:(NSString *)formatterStr dateStr:(NSString *)dateStr
{
    [[LYDateTools dataFormatter] setDateFormat:formatterStr];
    NSDate * date = [[LYDateTools dataFormatter] dateFromString:dateStr];
    return date;
}

+ (NSString *)stringToStringWithFormatterStr:(NSString *)formatterStr dateStr:(NSString *)dateStr toFormatterStr:(NSString *)toFormatterStr
{
    NSDate * date = [LYDateTools stringToDateWithFormatterStr:formatterStr dateStr:dateStr];
    return [LYDateTools dateToStringWithFormatterStr:toFormatterStr date:date];
}

+ (NSString *)dateToStringWithFormatterStr:(NSString *)formatterStr date:(NSDate *)date
{
    [[LYDateTools dataFormatter] setDateFormat:formatterStr];
    NSString * dateStr = [[LYDateTools dataFormatter] stringFromDate:date];
    return dateStr;
}

+ (NSString *)beApartDaydateOne:(NSDate *)dateOne dateTwo:(NSDate *)dateTwo
{
    if (!dateOne || !dateTwo) {
        return @"0";
    }
    NSDateComponents *comps = [[LYDateTools gregorian] components:NSCalendarUnitDay fromDate:dateOne toDate:dateTwo options:NSCalendarMatchStrictly];
    return [NSString stringWithFormat:@"%ld", (long)[comps day]];
}

+ (NSString *)beApartMinuteOne:(NSDate *)dateOne dateTwo:(NSDate *)dateTwo
{
    if (!dateOne || !dateTwo) {
        return @"0";
    }
    NSDateComponents *comps = [[LYDateTools gregorian] components:NSCalendarUnitSecond fromDate:dateOne toDate:dateTwo options:NSCalendarMatchStrictly];
    return [NSString stringWithFormat:@"%@", @([comps minute])];
}

+ (NSString *)beApartSecondOne:(NSDate *)dateOne dateTwo:(NSDate *)dateTwo
{
    if (!dateOne || !dateTwo) {
        return @"0";
    }
//    NSDateComponents *comps = [[LYDateTools gregorian] components:NSCalendarUnitMinute fromDate:dateOne toDate:dateTwo options:NSCalendarMatchStrictly];
//    return [NSString stringWithFormat:@"%@", @([comps minute])];
    
    NSDateComponents *comps = [[LYDateTools gregorian] components:NSCalendarUnitSecond fromDate:dateOne toDate:dateTwo options:NSCalendarMatchStrictly];
    return [NSString stringWithFormat:@"%@", @([comps second])];
}

//+ (NSString *)dateToWeekWith:(NSDate *)date
//{
//    if (!date) {
//        return @"0";
//    }
//    NSDateComponents * components = [[LYDateTools gregorian] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
//    if ([[LYDateTools gregorian] isDateInTomorrow:date]) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Tomorrow"];
//    }
//    if ([[LYDateTools gregorian] isDateInToday:date]) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Today"];
//    }
//    return [LYDateTools weekdayToStringWithWeekday:[components weekday]];
//}
//
//+ (NSString *)weekdayToStringWithWeekday:(NSInteger)weekday
//{
//    if (weekday == 1) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Weekend"];
//    }
//    if (weekday == 2) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Monday"];
//    }
//    if (weekday == 3) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Tuesday"];
//    }
//    if (weekday == 4) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Wednesday"];
//    }
//    if (weekday == 5) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Thursday"];
//    }
//    if (weekday == 6) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Friday"];
//    }
//    if (weekday == 7) {
//        return [LYLanguageManager ly_localizedStringForKey:@"LY_Saturday"];
//    }
//    return @"";
//}

+ (NSInteger)timeIntervalSince1970WithDate:(NSDate *)date
{
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+ (NSInteger)getSumOfDaysInMonth:(NSString *)year month:(NSString *)month
{
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",year,month];
    NSDate * date = [LYDateTools stringToDateWithFormatterStr:@"yyyy-MM" dateStr:dateStr];
    
    NSCalendar * calendar = [LYDateTools gregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}

+ (NSCalendar *)gregorian
{
    NSMutableDictionary *threadDict = [NSThread currentThread].threadDictionary;
    NSCalendar *gregorian = threadDict[kCurrentGregorian];
    if (!gregorian) {
        @synchronized (self) {
            if (!gregorian) {
                gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
                threadDict[kCurrentGregorian] = gregorian;
                return gregorian;
            }
            return gregorian;
        }
    }
    return gregorian;
}

+ (NSDateFormatter *)dataFormatter
{
    NSMutableDictionary *threadDict = [NSThread currentThread].threadDictionary;
    NSDateFormatter *dateFormatter = threadDict[kCurrentDateFormatter];
    if (!dateFormatter) {
        @synchronized (self) {
            if (!dateFormatter) {
                dateFormatter = [[NSDateFormatter alloc] init];
                threadDict[kCurrentDateFormatter] = dateFormatter;
                return dateFormatter;
            }
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            return dateFormatter;
        }
    }
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    return dateFormatter;
}

+ (int)compareDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSComparisonResult result = [startDate compare:endDate];
    switch (result) {
        case NSOrderedSame:
            return 0;
        case NSOrderedAscending:
            return -1;
        case NSOrderedDescending:
            return 1;
    }
}

@end
