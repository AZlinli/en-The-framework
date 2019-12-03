//
//  LYSelectDatePriceModel.m
//  ToursCool
//
//  Created by tourscool on 11/2/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSelectDatePriceModel.h"
#import "LYDateTools.h"

@implementation LYSelectDatePriceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"isSoldout":@"is_soldout",@"isOverride":@"is_override"};
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    self.dateString = [NSString stringWithFormat:@"%@-%@-%@", self.years, self.month, self.day];
    self.date = [LYDateTools stringToDateWithFormatterStr:@"yyyy-MM-dd" dateStr:self.dateString];
}
@end
