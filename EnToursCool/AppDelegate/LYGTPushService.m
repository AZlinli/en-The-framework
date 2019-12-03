//
//  LYGTPushService.m
//  ToursCool
//
//  Created by tourscool on 5/31/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYGTPushService.h"
#import "LYToursCoolConfigurationHeader.h"
#import "LYAPPRemoteRouter.h"
#import "LYDateTools.h"
#import <GTSDK/GeTuiSdk.h>
#import <UserNotifications/UserNotifications.h>

@interface LYGTPushService()<GeTuiSdkDelegate, UNUserNotificationCenterDelegate>

@end

@implementation LYGTPushService

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication * _Nullable)application didFinishLaunchingWithOptions:(NSDictionary  * _Nullable )launchOptions
{
    //缺key
    
    [GeTuiSdk startSdkWithAppId:GTAppID appKey:GTAppKey appSecret:GTAppSecret delegate:self];
    [self registerRemoteNotification];
    LYNSLog(@"LYGTPushService Start");
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    LYNSLog(@"deviceToken -%@", deviceToken);
    [GeTuiSdk registerDeviceTokenData:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    LYNSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

#pragma mark - UNUserNotificationCenterDelegate

// app前台提收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

// 用户点击通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    LYNSLog(@"%@", response.notification.request.content.userInfo);
    [LYAPPRemoteRouter openVCWithRemoteUserInfo:response.notification.request.content.userInfo];
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    completionHandler();
}

#pragma mark - 静默推送 content-available:1

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    LYNSLog(@"didReceiveRemoteNotification静默推送");
    [GeTuiSdk handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - GeTuiSdkDelegate 透传消息

- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId
{
    if (offLine) {
        LYNSLog(@"offLine");
        NSError * error = nil;
        NSDictionary * userInfo = [NSJSONSerialization JSONObjectWithData:payloadData options:NSJSONReadingAllowFragments error:&error];
        if (!error && userInfo) {
            LYNSLog(@"GeTuiSdkDidReceivePayloadData -- offLine%@", userInfo);
        }
    }else{
        NSError * error = nil;
        NSDictionary * userInfo = [NSJSONSerialization JSONObjectWithData:payloadData options:NSJSONReadingAllowFragments error:&error];
        if (!error && userInfo) {
            LYNSLog(@"GeTuiSdkDidReceivePayloadData%@", userInfo);
            [LYGTPushService addLocalNotificationWithUserInfo:userInfo];
        }
        LYNSLog(@"Line");
    }
}

#pragma mark - private

/**
 注册通知
 */
- (void)registerRemoteNotification
{
    // TODO fix apple bug
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
        
    }];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}


/**
 添加本地通知

 @param userInfo 通知信息
 */
+ (void)addLocalNotificationWithUserInfo:(NSDictionary *)userInfo
{
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    NSString * title = userInfo[@"aps"][@"alert"][@"title"];
    if (!title) {
        title = @"稀饭旅行";
    }
    
    NSString * subtitle = userInfo[@"aps"][@"alert"][@"subtitle"];
    if (subtitle.length) {
        notificationContent.subtitle = subtitle;
    }
    
    NSString * content = userInfo[@"aps"][@"alert"][@"body"];
    if (!content) {
        content = @"稀饭旅行";
    }
    
    notificationContent.title = title;
    notificationContent.body = content;
    
    notificationContent.userInfo = userInfo;
    notificationContent.badge = @(0);
    UNTimeIntervalNotificationTrigger *notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
    NSString *requertIdentifier = [NSString stringWithFormat:@"%@", userInfo[@"msgId"]];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:notificationContent trigger:notificationTrigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        LYNSLog(@"Error:%@",error);
    }];
}

//+ (void)getUserNotifications
//{
//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [center removeAllDeliveredNotifications];
//            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//        });
//    }];
//}

@end
