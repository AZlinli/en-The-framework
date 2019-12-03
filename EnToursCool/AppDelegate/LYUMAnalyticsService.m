//
//  LYUMAnalyticsService.m
//  ToursCool
//
//  Created by tourscool on 12/6/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYUMAnalyticsService.h"
#import "LYToursCoolConfigurationHeader.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
@implementation LYUMAnalyticsService

- (BOOL)application:(UIApplication * _Nullable)application didFinishLaunchingWithOptions:(NSDictionary  * _Nullable )launchOptions
{
    
    // 缺少umeng key 
#ifdef DEBUG
    
#else
    [UMConfigure setLogEnabled:NO];
    [MobClick setScenarioType:E_UM_NORMAL];
    [MobClick setCrashReportEnabled:YES];
    [UMConfigure initWithAppkey:UMAppkey channel:UMAppChannel];
#endif
    LYNSLog(@"UMConfigure - %@", UMAppChannel);
    return YES;
}

@end
