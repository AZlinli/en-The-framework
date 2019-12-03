//
//  LYToursCoolAPPManager.m
//  ToursCool
//
//  Created by tourscool on 10/23/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYToursCoolAPPManager.h"
#import "LYTourscoolBasicsTabBarController.h"
#import "LYTourscoolBasicsNavigationViewController.h"
//#import "LYCustomerServiceViewController.h"
#import "LYUserInfoManager.h"
#import "LYImageShow.h"
//#import "LYDownTimeViewModel.h"
//#import "UITabbar+LYRedDot.h"

//#ifdef DEBUG
//static NSInteger ShowRedDotTime = 10;
//#else
//static NSInteger ShowRedDotTime = 1200;
//#endif

static NSString * storyBoardNames = @"LYHomeStoryboard|LYAudioGuideStoryboard|LYCartStoryboard|LYAccountStoryboard";
static id instance = nil;
static dispatch_once_t onceToken;

@interface LYToursCoolAPPManager()<UITabBarControllerDelegate>
/**
 字段存储Controller
 */
@property (nonatomic, strong) NSMutableDictionary * viewControllersMutableDic;
@property (nonatomic, strong) LYTourscoolBasicsTabBarController * tourscoolBasicsTabBarController;
@property (nonatomic, assign) BOOL isShowSwtichNewDestinationHomeTips;
@end

@implementation LYToursCoolAPPManager

+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

- (void)reloadRootViewController
{
    // 把控制器放入标签栏控制器
    NSMutableArray * controllers = [NSMutableArray array];
    NSArray * storyboards = [storyBoardNames componentsSeparatedByString:@"|"];
    NSDictionary * tempViewControllers = [self viewControllersMutableDic];
    [storyboards enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [controllers addObject:tempViewControllers[obj]];
    }];
    [self.tourscoolBasicsTabBarController setViewControllers:controllers];
    [self configTabbarStyle];
    
}

- (void)configTabbarStyle
{
    
    UITabBarController * tabController = self.tourscoolBasicsTabBarController;
    
    NSArray * tabbarItemImagesArr = @[@"tabbar_home_normal",
                            @"tabbar_audio_guide_normal",
                            @"tabbar_cart_normal",
                            @"tabbar_account_normal"];
    NSArray *tabbarItemSelectedImagesArr = @[@"tabbar_home_selected",
                                    @"tabbar_audio_guide_selected",
                                    @"tabbar_cart_selected",
                                    @"tabbar_account_selected"];
    
    [tabbarItemImagesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITabBarItem *tabbarItem = tabController.tabBar.items[idx];
        tabbarItem.image = [[UIImage imageNamed:tabbarItemImagesArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabbarItem.selectedImage = [[UIImage imageNamed:tabbarItemSelectedImagesArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[LYTourscoolAPPStyleManager ly_AEAEAEColor]} forState:UIControlStateNormal];
        [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"19A8C7"]} forState:UIControlStateSelected];
        
        if (idx == 0) {
            [tabbarItem setTitle:[LYLanguageManager ly_localizedStringForKey:@"Home_Tab_Bar_Title"]];
        }else if (idx == 1) {
            [tabbarItem setTitle:[LYLanguageManager ly_localizedStringForKey:@"Audio_Guide_Tab_Bar_Title"]];
        }else if (idx == 2) {
            [tabbarItem setTitle:[LYLanguageManager ly_localizedStringForKey:@"Cart_Tab_Bar_Title"]];
        }else if (idx == 3) {
            [tabbarItem setTitle:[LYLanguageManager ly_localizedStringForKey:@"Account_Tab_Bar_Title"]];
        }
    }];
}

- (BOOL)isShowSwtichNewDestinationHome{
    return self.isShowSwtichNewDestinationHomeTips;
}

- (void)setSwtichNewDestinationHome{
    self.isShowSwtichNewDestinationHomeTips = YES;
}

