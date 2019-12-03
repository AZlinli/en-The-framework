//
//  LYLoginViewModel.h
//  ToursCool
//
//  Created by tourscool on 11/7/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface LYAutoLoginViewModel : NSObject
+ (void)autoLogin;
+ (void)obtainUserInfo;
+ (void)obtainUserInfoCompleted:(void(^)(id userInfoValue))userInfoCompleted;
+ (void)changeUserInfoModelGradeState;
+ (BOOL)deleteUserToken;
/**
 更新用户信息
 */
+ (void)updateUserInfo;
/**
 更新积分和米粒
 */
+ (void)updateUserIntegral;
+ (void)updateExchangePrice;
@end

NS_ASSUME_NONNULL_END
