//
//  LYNetWorkingservice.h
//  ToursCool
//
//  Created by tourscool on 12/6/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYNetWorkingService : NSObject

/**
 Apple networkStatus
 AFNetworkReachabilityStatusUnknown          = -1,
 AFNetworkReachabilityStatusNotReachable     = 0,
 AFNetworkReachabilityStatusReachableViaWWAN = 1,
 AFNetworkReachabilityStatusReachableViaWiFi = 2,
 */
@property (nonatomic, assign, readonly) NSInteger  netWorkStatus;

- (BOOL)application:(UIApplication * _Nullable)application didFinishLaunchingWithOptions:(NSDictionary  * _Nullable )launchOptions;
@end

NS_ASSUME_NONNULL_END
