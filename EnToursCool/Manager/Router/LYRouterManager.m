//
//  LYRouterManager.m
//  ToursCool
//
//  Created by tourscool on 10/25/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYRouterManager.h"
#import "LYTourscoolBasicsNavigationViewController.h"
#import "LYLoginViewController.h"
#import "LYOnlyShowWebViewController.h"
#import "LYWebViewController.h"
//#import "LYPopoverViewController.h"
//
//#import "LYReconstructionLoginViewController.h"
//
//#import "LYLineDetailsViewController.h"
//#import "LYSelectDateViewController.h"
//#import "LYProductListViewController.h"
//#import "LYSearchViewController.h"
//
//#import "LYOrderVTMagicViewController.h"
//#import "LYGeneralInformationViewController.h"
//#import "LYMineCollectAllTypeViewController.h"
//#import "LYStrategyDetailsViewController.h"
//#import "LYStrategyListViewController.h"
//#import "LYScenicAreaDetailsViewController.h"
//
//#import "LYCurrencySwitchesViewController.h"
//#import "LYFeedbackViewController.h"
//#import "LYOrderDetailViewController.h"
//

//#import "LYPayTypeViewController.h"
//#import "LYCouponProductListViewController.h"

//#import "LYMineCouponsVTMagicController.h"
//#import "LYProductCommentListViewController.h"
//#import "LYProductPublishCommentViewController.h"
//#import "LYAllScenicAreaListViewController.h"
//#import "LYGuideTourMapViewController.h"
//#import "LYGuideTourRegionListViewController.h"
//#import "LYGuideTourScenicAreaListViewController.h"
//#import "LYDestinationHomeViewController.h"

#import <SafariServices/SafariServices.h>

//#import "LYLoginModulesTools.h"
#import "UIView+LYUtil.h"
#import "NSArray+LYUtil.h"
#import "MGJRouter.h"

NSString *const LineDetailsViewControllerKey = @"product/detail";
NSString *const ProductListViewControllerKey = @"product/list";

//NSString *const ScenicAreaDetailsViewControllerKey = @"scenic/details";
//NSString *const AllScenicAreaListViewControllerKey = @"scenic/list";

//NSString *const GuideTourRegionListViewControllerKey = @"guidetour/regionlist";
//NSString *const GuideTourScenicAreaListViewControllerKey = @"guidetour/scenicarealist";
//NSString *const GuideTourMapViewControllerKey = @"guidetour/map";

//NSString *const StrategyDetailsViewControllerKey = @"strategy/detail";
//NSString *const StrategyListViewControllerKey = @"strategy/list";
//NSString *const DestinationHomeViewControllerKey = @"destination/home";

NSString *const SearchViewControllerKey = @"SearchVC";
//NSString *const SelectDateViewControllerKey = @"SelectDateVC";

//NSString *const MinshukuMainViewControllerKey = @"MinshukuMainVC";

//NSString *const OrderVTMagicViewControllerKey = @"OrderVTMagicVC";
//NSString *const GeneralInformationViewControllerKey = @"GeneralInformationVC";
//NSString *const MineCollectViewControllerKey = @"MineCollectVC";
//NSString *const CurrencySwitchesViewControllerKey = @"CurrencySwitchesVC";

//NSString *const FeedbackViewControllerKey = @"FeedbackVC";
NSString *const SafariViewControllerKey = @"SafariVC";
//NSString *const OrderDetailViewControllerKey = @"OrderDetailVC";

//NSString *const PayTypeViewControllerKey = @"PayTypeVC";
NSString *const WebViewControllerKey = @"product/web";

//NSString *const MineCouponsVTMagicControllerKey = @"mine/coupons";

//NSString *const ProductCommentListViewControllerKey = @"product/comment/list";
//NSString *const ProductPublishCommentViewControllerKey = @"product/comment/publish";

//NSString *const CouponProductListViewControllerKey = @"coupon/product/list";

NSString *const kCurrentNavigationVCKey = @"kCurrentNavigationVCKey";

static NSString *const LYParameterUserInfoKey = @"LYParameterUserInfoKey";
@implementation LYRouterManager

+ (void)load{
    [self registerOnlyShowWebViewController];
    [self registerWebViewController];
}


#pragma mark - register


//+ (void)registerDestinationHomeViewController
//{
//    [MGJRouter registerURLPattern:[LYRouterManager jointURLPattern:DestinationHomeViewControllerKey] toHandler:^(NSDictionary *routerParameters) {
////        UINavigationController *navigationController = routerParameters[MGJRouterParameterUserInfo][@"kCurrentNavigationVCKey"];
////        LYDestinationHomeViewController * destinationHomeViewController = [[LYDestinationHomeViewController alloc] init];
////        destinationHomeViewController.hidesBottomBarWhenPushed = YES;
////        [LYRouterManager addParameter:destinationHomeViewController userInfo:routerParameters];
////        [navigationController pushViewController:destinationHomeViewController animated:YES];
//    }];
//}

+ (void)registerWebViewController{
    [MGJRouter registerURLPattern:[LYRouterManager jointURLPattern:WebViewControllerKey] toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationController = routerParameters[MGJRouterParameterUserInfo][kCurrentNavigationVCKey];
        LYWebViewController * webViewController = [[LYWebViewController alloc] init];
        webViewController.hidesBottomBarWhenPushed = YES;
        [LYRouterManager addParameter:webViewController userInfo:routerParameters];
        [navigationController pushViewController:webViewController animated:YES];
    }];
}

