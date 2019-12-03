//
//  LYLocationService.m
//  ToursCool
//
//  Created by tourscool on 12/11/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYLocationService.h"
#import "LYSystemLocationManager.h"
#import "LYUserInfoManager.h"
#import "LYToursCoolConfigurationHeader.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation LYLocationService
- (BOOL)application:(UIApplication * _Nullable)application didFinishLaunchingWithOptions:(NSDictionary  * _Nullable )launchOptions
{
    //高德 缺key
    [AMapServices sharedServices].apiKey = GaoDeMAPAPIKey;
    [[LYSystemLocationManager startUserLocation] subscribeNext:^(id  _Nullable x) {
        if (x) {
            if (![x isKindOfClass:[NSError class]]) {
                CLPlacemark * placemark = x;
                if ([placemark.ISOcountryCode isEqualToString:@"CN"]) {
                    [LYUserInfoManager sharedUserInfoManager].inChina = YES;
                }
                [LYUserInfoManager sharedUserInfoManager].userLoctionCity = placemark.locality;
                [LYUserInfoManager sharedUserInfoManager].userLoctionProvince = placemark.administrativeArea;
            }
        }
    }];
    return YES;
}
@end