+ (void)switchDestination
{
    if (((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController).selectedIndex != 1) {
        [((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController ) setSelectedIndex:1];
    }
}

+ (void)switchHome
{
    if (((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController).selectedIndex != 0) {
        [((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController ) setSelectedIndex:0];
    }
}

+ (UINavigationController *)obtainMineNavigationController
{
    return ((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController).viewControllers[3];
}

+ (UINavigationController *)obtainCurrentNavigationController
{
    LYNSLog(@"%@", [UIApplication sharedApplication].delegate.window.rootViewController);
    LYNSLog(@"%@", ((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController).selectedViewController);
    return ((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController).selectedViewController;
}

+ (UINavigationController *)obtainHomeNavigationController
{
    return ((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController).viewControllers[0];
}


+ (void)switchMine
{
    if (((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController).selectedIndex != 3) {
        [((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController ) setSelectedIndex:3];
    }
}

+ (void)switchCustomerService
{
    if (((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController).selectedIndex != 2) {
        [((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController ) setSelectedIndex:2];
    }
}

+ (void)resetToursCoolAPPManager
{
    instance = nil;
    onceToken = 0l;
}

+ (void)modifyDestiationTabName:(NSString*)tabName
{
    if (tabName.length > 0) {
        UITabBarController * tabController = [LYToursCoolAPPManager sharedInstance].tourscoolBasicsTabBarController;
        UITabBarItem *tabbarItem = tabController.tabBar.items[1];
        if (tabName.length > 10) {
            [tabbarItem setTitle:[tabName substringToIndex:10]];
        }else{
            [tabbarItem setTitle:tabName];
        }
        
    }
}

#pragma mark - Get/Set

- (NSMutableDictionary *)viewControllersMutableDic
{
    if (_viewControllersMutableDic == nil) {
        _viewControllersMutableDic = [NSMutableDictionary dictionary];
        NSArray * storyboards = [storyBoardNames componentsSeparatedByString:@"|"];
        [storyboards enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:obj bundle:nil];
            UIViewController * temp = [storyboard instantiateInitialViewController];
            [self->_viewControllersMutableDic setObject:temp forKey:obj];
        }];
    }
    return _viewControllersMutableDic;
}

- (UIViewController *)rootViewController
{
    if (self.tourscoolBasicsTabBarController.viewControllers.count == 0) {
        [self reloadRootViewController];
    }
    return self.tourscoolBasicsTabBarController;
}

- (LYTourscoolBasicsTabBarController *)tourscoolBasicsTabBarController
{
    if (!_tourscoolBasicsTabBarController) {
        _tourscoolBasicsTabBarController = [[LYTourscoolBasicsTabBarController alloc] init];
        _tourscoolBasicsTabBarController.delegate = self;
    }
    return _tourscoolBasicsTabBarController;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 0) {
        [LYAnalyticsServiceManager analyticsEvent:@"BottomHome" attributes:nil label:nil];
    }else if (tabBarController.selectedIndex == 1) {
        [LYAnalyticsServiceManager analyticsEvent:@"BottomDestination" attributes:nil label:nil];
    }else if (tabBarController.selectedIndex == 2) {
        [LYAnalyticsServiceManager analyticsEvent:@"BottomOnlineConsultation" attributes:nil label:nil];
    }else if (tabBarController.selectedIndex == 3) {
        [LYAnalyticsServiceManager analyticsEvent:@"BottomPersonalCenter" attributes:nil label:nil];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    LYTourscoolBasicsNavigationViewController * tourscoolBasicsNavigationViewController = (LYTourscoolBasicsNavigationViewController *)viewController;
//    if ([tourscoolBasicsNavigationViewController.topViewController isKindOfClass:[LYCustomerServiceViewController class]]) {
//        if ([LYUserInfoManager userIsLogin]) {
//            [LYRouterManager openReconstructionLoginTypeViewControllerWithCurrentVC:tabBarController.selectedViewController parameter:nil];
//            return NO;
//        }
//    }
    return YES;
}

@end