+ (void)registerOnlyShowWebViewController{
    [MGJRouter registerURLPattern:[LYRouterManager jointURLPattern:SafariViewControllerKey] toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationController = routerParameters[MGJRouterParameterUserInfo][kCurrentNavigationVCKey];
        LYOnlyShowWebViewController *onlyShowWebViewController = [[LYOnlyShowWebViewController alloc] init];
        onlyShowWebViewController.hidesBottomBarWhenPushed = YES;
        [LYRouterManager addParameter:onlyShowWebViewController userInfo:routerParameters];
        [navigationController pushViewController:onlyShowWebViewController animated:YES];
    }];
}

#pragma mark - openOtherVC

+ (void)openPopoverViewControllerWithVC:(UIViewController * _Nullable)vc type:(NSInteger)type dataArray:(NSArray * _Nullable)dataArray title:(NSString * _Nullable)title
{
//    [LYPopoverViewController openPopoverViewControllerWithVC:vc type:type dataArray:dataArray title:title];
}

+ (void)openReconstructionLoginTypeViewControllerWithCurrentVC:(UIViewController *)currentVC parameter:(NSDictionary *)parameter
{
//    LYLoginViewController
    
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYLoginViewControllerStoryboard" bundle:nil];
        UIViewController * reconstructionLoginViewController = [sb instantiateInitialViewController];
//        reconstructionLoginViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//        [currentVC presentViewController:reconstructionLoginViewController animated:YES completion:nil];
    [currentVC.navigationController pushViewController:reconstructionLoginViewController animated:YES];
    
//    if ([LYLoginModulesTools userLoginThirdPartyType]) {
//        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAgainLoginModulesStoryboard" bundle:nil];
//        UIViewController * againLoginModulesStoryboard = [sb instantiateInitialViewController];
//        againLoginModulesStoryboard.modalPresentationStyle = UIModalPresentationFullScreen;
//        [currentVC presentViewController:againLoginModulesStoryboard animated:YES completion:nil];
//    }else{
//        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYLoginModulesStoryboard" bundle:nil];
//        UIViewController * reconstructionLoginViewController = [sb instantiateInitialViewController];
//        reconstructionLoginViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//        [currentVC presentViewController:reconstructionLoginViewController animated:YES completion:nil];
//    }
}



+ (void)goToGeneralInformationViewControllerWith:(id)vc userInfo:(NSDictionary *)userInfo complete:(nullable void (^)(NSArray *selectPeople))completeBlock
{
//    UINavigationController *navigationController = nil;
//    if ([vc isKindOfClass:[UIView class]]) {
//        navigationController = ((UIView *)vc).viewController.navigationController;
//    }else{
//        navigationController = ((UIViewController *)vc).navigationController;
//    }
//    
//    LYGeneralInformationViewController *generalInformationViewController = [[LYGeneralInformationViewController alloc] init];
//    generalInformationViewController.hidesBottomBarWhenPushed = YES;
//    generalInformationViewController.data = userInfo;
//    [generalInformationViewController setUserDownSelectPeopleBlock:^(NSArray *selectPeople) {
//        if (completeBlock) {
//            completeBlock(selectPeople);
//        }
//    }];
//    [navigationController pushViewController:generalInformationViewController animated:YES];
    
}

#pragma mark - 添加参数

+ (void)addParameter:(UIViewController *)vc userInfo:(NSDictionary *)userInfo
{
    NSDictionary * parameterUserInfo = userInfo[MGJRouterParameterUserInfo][LYParameterUserInfoKey];
    if (parameterUserInfo) {
        vc.data = parameterUserInfo;
    }else{
        NSMutableDictionary * para = [NSMutableDictionary dictionaryWithDictionary:userInfo];
        [para removeObjectForKey:@"MGJRouterParameterURL"];
        [para removeObjectForKey:@"MGJRouterParameterUserInfo"];
        vc.data = para;
    }
}

#pragma mark - key拼接

+ (NSString *)jointURLPattern:(NSString *)key
{
    return [NSString stringWithFormat:@"tourscool://xf.qa.tourscool.net/%@", key];
}

#pragma mark - openVC

+ (void)openSomeOneVCWithParameters:(NSArray *)parameters urlKey:(NSString *)urlKey
{
    if (!parameters.count) {
        return;
    }
    id naiVCParameters = [parameters objectAt:0];
    id userInfoParameters = [parameters objectAt:1];
    NSDictionary * userInfo = nil;
    if (naiVCParameters && userInfoParameters) {
        userInfo = @{kCurrentNavigationVCKey:naiVCParameters,LYParameterUserInfoKey:userInfoParameters};
    } else {
        userInfo = @{kCurrentNavigationVCKey:naiVCParameters};
    }
    [MGJRouter openURL:[LYRouterManager jointURLPattern:urlKey] withUserInfo:userInfo completion:nil];
}

+ (void)allPowerfulOpenVCForServerWithUrlString:(NSString *)urlString userInfo:(NSDictionary *)userInfo
{
    [MGJRouter openURL:urlString withUserInfo:userInfo completion:nil];
}

@end
