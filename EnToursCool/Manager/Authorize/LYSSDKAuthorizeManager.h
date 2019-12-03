//
//  LYSSDKAuthorizeManager.h
//  ToursCool
//
//  Created by tourscool on 2/18/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/SSDKTypeDefine.h>
NS_ASSUME_NONNULL_BEGIN

@interface LYSSDKAuthorizeManager : NSObject

/**
 SSO登录

 @param platformType 平台
 @param otherSetting 其他参数
 @param userAuthorizeResult 返回结果 sdkUserID headImgURL nickName sex
 */


+ (void)authorizePlatformType:(SSDKPlatformType)platformType otherSetting:(NSDictionary * _Nullable)otherSetting userAuthorizeResult:(void (^)(id x, id userInfo))userAuthorizeResult;
+ (void)cancelAuthorizeWithThirdParty:(NSString *)thirdParty;
@end

NS_ASSUME_NONNULL_END
