//
//  LYUserInfoManager.m
//  ToursCool
//
//  Created by tourscool on 11/13/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYUserInfoManager.h"
#import "LYUserInfoModel.h"


static NSString * LYUserAccount = @"ToursCoolLYUserName";
static NSString * LYUserPassword = @"ToursCoolLYUserPassword";
static NSString * LYServiceName = @"ToursCoolLYSaveServiceName";


static LYUserInfoManager * userInfoManager = nil;

@interface LYUserInfoManager ()
@property (nonatomic, readwrite, strong) LYUserInfoModel * userInfoModel;
@end

@implementation LYUserInfoManager
+ (LYUserInfoManager *)sharedUserInfoManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfoManager = [[LYUserInfoManager alloc] init];
    });
    return userInfoManager;
}

+ (void)saveUserCurrency:(NSString *)userCurrency
{
    if (userCurrency.length) {
        [[NSUserDefaults standardUserDefaults] setObject:userCurrency forKey:LYUserCurrency];
        LYUserInfoManager.sharedUserInfoManager.userCurrency = userCurrency;
    }
}
+ (void)saveUserCurrencySymbol:(NSString *)userCurrencySymbol
{
    if (userCurrencySymbol.length) {
        [[NSUserDefaults standardUserDefaults] setObject:userCurrencySymbol forKey:LYUserCurrencySymbol];
        LYUserInfoManager.sharedUserInfoManager.userCurrencySymbol = userCurrencySymbol;
    }
}

- (NSString *)userCurrency
{
    NSString * currency = [[NSUserDefaults standardUserDefaults] objectForKey:LYUserCurrency];
    if (currency.length) {
        return currency;
    }
    return @"CNY";
}

- (NSString *)userCurrencySymbol
{
    NSString * symbol = [[NSUserDefaults standardUserDefaults] objectForKey:LYUserCurrencySymbol];
    if (symbol.length) {
        return symbol;
    }
    return @"¥";
}

- (NSString *)userPhoneCode
{
    return @"86";
}

- (NSString *)userCountryName
{
    return @"中国";
}

+ (void)deteleUserForKeychain
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LYUserAccount];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LYUserPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveInKeychainWithAccount:(NSString *)account pwd:(NSString *)pwd
{
    if (account.length) {
        [[NSUserDefaults standardUserDefaults] setObject:account forKey:LYUserAccount];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (pwd.length) {
        [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:LYUserPassword];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSString *)obtainUserAccount
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LYUserAccount];
}

+ (NSString *)obtainUserPWD
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LYUserPassword];
}

+ (void)deteleUserInfoModel
{
    LYUserInfoManager.sharedUserInfoManager.userInfoModel = nil;
}

+ (void)saveUserInfoWithUserInfo:(LYUserInfoModel *)userInfo
{
    if ([userInfo ly_newUser]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kNeverShowInviteNewPeopleKey];
    }
    LYUserInfoManager.sharedUserInfoManager.userInfoModel = userInfo;
}

+ (void)updateUserInfoWithUserInfo:(LYUserInfoModel *)userInfo
{
    if (LYUserInfoManager.sharedUserInfoManager.userInfoModel) {
        [LYUserInfoManager.sharedUserInfoManager.userInfoModel updateUserInfoWithUserInfoModel:userInfo];
    }else{
        [LYUserInfoManager saveUserInfoWithUserInfo:userInfo];
    }
}

+ (void)loginOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LYUserToken];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LYUserLogOut];
    [[NSUserDefaults standardUserDefaults] synchronize];
    LYUserInfoManager.sharedUserInfoManager.userInfoModel = nil;
    LYUserInfoManager.sharedUserInfoManager.userToken = nil;
}

+ (BOOL)userIsLogin
{
    if (LYUserInfoManager.sharedUserInfoManager.userInfoModel.customerID) {
        return YES;
    }
    return NO;
}
+ (void)saveUserTokenWith:(NSString *)token
{
    if (token.length) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:LYUserLogOut];
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:LYUserToken];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:LYUserLoginTime];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [LYUserInfoManager sharedUserInfoManager].userToken = token;
    }
}

+ (void)modifyTotalCoupons:(NSInteger)number type:(BOOL)type
{
    NSInteger totalCoupons = [[LYUserInfoManager sharedUserInfoManager].userInfoModel.totalCoupons integerValue];
    if (type) {
        [LYUserInfoManager sharedUserInfoManager].userInfoModel.totalCoupons = [NSString stringWithFormat:@"%@", @(totalCoupons + number)];
    }else{
        if (totalCoupons > 0) {
            [LYUserInfoManager sharedUserInfoManager].userInfoModel.totalCoupons = [NSString stringWithFormat:@"%@", @(totalCoupons - number)];
        }
    }
}

+ (void)modifyTotalPoints:(NSString *)number type:(BOOL)type
{
    NSInteger totalPoints = [[LYUserInfoManager sharedUserInfoManager].userInfoModel.totalPoints integerValue];
    if (type) {
        LYUserInfoManager.sharedUserInfoManager.userInfoModel.totalPoints = [NSString stringWithFormat:@"%@", @(totalPoints + [number integerValue])];
    }else{
        if (totalPoints > 0) {
            LYUserInfoManager.sharedUserInfoManager.userInfoModel.totalPoints = [NSString stringWithFormat:@"%@", @(totalPoints - [number integerValue])];
        }
    }
}

#pragma mark - 临时方法 存储 浏览记录

+ (void)addBrowsingHistoryWithProductID:(NSString *)productID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:[userDefaults objectForKey:@"LYBrowsingHistory"]];
    if ([mutableArray containsObject:productID]) {
        [mutableArray removeObject:productID];
        [mutableArray insertObject:productID atIndex:0];
    }else{
        [mutableArray insertObject:productID atIndex:0];
    }
    if (mutableArray.count > 6) {
        [mutableArray removeLastObject];
    }
    [userDefaults setObject:mutableArray forKey:@"LYBrowsingHistory"];
    [userDefaults synchronize];
}

+ (NSArray *)obtainBrowsingHistory
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray * browsingHistory = [userDefaults objectForKey:@"LYBrowsingHistory"];
    if (!browsingHistory.count) {
        return @[];
    }
    return browsingHistory;
}

- (BOOL)ly_userInfoManagerNewUser
{
    if (!self.userInfoModel) {
        return YES;
    }
    return [self.userInfoModel ly_newUser];
}

@end
