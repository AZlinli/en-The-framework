//
//  LYUserInterfaceService.m
//  ToursCool
//
//  Created by tourscool on 12/6/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYUserInterfaceService.h"
//#import "FLEXManager.h"
#import "LYDownTimeViewModel.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation LYUserInterfaceService
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupUserInterface];
    //    [[FLEXManager sharedManager] showExplorer];
    LYNSLog(@"LYUserInterfaceService Start");
    return YES;
}

- (void)setupUserInterface
{
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [UITabBar appearance].tintColor = [LYTourscoolAPPStyleManager ly_393939Color];
    [UITabBar appearance].unselectedItemTintColor = [LYTourscoolAPPStyleManager ly_969696Color];
    
    if (@available(iOS 11.0, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0)
                                                             forBarMetrics:UIBarMetricsDefault];
    }else{
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    }
}

@end
