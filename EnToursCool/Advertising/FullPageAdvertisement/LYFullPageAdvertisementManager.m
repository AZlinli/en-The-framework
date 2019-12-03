//
//  LYFullPageAdvertisementManager.m
//  LYIGListKitTest
//
//  Created by tourscool on 2/18/19.
//  Copyright © 2019 Saber. All rights reserved.
//

#import "LYFullPageAdvertisementManager.h"
#import "LYFullPageAdvertisementView.h"
#import "LYDateTools.h"
#import "LYHTTPAPI.h"
#import "LYTourscoolHTTPSessionManager.h"
#import "LYFullPageAdvertisementModel.h"
#import "LYTourscoolCache.h"
#import "LYImageShow.h"
#import "LYToursCoolAPPManager.h"
//#import "LYPopUpWindowsUpdateView.h"
#import "AppDelegate.h"
#import "UIView+LYNib.h"
#import "NSString+LYTool.h"
#import "UIViewController+LYNib.h"
#import <SDWebImage/NSData+ImageContentType.h>
#import <SDWebImage/SDImageCache.h>
#import <Masonry/Masonry.h>

NSString * const CachePathName = @"LYFullPageAdvertisementManagerCacheModelKey";

static LYFullPageAdvertisementManager * fullPageAdvertisementManager = nil;

@interface LYFullPageAdvertisementManager ()<NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession * session;
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@end

@implementation LYFullPageAdvertisementManager

+ (LYFullPageAdvertisementManager *)sharedFullPageAdvertisementManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fullPageAdvertisementManager = [[LYFullPageAdvertisementManager alloc] init];
    });
    return fullPageAdvertisementManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        @weakify(self);
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            [self downAdvertisement];
        }];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//            [LYFullPageAdvertisementManager showFullPageAdvertisementView:(UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController];
            
            [LYFullPageAdvertisementManager showView:(UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController];
            
        }];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            LYNSLog(@"UIApplicationWillEnterForegroundNotification");
            [LYFullPageAdvertisementManager createApplicationWillEnterForegroundTimeWithType:NO];
            [LYFullPageAdvertisementManager createApplicationNowWillEnterForegroundTime];
            [LYFullPageAdvertisementManager showFullPageAdvertisementView:(UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController];
        }];
    }
    return self;
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    LYNSLog(@"URLSessionDidFinishEventsForBackgroundURLSession");
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.backgroundCompletionHandler) {
        appDelegate.backgroundCompletionHandler();
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData * data = [NSData dataWithContentsOfURL:location];
    if (!data) {
        return;
    }
    if ([NSData sd_imageFormatForImageData:data] == SDImageFormatUndefined) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (dic) {
            LYNSLog(@"FULLADMSG == %@", dic);
            if ([dic[@"code"] integerValue] != 0) {
                [LYFullPageAdvertisementManager removeFullPageAdvertisementModel];
                return;
            }
            NSString * isActive = [NSString stringWithFormat:@"%@", dic[@"data"][@"is_active"]];
            if ([isActive intValue] == 0) {
                [LYFullPageAdvertisementManager removeFullPageAdvertisementModel];
                return;
            }
            NSString * imageUrl = [NSString stringWithFormat:@"%@", dic[@"data"][@"image_url"]];
            if ([imageUrl isEmpty]) {
                [LYFullPageAdvertisementManager removeFullPageAdvertisementModel];
                return;
            }
            BOOL exitImage = [LYImageShow existImageWithimagePath:imageUrl];
            if (!exitImage) {
                NSMutableURLRequest * URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[LYImageShow codeImagePath:imageUrl]]];
                NSURLSessionDownloadTask * downloadTask = [self.session downloadTaskWithRequest:URLRequest];
                [downloadTask resume];
                LYFullPageAdvertisementModel * model = [LYFullPageAdvertisementModel mj_objectWithKeyValues:dic[@"data"]];
                [LYTourscoolCache saveRequestWithPath:CachePathName parameter:@{} obejct:model];
            }else{
                LYFullPageAdvertisementModel * model = [LYFullPageAdvertisementModel mj_objectWithKeyValues:dic[@"data"]];
                model.isCache = YES;
                [LYTourscoolCache saveRequestWithPath:CachePathName parameter:@{} obejct:model];
            }
        }
    }else{
        UIImage * image = [UIImage imageWithData:data];
        if (image) {
            [LYImageShow saveImageInSDCacheimagePath:downloadTask.currentRequest.URL.absoluteString image:image];
            LYFullPageAdvertisementModel * fullPageAdvertisementModel = [LYTourscoolCache lcyGetCacheWithPath:CachePathName parameter:@{}];
            fullPageAdvertisementModel.isCache = YES;
        }
    }
}

/**
 请求广告接口
 */
- (void)downAdvertisement
{
    if (!self.session) {
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.zmcs.toursCool.ToursCool.ly"];
        sessionConfiguration.discretionary = YES;
        sessionConfiguration.sessionSendsLaunchEvents = YES;
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:[LYFullPageAdvertisementManager sharedFullPageAdvertisementManager] delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    NSMutableURLRequest * URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseUrl, LY_HTTP_Version_1(@"ad")]]];
//    NSMutableURLRequest * URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@ad", BaseUrl]]];
    
    NSDictionary * dic = [LYTourscoolHTTPSessionManager sharedLCYHTTPSessionManager].requestSerializer.HTTPRequestHeaders;
    for (NSString * key in dic) {
        [URLRequest setValue:dic[key] forHTTPHeaderField:key];
    }
    NSURLSessionDownloadTask * downloadTask = [self.session downloadTaskWithRequest:URLRequest];
    [downloadTask resume];
}

