//
//  LYAnalyticsServiceManager.h
//  ToursCool
//
//  Created by tourscool on 1/23/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAnalyticsServiceManager : NSObject
#pragma mark - 页面统计
/**
 开始统计

 @param vcName ViewControllerName
 */
+ (void)pageBeginAnalyticsWithVCName:(NSString *)vcName;
/**
 结束统计

 @param vcName ViewControllerName
 */
+ (void)pageEndAnalyticsWithVCName:(NSString *)vcName;

+ (void)analyticsEvent:(NSString *)eventID attributes:(NSDictionary * _Nullable)attributes label:(NSString * _Nullable)label;

@end

NS_ASSUME_NONNULL_END
