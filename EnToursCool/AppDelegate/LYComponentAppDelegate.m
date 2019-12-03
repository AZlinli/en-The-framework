//
//  LYComponentAppDelegate.m
//  ToursCool
//
//  Created by tourscool on 12/6/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYComponentAppDelegate.h"
#import "LYUserInterfaceService.h"
#import "LYNetWorkingService.h"
#import "LYUMAnalyticsService.h"
#import "LYLocationService.h"
#import "LYSharedService.h"
#import "LYPayService.h"
#import "LYGTPushService.h"

static LYComponentAppDelegate * componentAppDelegate = nil;
@interface LYComponentAppDelegate ()
@property (nonatomic, strong) NSMutableArray<UIApplicationDelegate> * serviceMutableArray;
@end
@implementation LYComponentAppDelegate
+ (LYComponentAppDelegate *)sharedComponentAppDelegate
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        componentAppDelegate = [[LYComponentAppDelegate alloc] init];
    });
    return componentAppDelegate;
}

- (NSMutableArray<UIApplicationDelegate> *)serviceMutableArray
{
    if (!_serviceMutableArray) {
        _serviceMutableArray = [[NSMutableArray<UIApplicationDelegate> alloc] init];
        [self addAllService];
    }
    return _serviceMutableArray;
}

- (void)addService:(id)service
{
    if (![self.serviceMutableArray containsObject:service]) {
        [self.serviceMutableArray addObject:service];
    }
}

- (void)addAllService
{
    [self addService:[[LYUserInterfaceService alloc] init]];
    [self addService:[[LYNetWorkingService alloc] init]];
    [self addService:[[LYUMAnalyticsService alloc] init]];
    [self addService:[[LYLocationService alloc] init]];
    [self addService:[[LYSharedService alloc] init]];
    [self addService:[[LYPayService alloc] init]];
    [self addService:[[LYGTPushService alloc] init]];
}

+ (id)findDelegateServiceWithServiceName:(NSString *)serviceName
{
    __block id service = nil;
    [LYComponentAppDelegate.sharedComponentAppDelegate.serviceMutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass([obj class]) isEqualToString:serviceName]) {
            service = obj;
        }
    }];
    return service;
}

+ (NSArray<UIApplicationDelegate> *)allService
{
    return [LYComponentAppDelegate.sharedComponentAppDelegate.serviceMutableArray copy];
}

@end
