//
//  LYHTTPAPI.m
//  ToursCool
//
//  Created by tourscool on 10/23/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHTTPAPI.h"

NSString * const LogOut = @"layout";

#ifdef DEBUG
NSString *const UpdateImagePath = @"http://www.htw.tourscool.net/upload.php";
#else
NSString *const UpdateImagePath = @"https://assets.tourscool.com/upload.php";
#endif

#ifdef DEBUG
NSString *const PayBaseUrl = @"http://htwapi.n.tourscool.net/";
//N 环境@"http://htwapi.n.tourscool.net/";
//QA @"http://www.htw.tourscool.net/"
//NSString *const PayBaseUrl = @"http://htwapi.tourscool.com/";
#else
NSString *const PayBaseUrl = @"http://htwapi.tourscool.com/";
#endif

NSString * const IntegralWebPath = @"integral?platform=app";
NSString * const ManyDaysTourism = @"protocol/more?platform=app";
NSString * const OneDayTourism = @"protocol/alone?platform=app";
NSString * const PrivacyPolicyWebPath = @"protocol/xifan?platform=app";
NSString * const UserAgreementWebPath = @"protocol/user?platform=app";
NSString * const AboutWeWebPath = @"protocol/about?platform=app";
NSString * const UploadUserWebPath = @"/protocol/upload_user?platform=app";


@implementation LYHTTPAPI
//http://api.n.tourscool.net
+ (NSString *)apiBaseUrl
{
#ifdef DEBUG
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"DEV"]) {
        return @"http://api.dev.tourscool.net/";
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"GrayEnvironment"]) {
        return @"http://api.tourscool.net/";
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"Release"]) {
        return @"http://api.tourscool.com/";
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"N"]) {
        return @"http://api.n.tourscool.net/";
    }
    return @"https://001enapi.tourscool.cn/";//@"http://api.qa.tourscool.net/"; // @"http://api001.dev.tourscool.net:12588/";
#else
    return @"http://api.tourscool.com/";
#endif
    
}

+ (NSString *)minshukuBaseUrl
{
#ifdef DEBUG
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"DEV"]) {
        return @"http://htwapi.dev.tourscool.net/api/v1/";
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"GrayEnvironment"]) {
        return @"http://htwapi.tourscool.net/api/v1/";
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"Release"]) {
        return @"http://htwapi.tourscool.com/api/v1/";
    }
    return @"http://htwapi.qa.tourscool.net/api/v1/";
#else
    return @"http://htwapi.tourscool.com/api/v1/";
#endif
}

+ (NSString *)webBaseUrl
{
#ifdef DEBUG
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"DEV"]) {
        return @"http://xf.dev.tourscool.net/";
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"GrayEnvironment"]) {
        return @"http://m.tourscool.net/";
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestAPIHOST"] isEqualToString:@"Release"]) {
        return @"http://m.tourscool.com/";
    }
    // http://192.168.1.188:3080/activity/new
//    return @"http://192.168.1.188:3080/";
    return @"http://xf.qa.tourscool.net/";
#else
    return @"http://m.tourscool.com/";
#endif
}


@end
