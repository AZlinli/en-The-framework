//
//  LYPayService.m
//  ToursCool
//
//  Created by tourscool on 1/4/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYPayService.h"
#import "LYToursCoolConfigurationHeader.h"
#import <AlipaySDK/AlipaySDK.h>
#import <mob_sharesdk/WXApi.h>
#import <UPPaymentControl.h>

@interface LYPayService()<WXApiDelegate>

@end

@implementation LYPayService

- (BOOL)application:(UIApplication * _Nullable)application didFinishLaunchingWithOptions:(NSDictionary  * _Nullable )launchOptions
{
    //缺key
//    [WXApi registerApp:WeChatAppID universalLink:UNIVERSAL_LINK];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            LYNSLog(@"result = %@",resultDic);
            LYNSLog(@"result = %@",resultDic[@"memo"]);
            
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSDictionary * dic = nil;
            if (resultStatus.integerValue == 9000) {
                dic = @{@"type":@"1",@"name":@"支付宝支付",@"payType":@"1"};
            }else{
                dic = @{@"type":@"2",@"name":@"支付宝支付",@"payType":@"1"};
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kPayNotificationIdentifier object:nil userInfo:dic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            LYNSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            LYNSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    [WXApi handleOpenURL:url delegate:self];
    //todo + (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity delegate:(nullable id<WXApiDelegate>)delegate;
    
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        if(code && code.length > 0){
            NSDictionary * dic = nil;
            if ([code isEqualToString:@"success"]) {
                dic = @{@"type":@"1",@"name":@"云闪付",@"payType":@"3"};
            }else{
                dic = @{@"type":@"2",@"name":@"云闪付",@"payType":@"3"};
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kPayNotificationIdentifier object:nil userInfo:dic];
        }
    }];

    return YES;
}

- (void)onResp:(BaseResp *)resp
{
    LYNSLog(@"onResp%@", resp);
    if([resp isKindOfClass:[PayResp class]]){
        //支付回调
        if (resp.errCode == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kPayNotificationIdentifier object:nil userInfo:@{@"type":@"1",@"name":@"微信支付",@"payType":@"2"}];
            });
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kPayNotificationIdentifier object:nil userInfo:@{@"type":@"2",@"name":@"微信支付",@"payType":@"2"}];
            });
        }
    }
}

@end
