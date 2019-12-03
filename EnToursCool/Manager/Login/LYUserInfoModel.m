//
//  LYUserInfoModel.m
//  ToursCool
//
//  Created by tourscool on 11/13/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYUserInfoModel.h"
#import "LYUserInfoManager.h"
@implementation LYUserInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"chineseName":@"chinese_name",
             @"firstName":@"first_name",
             @"lastName":@"last_name",
             @"customerID":@"customer_id",
             @"totalPoints":@"total_points",
             @"exchangePrice":@"exchange_price",
             @"telCode":@"tel_code",
             @"isPassword":@"is_password",
             @"totalCoupons":@"total_coupons"
             };
}

- (void)updateUserInfoWithUserInfoModel:(LYUserInfoModel *)userInfoModel;
{
    if ([LYUserInfoModel propertyCompare:self.nickname newString:userInfoModel.nickname]) {
        self.nickname = userInfoModel.nickname;
    }
    if ([LYUserInfoModel propertyCompare:self.chineseName newString:userInfoModel.chineseName]) {
        self.chineseName = userInfoModel.chineseName;
    }
    if ([LYUserInfoModel propertyCompare:self.customerID newString:userInfoModel.customerID]) {
        self.customerID = userInfoModel.customerID;
    }
    if ([LYUserInfoModel propertyCompare:self.dob newString:userInfoModel.dob]) {
        self.dob = userInfoModel.dob;
    }
    if ([LYUserInfoModel propertyCompare:self.email newString:userInfoModel.email]) {
        self.email = userInfoModel.email;
    }
    if ([LYUserInfoModel propertyCompare:self.face newString:userInfoModel.face]) {
        self.face = userInfoModel.face;
    }
    if ([LYUserInfoModel propertyCompare:self.firstName newString:userInfoModel.firstName]) {
        self.firstName = userInfoModel.firstName;
    }
    if ([LYUserInfoModel propertyCompare:self.lastName newString:userInfoModel.lastName]) {
        self.lastName = userInfoModel.lastName;
    }
    if ([LYUserInfoModel propertyCompare:self.gender newString:userInfoModel.gender]) {
        self.gender = userInfoModel.gender;
    }
    if ([LYUserInfoModel propertyCompare:self.phone newString:userInfoModel.phone]) {
        self.phone = userInfoModel.phone;
    }
    if ([LYUserInfoModel propertyCompare:self.telCode newString:userInfoModel.telCode]) {
        self.telCode = userInfoModel.telCode;
    }
    if ([LYUserInfoModel propertyCompare:self.totalPoints newString:userInfoModel.totalPoints]) {
        self.totalPoints = userInfoModel.totalPoints;
    }
    if ([LYUserInfoModel propertyCompare:self.exchangePrice newString:userInfoModel.exchangePrice]) {
        self.exchangePrice = userInfoModel.exchangePrice;
    }
    if ([LYUserInfoModel propertyCompare:self.isPassword newString:userInfoModel.isPassword]) {
        self.isPassword = userInfoModel.isPassword;
    }
    if ([LYUserInfoModel propertyCompare:self.totalCoupons newString:userInfoModel.totalCoupons]) {
        self.totalCoupons = userInfoModel.totalCoupons;
    }
    if ([LYUserInfoModel propertyCompare:self.grade newString:userInfoModel.grade]) {
        self.grade = userInfoModel.grade;
    }
}

+ (BOOL)propertyCompare:(NSString *)oldString newString:(NSString *)newString
{
    return ![oldString isEqualToString:newString];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    if (!self.exchangePrice.length) {
        self.exchangePrice = [NSString stringWithFormat:@"%@0.00", LYUserInfoManager.sharedUserInfoManager.userCurrencySymbol];
    }
}

- (BOOL)ly_newUser
{
    if ([self.grade isEqualToString:@"new_notpay"]) {
        return YES;
    }
    return NO;
}

@end
