//
//  LYAPPRemoteRouter.m
//  ToursCool
//
//  Created by tourscool on 5/31/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYAPPRemoteRouter.h"
//#import "LYLineDetailsViewController.h"
//#import "LYProductListViewController.h"
//#import "LYWebViewController.h"
#import "LYToursCoolAPPManager.h"
#import "MGJRouter.h"
#import "UIViewController+LYNib.h"

@implementation LYAPPRemoteRouter

+ (void)openVCWithURL:(NSURL *)url windowRootVC:(UIViewController *)windowRootVC
{
    [LYAPPRemoteRouter openVCForServerWithUrlString:url.absoluteString];
}

// 列表 详情 web
+ (void)openVCWithRemoteUserInfo:(NSDictionary *)userInfo
{
    [LYAPPRemoteRouter openVCForServerWithUrlString:userInfo[@"urlPath"]];
}

+ (void)openVCForServerWithUrlString:(NSString *)urlString
{
    if (!urlString.length) {
        return;
    }
    if ([LYToursCoolAPPManager obtainCurrentNavigationController]) {
//        if ([urlString containsString:LineDetailsViewControllerKey] && [[UIViewController findCurrentShowingViewController] isKindOfClass:[LYLineDetailsViewController class]]) {
//            [[LYToursCoolAPPManager obtainCurrentNavigationController] popViewControllerAnimated:NO];
//        }
//        if ([urlString containsString:ProductListViewControllerKey] && [[UIViewController findCurrentShowingViewController] isKindOfClass:[LYProductListViewController class]]) {
//            [[LYToursCoolAPPManager obtainCurrentNavigationController] popViewControllerAnimated:NO];
//        }
//        if ([urlString containsString:WebViewControllerKey] && [[UIViewController findCurrentShowingViewController] isKindOfClass:[LYWebViewController class]]) {
//            LYWebViewController * webViewController = (LYWebViewController *)[UIViewController findCurrentShowingViewController];
//            NSString * URL = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            NSDictionary * dic = [[MGJRouter sharedInstance] extractParametersFromURL:URL matchExactly:NO];
//            if (dic) {
//                [webViewController jumpWebHTML:dic];
//            }
//            return;
//        }
        [LYRouterManager allPowerfulOpenVCForServerWithUrlString:urlString userInfo:@{kCurrentNavigationVCKey:[LYToursCoolAPPManager obtainCurrentNavigationController]}];
    }else{
        [[[UIApplication sharedApplication] delegate]window ].rootViewController = [[LYToursCoolAPPManager sharedInstance] rootViewController];
        [LYRouterManager allPowerfulOpenVCForServerWithUrlString:urlString userInfo:@{kCurrentNavigationVCKey:[LYToursCoolAPPManager obtainCurrentNavigationController]}];
    }
}

@end
