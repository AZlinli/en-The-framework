//
//  LYSharedService.m
//  ToursCool
//
//  Created by tourscool on 1/4/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYSharedService.h"
#import "LYToursCoolConfigurationHeader.h"
#import <ShareSDK/ShareSDK.h>

@implementation LYSharedService
- (BOOL)application:(UIApplication * _Nullable)application didFinishLaunchingWithOptions:(NSDictionary  * _Nullable )launchOptions
{
    // todo
//    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
//        // QQ
//        [platformsRegister setupQQWithAppId:QQAppID appkey:QQAppKey];
//        // WeChat
////        [platformsRegister setupWeChatWithAppId:WeChatAppID appSecret:WeChatAppSecret];
//        [platformsRegister setupWeChatWithAppId:WeChatAppID appSecret:WeChatAppSecret universalLink:UNIVERSAL_LINK];
//        // SinaWeibo
//        [platformsRegister setupSinaWeiboWithAppkey:SinaWeiboAppKey appSecret:SinaWeiboAppSecret redirectUrl:@"https://www.tourscool.com/"];
////        // Facebook
////        [platformsRegister setupFacebookWithAppkey:FacebookAppKey appSecret:FacebookAppSecret displayName:FacebookDisplayName];
//    }];
    
    return YES;
}
@end
