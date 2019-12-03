//
//  LYOrderDetailInfoModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOrderDetailInfoModel.h"
#import "NSObject+LYCalculatedHeightWidth.h"

@implementation LYOrderDetailInfoModel

@end

@implementation LYOrderDetailTravelPackageModel



- (CGFloat)cellHeight{
    CGFloat result = 54.f + 20.f;
    //title 高度
    CGFloat titleHeight = [self.productTitle getHeightWithText:self.productTitle width:kScreenWidth - 52 font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    result += titleHeight;
    result += 18.f;
    result += 16.f + 20.f;
    result += 16.f ;
//    valueAddedServiceHeight
    if (self.valueAddedService.length > 0) {
        result += 20.f +16.f + 8.f;
        CGFloat valueAddedServiceHeight = [self.valueAddedService getHeightWithText:self.valueAddedService width:kScreenWidth - 52 font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
        result += valueAddedServiceHeight;
    }
    result += 20.f;
    result += 16.f + 8.f;
    CGFloat travelerHeight = [self.traveler getHeightWithText:self.traveler width:kScreenWidth - 52 font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    result += travelerHeight + 20.f;
    result += 153.f;
    
    //航班
    if (self.isFlight) {
         result += 20.f;
        result += 16.f + 8.f;
        CGFloat arrivalAirLine = [self.arrivalAirline getHeightWithText:self.arrivalAirline width:kScreenWidth - 52 font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
        result += arrivalAirLine + 2.f;
        result += 16.f+2.f+16.f+2.f + 16.f;
        result += 20.f;
        result += 16.f + 8.f;
        CGFloat departureAirLine = [self.departureAirline getHeightWithText:self.departureAirline width:kScreenWidth - 52 font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
         result += departureAirLine + 2.f;
         result += 16.f+2.f+16.f+2.f + 16.f;
    }
    
    return result;
}

@end
