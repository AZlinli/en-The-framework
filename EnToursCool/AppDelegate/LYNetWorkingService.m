//
//  LYNetWorkingservice.m
//  ToursCool
//
//  Created by tourscool on 12/6/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYNetWorkingService.h"
#import "LYSearchHistoryManager.h"
#import "LYHTTPRequestManager.h"
#import "LYCountriesDBManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import <SDWebImage/SDImageCache.h>
#import <AdSupport/AdSupport.h>
@interface LYNetWorkingService()
@property (nonatomic, readwrite, assign) NSInteger  netWorkStatus;
@end
@implementation LYNetWorkingService

+ (void)load
{
    AFNetworkReachabilityManager * networkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [networkReachabilityManager startMonitoring];
}

- (BOOL)application:(UIApplication * _Nullable)application didFinishLaunchingWithOptions:(NSDictionary  * _Nullable )launchOptions
{
    [SDImageCache sharedImageCache].config.maxMemoryCount = 15;
    // SDImageCacheAvoidDecodeImage
    [SDWebImageDownloader sharedDownloader].config.downloadTimeout = 25;
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:5 * 1024 * 1024
                                                            diskCapacity:100 * 1024 * 1024
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    LYNSLog(@"LYNetWorkingservice Start");
    [LYHTTPRequestManager sharedLYHTTPRequestManager];
    [LYSearchHistoryManager createUserSearchTable];
    [LYCountriesDBManager createCountriesTable];
    NSString * userUpdateKey = [[NSUserDefaults standardUserDefaults] objectForKey:kUserUpdateIDFA];
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] && !userUpdateKey.length) {
        [RACObserve(self, netWorkStatus) subscribeNext:^(id  _Nullable x) {
            LYNSLog(@"netWorkStatus == %@", x);
            if (!([x integerValue] == 0) && !([x integerValue] == -1) && !userUpdateKey.length) {
                NSString * IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                LYNSLog(@"ASIdentifierManager ---- %@", IDFA);
                if (IDFA.length) {
                    [[LYHTTPRequestManager HTTPPostRequestWithAction:LY_HTTP_Version_1(@"oauth/idfa") parameter:@{@"idfa":IDFA} cacheType:NO] subscribeNext:^(id  _Nullable x) {
                        if ([x[@"code"] integerValue] == 0) {
                            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:kUserUpdateIDFA];
                        }else if ([x[@"msg"] isEqualToString:@"IDFA 已经添加过"]){
                            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:kUserUpdateIDFA];
                        }
                        LYNSLog(@"ASIdentifierManager ---- %@", x);
                    }];
                }
            }
        }];
    }
    [self configurationNetWorkStatus];
    return YES;
}

- (void)configurationNetWorkStatus
{
    AFNetworkReachabilityManager * networkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [networkReachabilityManager startMonitoring];
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:AFNetworkingReachabilityDidChangeNotification object:nil] distinctUntilChanged] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.netWorkStatus = [x.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:LYNetworkingReachabilityDidChangeNotificationName object:nil userInfo:@{@"Reachability":x.userInfo[AFNetworkingReachabilityNotificationStatusItem]}];
    }];
}

@end
