//
//  LYToursCoolAPPManager.h
//  ToursCool
//
//  Created by tourscool on 10/23/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYToursCoolAPPManager : NSObject
/**
 单列

 @return LYToursCoolAPPManager
 */
+ (instancetype)sharedInstance;
/**
 根控制器

 @return UIViewController -> LYTourscoolBasicsTabBarController
 */
- (UIViewController *)rootViewController;
+ (void)switchDestination;
+ (void)switchHome;
+ (void)switchCustomerService;
+ (void)switchMine;
+ (UINavigationController *)obtainMineNavigationController;
+ (UINavigationController *)obtainCurrentNavigationController;
+ (UINavigationController *)obtainHomeNavigationController;
+ (void)resetToursCoolAPPManager;
+ (void)modifyDestiationTabName:(NSString*)tabName;

/**
获取是否出现过切换新目的地主页的提示框，生命周期为APP存活期
 */
- (BOOL)isShowSwtichNewDestinationHome;
- (void)setSwtichNewDestinationHome;
@end

NS_ASSUME_NONNULL_END
