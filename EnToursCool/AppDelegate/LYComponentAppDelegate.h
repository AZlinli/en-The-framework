//
//  LYComponentAppDelegate.h
//  ToursCool
//
//  Created by tourscool on 12/6/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYComponentAppDelegate : NSObject
@property (nonatomic, readonly, strong, class) LYComponentAppDelegate * sharedComponentAppDelegate;
+ (id)findDelegateServiceWithServiceName:(NSString *)serviceName;
+ (NSArray<UIApplicationDelegate> *)allService;
@end

NS_ASSUME_NONNULL_END
