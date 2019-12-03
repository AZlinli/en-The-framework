//
//  AppDelegate.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/6.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "AppDelegate.h"
#import "NSString+LYTool.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LYFullPageAdvertisementManager.h"
#import "LYTourscoolCache.h"
#import "LYToursCoolAPPManager.h"
#import "LYComponentAppDelegate.h"
#import "UIViewController+LYNib.h"

#ifdef DEBUG
    #import "YYFPSLabel.h"
#endif


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [LYLanguageManager systemUserLanguage];
    [NSString folderPathInCache:@"NotificationServicePath"];
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [[NSUserDefaults standardUserDefaults] setObject:kAppVersion forKey:kSplashVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [LYFullPageAdvertisementManager sharedFullPageAdvertisementManager];
    [LYTourscoolCache setUpCacheWithName:LYNetworkingResponseCache];
    self.window.rootViewController = [[LYToursCoolAPPManager sharedInstance] rootViewController];
    for (id service in [LYComponentAppDelegate allService]) {
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kUserLoginLoseEfficacydentifier object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            if (![UIViewController findViewControllerWithVCName:@"LYReconstructionLoginSMSViewController"] || [UIViewController findViewControllerWithVCName:@"LYAgainLoginTypeViewController"]) {
                [LYRouterManager openReconstructionLoginTypeViewControllerWithCurrentVC:[LYToursCoolAPPManager obtainCurrentNavigationController] parameter:nil];
            }
        }];
        [self.window makeKeyAndVisible];
        
#ifdef DEBUG
    YYFPSLabel * fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80.f, 10.f, 50.f, 30.f)];
    [fpsLabel sizeToFit];
    [self.window.rootViewController.view addSubview:fpsLabel];
#endif
    
    
    return YES;
}

+ (BOOL)needSplash
{
    NSString *version = kAppVersion;
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kSplashVersion] ?: @"0";
    
    if ([version compare:oldVersion options:NSNumericSearch] == NSOrderedDescending){
        return YES;
    }
    return NO;
}

#pragma mark - 生命周期
- (void)applicationWillEnterForeground:(UIApplication *)application{
    NSLog(@"状态** 将要进入前台");
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"状态** 已经活跃");
}
- (void)applicationWillResignActive:(UIApplication *)application{
    NSLog(@"状态** 将要进入后台");
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"状态** 已经进入后台");
}
- (void)applicationWillTerminate:(UIApplication *)application{
    NSLog(@"状态** 将要退出程序");
}


@end
