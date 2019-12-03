//
//  LYSSDKAuthorizeManager.m
//  ToursCool
//
//  Created by tourscool on 2/18/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYSSDKAuthorizeManager.h"
#import <ShareSDK/ShareSDK.h>

@implementation LYSSDKAuthorizeManager

+ (void)cancelAuthorizeWithThirdParty:(NSString *)thirdParty
{
    SSDKPlatformType platformType = 0;
    if ([thirdParty isEqualToString:@"qq"]) {
        platformType = SSDKPlatformTypeQQ;
    }else if ([thirdParty isEqualToString:@"wechat"]) {
        platformType = SSDKPlatformTypeWechat;
    }else if ([thirdParty isEqualToString:@"facebook"]) {
        platformType = SSDKPlatformTypeFacebook;
    }else if ([thirdParty isEqualToString:@"sinaweibo"]) {
        platformType = SSDKPlatformTypeSinaWeibo;
    }
    if (platformType != 0) {
        [ShareSDK cancelAuthorize:platformType result:^(NSError *error) {
            LYNSLog(@"%@", error);
        }];
    }
}
//shareSDK iOS13 当未安装微信时，微信登录不是全屏；未安装微博时，微博登录会崩溃
+ (void)authorizePlatformType:(SSDKPlatformType)platformType otherSetting:(NSDictionary *)otherSetting userAuthorizeResult:(void (^)(id x, id userInfo))userAuthorizeResult
{
    [ShareSDK authorize:platformType settings:otherSetting onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        LYNSLog(@"user.credential.rawData === %@", user.credential.rawData);
        LYNSLog(@"error %@", error);
        LYNSLog(@"rawData %@", user.rawData);
        NSDictionary * rawData = user.rawData;
        NSDictionary * credentialRawData = user.credential.rawData;
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        NSMutableDictionary * userInfoDic = [NSMutableDictionary dictionary];
        [dic setObject:@"1" forKey:@"code"];
        if (state == SSDKResponseStateSuccess){
            [dic setObject:@"0" forKey:@"code"];
            if (platformType == SSDKPlatformTypeQQ) {
                [dic setObject:credentialRawData[@"access_token"] forKey:@"access_token"];
                [dic setObject:credentialRawData[@"openid"] forKey:@"unionid"];
                [dic setObject:credentialRawData[@"openid"] forKey:@"openid"];
                [dic setObject:@"qq" forKey:@"third_party"];
                NSString * nickname = @"";
                if (rawData[@"nickname"]) {
                    nickname = rawData[@"nickname"];
                }
                [userInfoDic setObject:rawData[@"nickname"] forKey:@"nickname"];
                NSString * profilePhoto = rawData[@"figureurl_qq"];
                if (!profilePhoto.length) {
                    profilePhoto = rawData[@"figureurl_qq_2"];
                }
                if (!profilePhoto.length) {
                    profilePhoto = rawData[@"figureurl_qq_1"];
                }
                if (!profilePhoto.length) {
                    profilePhoto = rawData[@"figureurl_2"];
                }
                [userInfoDic setObject:profilePhoto forKey:@"profilePhoto"];
            }else if (platformType == SSDKPlatformTypeWechat) {
                [dic setObject:credentialRawData[@"access_token"] forKey:@"access_token"];
                [dic setObject:credentialRawData[@"unionid"] forKey:@"unionid"];
                [dic setObject:credentialRawData[@"openid"] forKey:@"openid"];
                [dic setObject:@"wechat" forKey:@"third_party"];
                NSString * nickname = @"";
                if (rawData[@"nickname"]) {
                    nickname = rawData[@"nickname"];
                }
                [userInfoDic setObject:rawData[@"nickname"] forKey:@"nickname"];
                NSString * profilePhoto = @"";
                profilePhoto = rawData[@"headimgurl"];
                [userInfoDic setObject:profilePhoto forKey:@"profilePhoto"];
            }else if (platformType == SSDKPlatformTypeSinaWeibo) {
                [dic setObject:@"sinaweibo" forKey:@"third_party"];
                [dic setObject:credentialRawData[@"access_token"] forKey:@"access_token"];
                [dic setObject:credentialRawData[@"uid"] forKey:@"unionid"];
                [dic setObject:credentialRawData[@"uid"] forKey:@"openid"];
                if (rawData[@"name"]) {
                    [userInfoDic setObject:rawData[@"name"] forKey:@"nickname"];
                }
                if (rawData[@"avatar_hd"]) {
                    [userInfoDic setObject:rawData[@"avatar_hd"] forKey:@"profilePhoto"];
                }
            }else if (platformType == SSDKPlatformTypeFacebook) {
                [dic setObject:@"facebook" forKey:@"third_party"];
            }
        }else if (state == SSDKResponseStateFail){
            [dic setObject:@"不知为何失败了" forKey:@"msg"];
        }else if (state == SSDKResponseStateCancel){
            [dic setObject:@"您取消了第三方登录" forKey:@"msg"];
        }
        userAuthorizeResult(dic, userInfoDic);
    }];
}



@end
