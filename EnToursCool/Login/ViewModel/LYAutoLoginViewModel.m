//
//  LYLoginViewModel.m
//  ToursCool
//
//  Created by tourscool on 11/7/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYAutoLoginViewModel.h"
#import "LYHTTPRequestManager.h"
#import "LYUserInfoManager.h"
#import "LYUserInfoModel.h"
#import "LYDateTools.h"
#import "NSString+LYTool.h"
@interface LYAutoLoginViewModel()

@end

@implementation LYAutoLoginViewModel

+ (BOOL)deleteUserToken
{
    NSDate * userLoginTime = [[NSUserDefaults standardUserDefaults] objectForKey:LYUserLoginTime];
    if ([[LYDateTools beApartDaydateOne:userLoginTime dateTwo:[NSDate new]] integerValue] >= 10) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LYUserToken];
        [LYUserInfoManager loginOut];
        return NO;
    }

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:LYUserLogOut] integerValue] != 2) {
        return NO;
    }
    return YES;
}

+ (void)autoLogin
{
    if (![LYAutoLoginViewModel deleteUserToken]) {
        return ;
    }
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:LYUserToken];
    if (userToken.length) {
        [LYUserInfoManager sharedUserInfoManager].userToken = userToken;
        [LYHTTPRequestManager setSessionManagerValue:userToken forHTTPHeaderField:@"Authorization"];
        [LYAutoLoginViewModel obtainUserInfo];
    }
}

+ (void)obtainUserInfo
{
//    if (LYUserInfoManager.sharedUserInfoManager.userToken) {
//        [[LYHTTPRequestManager HTTPGetRequestWithAction:@"profile" parameter:@{} cacheType:NO] subscribeNext:^(id  _Nullable value) {
//            NSLog(@"UserInfo -- %@", value[@"msg"]);
//            if ([value[@"code"] integerValue] == 0) {
//                NSLog(@"UserInfo -- %@", value);
//                [LYUserInfoManager saveUserInfoWithUserInfo:[LYUserInfoModel mj_objectWithKeyValues:value[@"data"]]];
//            }
//        }];
//    }
    [LYAutoLoginViewModel obtainUserInfoCompleted:^(id userInfoValue) {
        if (userInfoValue) {
            if ([userInfoValue[@"code"] integerValue] == 0) {
                [LYUserInfoManager saveUserInfoWithUserInfo:[LYUserInfoModel mj_objectWithKeyValues:userInfoValue[@"data"]]];
            }
        }
    }];
}

+ (void)changeUserInfoModelGradeState
{
    LYUserInfoModel * userInfoModel = [[LYUserInfoModel alloc] init];
    LYUserInfoModel * currentUserInfoModel = LYUserInfoManager.sharedUserInfoManager.userInfoModel;
    if (currentUserInfoModel) {
        [userInfoModel updateUserInfoWithUserInfoModel:currentUserInfoModel];
        userInfoModel.grade = @"old";
        [LYUserInfoManager saveUserInfoWithUserInfo:userInfoModel];
    }
}

+ (void)updateUserInfo
{
    [LYAutoLoginViewModel obtainUserInfoCompleted:^(id userInfoValue) {
        if (userInfoValue) {
            if ([userInfoValue[@"code"] integerValue] == 0) {
                [LYUserInfoManager updateUserInfoWithUserInfo:[LYUserInfoModel mj_objectWithKeyValues:userInfoValue[@"data"]]];
            }
        }
    }];
}

+ (void)obtainUserInfoCompleted:(void(^)(id userInfoValue))userInfoCompleted
{
    if (LYUserInfoManager.sharedUserInfoManager.userToken) {
        [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(@"profile") parameter:@{} cacheType:NO] subscribeNext:^(id  _Nullable value) {
            LYNSLog(@"UserInfo Profile -- %@", value);
            if (userInfoCompleted) {
                userInfoCompleted(value);
            }
        } error:^(NSError * _Nullable error) {
            if (userInfoCompleted) {
                userInfoCompleted(nil);
            }
        }];
    }else{
        if (userInfoCompleted) {
            userInfoCompleted(nil);
        }
    }
}

+ (void)updateExchangePrice
{
    [LYAutoLoginViewModel obtainUserInfoCompleted:^(id userInfoValue) {
        if (userInfoValue) {
            if ([userInfoValue[@"code"] integerValue] == 0) {
                LYUserInfoModel * userInfoModel = [LYUserInfoModel mj_objectWithKeyValues:userInfoValue[@"data"]];
                LYUserInfoManager.sharedUserInfoManager.userInfoModel.exchangePrice = userInfoModel.exchangePrice;
            }
        }
    }];
}


+ (void)updateUserIntegral
{
    [LYAutoLoginViewModel obtainUserInfoCompleted:^(id userInfoValue) {
        if (userInfoValue) {
            if ([userInfoValue[@"code"] integerValue] == 0) {
                LYUserInfoModel * userInfoModel = [LYUserInfoModel mj_objectWithKeyValues:userInfoValue[@"data"]];
                LYUserInfoManager.sharedUserInfoManager.userInfoModel.totalPoints = userInfoModel.totalPoints;
                LYUserInfoManager.sharedUserInfoManager.userInfoModel.exchangePrice = userInfoModel.exchangePrice;
            }
        }
    }];
//    if (LYUserInfoManager.sharedUserInfoManager.userToken) {
//        [[LYHTTPRequestManager HTTPGetRequestWithAction:@"profile" parameter:@{} cacheType:NO] subscribeNext:^(id  _Nullable value) {
//
//        }];
//    }
}

- (void)dealloc
{
    LYNSLog(@"dealloc - %@", NSStringFromClass([self class]));
}

@end
