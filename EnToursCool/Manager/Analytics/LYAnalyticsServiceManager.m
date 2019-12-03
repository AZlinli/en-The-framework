//
//  LYAnalyticsServiceManager.m
//  ToursCool
//
//  Created by tourscool on 1/23/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYAnalyticsServiceManager.h"

#import <UMAnalytics/MobClick.h>

@implementation LYAnalyticsServiceManager

+ (void)analyticsEvent:(NSString *)eventID attributes:(NSDictionary * _Nullable)attributes label:(NSString * _Nullable)label
{
    if (eventID.length) {
        if (attributes.count) {
            [MobClick event:eventID attributes:attributes];
        }else if (label.length){
            [MobClick event:eventID label:label];
        }else{
            [MobClick event:eventID];
        }
    }
}

+ (void)pageBeginAnalyticsWithVCName:(NSString *)vcName
{
    NSString * pageName = [LYAnalyticsServiceManager obtainPageAnalyticsEventIDWithVCName:vcName];
    if (pageName.length) {
        [MobClick beginLogPageView:pageName];
    }
}

+ (void)pageEndAnalyticsWithVCName:(NSString *)vcName
{
    NSString * pageName = [LYAnalyticsServiceManager obtainPageAnalyticsEventIDWithVCName:vcName];
    if (pageName.length) {
        [MobClick endLogPageView:pageName];
    }
}

+ (NSString *)obtainPageAnalyticsEventIDWithVCName:(NSString *)vcName
{
    NSDictionary * dic = [LYAnalyticsServiceManager dictionaryFromUserStatisticsConfigPlist];
    return dic[@"PageName"][vcName];
}

+ (NSDictionary *)dictionaryFromUserStatisticsConfigPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LYToursCoolAnalytics" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

@end
