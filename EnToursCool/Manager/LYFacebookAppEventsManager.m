//
//  LYFacebookAppEventsManager.m
//  ToursCool
//
//  Created by tourscool on 6/5/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYFacebookAppEventsManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@implementation LYFacebookAppEventsManager

+ (void)logPayMentSucceedEvent
{
    [FBSDKAppEvents logEvent:@"ToursCool_PayMent_Succeed_Event"];
}

+ (void)logRegisterSucceedEvent:(NSString *)registerAccount
{
    if (!registerAccount.length) {
        return;
    }
    NSDictionary *params =
    @{@"register_account" : registerAccount};
    [FBSDKAppEvents
     logEvent:@"ToursCool_Register_Succeed_Event"
     parameters:params];
}

@end
