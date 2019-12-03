//
//  LYDateSelectPriceAndMonthModel.m
//  ToursCool
//
//  Created by tourscool on 11/2/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSelectDatePriceAndMonthModel.h"
#import "LYDateTools.h"

@implementation LYSelectDatePriceAndMonthModel
- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    self.monthDate = [NSString stringWithFormat:@"%@月", self.month];
    self.date = [LYDateTools stringToDateWithFormatterStr:@"yyyy-MM" dateStr:[NSString stringWithFormat:@"%@-%@", self.years, self.month]];
}
@end