+ (void)createApplicationWillEnterForegroundTime
{
    [LYFullPageAdvertisementManager createApplicationWillEnterForegroundTimeWithType:NO];
}

/**
 保存应用进入前台时间

 @param type YES 更新时间 NO
 */
+ (void)createApplicationWillEnterForegroundTimeWithType:(BOOL)type
{
    if (type) {
        [LYFullPageAdvertisementManager saveApplicationWillEnterForegroundTime];
    }else{
        NSDate * willEnterForegroundTime = [[NSUserDefaults standardUserDefaults] objectForKey:LYApplicationWillEnterForegroundTime];
        if (!willEnterForegroundTime) {
            [LYFullPageAdvertisementManager saveApplicationWillEnterForegroundTime];
        }
    }
}

+ (void)saveApplicationWillEnterForegroundTime
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate new] forKey:LYApplicationWillEnterForegroundTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 应用进入前台时间
 */
+ (void)createApplicationNowWillEnterForegroundTime
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:LYNowApplicationWillEnterForegroundTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)showFullPageAdvertisementView:(UITabBarController *)tabBarController
{
    NSDate * willEnterForegroundTime = [[NSUserDefaults standardUserDefaults] objectForKey:LYApplicationWillEnterForegroundTime];
    NSDate * didEnterBackgroundTime = [[NSUserDefaults standardUserDefaults] objectForKey:LYNowApplicationWillEnterForegroundTime];
    if ([[LYDateTools beApartSecondOne:willEnterForegroundTime dateTwo:didEnterBackgroundTime] integerValue] >= 10) {
        if ([UIViewController findViewControllerWithVCName:@"LYReconstructionLoginSMSViewController"]) {
            return;
        }
        if ([UIViewController findViewControllerWithVCName:@"LYPopUpLoginViewController"]) {
            return;
        }
        if ([UIViewController findViewControllerWithVCName:@"LYAgainLoginTypeViewController"]) {
            return;
        }
        if ([UIViewController findViewControllerWithVCName:@"LYFullPlayVideoViewController"]) {
            return;
        }
        if ([UIViewController findViewControllerWithVCName:@"LYPayTypeViewController"]) {
            return;
        }
        if ([UIViewController findViewControllerWithVCName:@"LYFillInCreditCardViewController"]) {
            return;
        }
        if ([UIViewController findViewControllerWithVCName:@"LYThirdLoginBindListViewController"]) {
            return;
        }
        [LYFullPageAdvertisementManager createApplicationWillEnterForegroundTimeWithType:YES];
        [LYFullPageAdvertisementManager showView:tabBarController];
    }
}

+ (void)showView:(UITabBarController *)tabBarController
{
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kSplashVersion] ?: @"0";
    if (!oldVersion.integerValue) {
        return;
    }
    if (![tabBarController isKindOfClass:[UITabBarController class]]) {
        return;
    }
    LYFullPageAdvertisementView * currentFullPageAdvertisementView = [LYFullPageAdvertisementView obtainFullPageAdvertisementView];
    if (currentFullPageAdvertisementView) {
        return;
    }
    LYFullPageAdvertisementModel * fullPageAdvertisementModel = [LYTourscoolCache lcyGetCacheWithPath:CachePathName parameter:@{}];
    BOOL exitImage = [LYImageShow existImageWithimagePath:fullPageAdvertisementModel.imageUrl];
    if (fullPageAdvertisementModel.isActive && exitImage) {
        LYFullPageAdvertisementView * fullPageAdvertisementView = [[LYFullPageAdvertisementView alloc] init];
        [tabBarController.view addSubview:fullPageAdvertisementView];

        @weakify(tabBarController);
        [fullPageAdvertisementView setUserTouchFullPageAdvertisementBlock:^(NSString *advertisementPath) {
            @strongify(tabBarController);
            if ([tabBarController.selectedViewController isKindOfClass:[UINavigationController class]]) {
                if ([advertisementPath containsString:@"http"]) {
                    [LYRouterManager openSomeOneVCWithParameters:@[tabBarController.selectedViewController,@{@"url_path":advertisementPath}] urlKey:WebViewControllerKey];
                }else{
                    [LYRouterManager allPowerfulOpenVCForServerWithUrlString:advertisementPath userInfo:@{kCurrentNavigationVCKey:tabBarController.selectedViewController}];
                }
            }
        }];
        [fullPageAdvertisementView setViewFullPageAdvertisementModel:fullPageAdvertisementModel];
        [fullPageAdvertisementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(tabBarController.view);
        }];
    }
}

+ (void)removeFullPageAdvertisementModel
{
    LYFullPageAdvertisementModel * fullPageAdvertisementModel = [LYTourscoolCache lcyGetCacheWithPath:CachePathName parameter:@{}];
    if (fullPageAdvertisementModel) {
        [LYImageShow removeImageWithimagePath:fullPageAdvertisementModel.imageUrl];
        [LYTourscoolCache lcyremoveObjectsWithPath:CachePathName parameter:@{}];
    }
}

@end
