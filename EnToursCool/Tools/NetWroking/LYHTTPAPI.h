//
//  LYHTTPAPI.h
//  ToursCool
//
//  Created by tourscool on 10/23/18.
//  Copyright © 2018 tourscool. All rights reserved.
//
/**
 网络请求链接管理
 */
#import <Foundation/Foundation.h>

#pragma mark  基本地址
/**
 基本URL地址
 */
#define BaseUrl [LYHTTPAPI apiBaseUrl]
/**
 民宿基本URL地址
 */
#define MinshukuBaseUrl [LYHTTPAPI minshukuBaseUrl]
/**
 web基本地址
 */
#define WebBaseUrl [LYHTTPAPI webBaseUrl]




#pragma mark - web 相关地址

/**
 米粒说明
 */
FOUNDATION_EXPORT NSString * const IntegralWebPath;
/**
 多日游
 */
FOUNDATION_EXPORT NSString * const ManyDaysTourism;
/**
 一日游
 */
FOUNDATION_EXPORT NSString * const OneDayTourism;
/**
 隐私政策
 */
FOUNDATION_EXPORT NSString * const PrivacyPolicyWebPath;
/**
 用户协议
 */
FOUNDATION_EXPORT NSString * const UserAgreementWebPath;
/**
 关于我们
 */
FOUNDATION_EXPORT NSString * const AboutWeWebPath;
/**
 上传视频协议
 */
FOUNDATION_EXPORT NSString * const UploadUserWebPath;

#pragma mark - 登录注册相关
/**
 退出登录
 */
FOUNDATION_EXPORT NSString * const LogOut;

#pragma mark - 其他接口

/**
 图片上传
 */
FOUNDATION_EXPORT NSString *const UpdateImagePath;

#pragma mark - Pay

/**
 支付
 */
FOUNDATION_EXPORT NSString *const PayBaseUrl;

@interface LYHTTPAPI : NSObject
+ (NSString *)apiBaseUrl;
+ (NSString *)minshukuBaseUrl;
+ (NSString *)webBaseUrl;
@end
