//
//  LYFacebookAppEventsManager.h
//  ToursCool
//
//  Created by tourscool on 6/5/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYFacebookAppEventsManager : NSObject
/**
 统计支付订单成功
 */
+ (void)logPayMentSucceedEvent;
/**
 统计注册成功

 @param registerAccount 账号
 */
+ (void)logRegisterSucceedEvent:(NSString *)registerAccount;
@end

NS_ASSUME_NONNULL_END
