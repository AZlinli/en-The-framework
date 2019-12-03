//
//  LYUserInfoManager.h
//  ToursCool
//
//  Created by tourscool on 11/13/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYUserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface LYUserInfoManager : NSObject
/**
 是否在中国
 */
@property (nonatomic, assign) BOOL inChina;
/**
 定位城市所在的省
 */
@property (nonatomic, copy) NSString * userLoctionProvince;
/**
 定位城市
 */
@property (nonatomic, copy) NSString * userLoctionCity;
/**
 货币符号
 */
@property (nonatomic, copy) NSString * userCurrencySymbol;
/**
 当前货币
 */
@property (nonatomic, copy) NSString * userCurrency;
/**
 电话号码国际区号
 */
@property (nonatomic, copy) NSString * userPhoneCode;
/**
 国家名字
 */
@property (nonatomic, copy) NSString * userCountryName;

@property (nonatomic, copy) NSString * _Nullable userToken;

@property (nonatomic, readonly, strong) LYUserInfoModel * userInfoModel;
@property (nonatomic, readonly, strong, class) LYUserInfoManager * sharedUserInfoManager;
+ (void)saveUserInfoWithUserInfo:(LYUserInfoModel *)userInfo;
+ (void)updateUserInfoWithUserInfo:(LYUserInfoModel *)userInfo;
+ (void)loginOut;
+ (void)deteleUserInfoModel;
+ (void)saveInKeychainWithAccount:(NSString * _Nullable)account pwd:(NSString * _Nullable)pwd;
+ (NSString *)obtainUserAccount;
+ (NSString *)obtainUserPWD;
+ (void)deteleUserForKeychain;

+ (void)saveUserCurrency:(NSString *)userCurrency;
+ (void)saveUserCurrencySymbol:(NSString *)userCurrencySymbol;

+ (void)addBrowsingHistoryWithProductID:(NSString *)productID;
+ (NSArray *)obtainBrowsingHistory;

/**
 用户是否登录

 @return YES 没有登录 NO 登录
 */
+ (BOOL)userIsLogin;
+ (void)saveUserTokenWith:(NSString *)token;

/**
 更新优惠券数量

 @param number 数量
 @param type YES + NO -
 */
+ (void)modifyTotalCoupons:(NSInteger)number type:(BOOL)type;
/**
 更新米粒数量

 @param number 数量
 @param type YES + NO -
 */
+ (void)modifyTotalPoints:(NSString *)number type:(BOOL)type;
- (BOOL)ly_userInfoManagerNewUser;
@end

NS_ASSUME_NONNULL_END
