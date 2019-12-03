//
//  LYPayService.h
//  ToursCool
//
//  Created by tourscool on 1/4/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYPayService : NSObject<UIApplicationDelegate>

- (BOOL)application:(UIApplication * _Nullable)application didFinishLaunchingWithOptions:(NSDictionary  * _Nullable )launchOptions;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;
@end

NS_ASSUME_NONNULL_END
