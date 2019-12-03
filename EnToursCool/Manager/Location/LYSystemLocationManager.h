//
//  LYSystemLocationManager.h
//  ToursCool
//
//  Created by tourscool on 12/4/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYSystemLocationManager : NSObject
@property (nonatomic, strong, readonly, class) LYSystemLocationManager *sharedSystemLocationManager;
/**
 定位

 @return RACSignal
 */
+ (RACSignal *)startSystemLoaction;
/**
 根据定位逆地理编码

 @return RACSignal
 */
+ (RACSignal *)startUserLocation;

/// 获取定位权限 YES 可以定位 NO 不能定位
+ (BOOL)obtainLocationAuthorizationStatus;

@end

NS_ASSUME_NONNULL_END
