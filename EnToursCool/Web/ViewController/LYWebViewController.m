//
//  LYWebViewController.m
//  ToursCool
//
//  Created by tourscool on 12/11/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYWebViewController.h"
#import "LYUserInfoManager.h"
#import "LYToursCoolAPPManager.h"
//#import "LYMineCollectHTTPRequest.h"

#import "LYLocalGroupNavigationBarTitleView.h"
//#import "LYSharedUpdatedVersionViewController.h"

#import "LYHTTPRequestManager.h"
#import "LYHTTPAPI.h"
//#import "LYPopUpWindowsManager.h"
#import "LYAutoLoginViewModel.h"
//#import "LYComerQuestionnaireMainViewController.h"
#import "UIView+LYHUD.h"
#import "UIView+LYNib.h"
#import "NSString+LYTool.h"
#import "UIViewController+Cloudox.h"
#import "UIViewController+LYNib.h"
#import <Masonry/Masonry.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

static CGFloat ScrollViewHeight = 100.f;
/**
 跳转登录界面
 */
static NSString * LYJumpToLoginView = @"jumpToLoginView";
/**
 分享界面
 */
static NSString * LYJumpSharedView = @"jumpSharedView";

/**
 跳转列表界面
 */
static NSString * LYJumpProductListView = @"jumpProductListView";
/**
 详情页面
 */
static NSString * LYJumpProductDetailView = @"jumpProductDetailView";
/**
 搜索界面
 */
static NSString * LYJumpSearchView = @"jumpSearchView";
/**
 目的地界面
 */
static NSString * LYJumpDestinationView = @"jumpDestinationView";
/**
 网页地址
 */
static NSString * LYJumpWebHTML = @"jumpWebHTML";
/**
 获取货币
 */
static NSString * LYObtainUserCurrency = @"obtainUserCurrency";
/**
 历史记录
 */
static NSString * LYGetLocalStorage = @"getLocalStorage";
/**
 滚动
 */
static NSString * LYScrollViewDidScroll = @"webViewScrollViewDidScroll";
/**
 返回上一个界面
 */
static NSString * LYBackPreviousView = @"backPreviousView";

/**
 获取历史记录
 */
static NSString * LYObtainBrowsingHistory = @"obtainBrowsingHistory";

/**
 隐藏导航栏
 */
static NSString * LYHiddenNavigationBar = @"hideNavigationBar";

/**
 显示导航栏
 */
static NSString * LYShowNavigationBar = @"showNavigationBar";

/**
 收藏
 */
static NSString * LYUserCollectProduct = @"userCollectProduct";
/**
 获取用户token
 */
static NSString * LYObtainUserToken = @"obtainUserToken";
/**
 获取用户token
 */
static NSString * LYGetUserToken = @"getUserToken";
/**
 获取用户token
 */
static NSString * LYWebCallUserToken = @"webCallUserToken";
/**
 收藏回调
 */
static NSString * LYCollectProductResult = @"collectProductResult";

/**
 新人领取大礼包成功
 */
static NSString * LYUserObtainNewcomerGiftSuccessful = @"userObtainNewcomerGiftSuccessful";

/**
 跳转优惠券列表
 */
static NSString * LYJumpCouponsListView = @"jumpCouponsListView";

/**
 跳转定制优惠券
 */
static NSString * LYJumpCustomizationCouponsListView = @"jumpCustomizationCouponsListView";

@interface LYWebViewController ()<WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) WebViewJavascriptBridge * webViewJavascriptBridge;
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, strong) NSString * currentNavBarBgAlpha;
@property (nonatomic, assign) BOOL type;
@property (nonatomic, strong) NSString * currentID;
@property (nonatomic, strong) LYLocalGroupNavigationBarTitleView * localGroupNavigationBarTitleView;
@end

@implementation LYWebViewController

#pragma mark - ViewControllerLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self removeCookie];
    // 防止token -- 700错误 跳转 HTML登录界面
    [LYAutoLoginViewModel deleteUserToken];
    [self setupUserInterface];
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.type) {
        [self webViewScrollViewDidScroll:@{@"top":[NSString stringWithFormat:@"%f", [self.currentNavBarBgAlpha floatValue] * ScrollViewHeight]}];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[LYTourscoolAPPStyleManager navigationTitleFont]}];
    }
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.localGroupNavigationBarTitleView startMarquee];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"404040"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[LYTourscoolAPPStyleManager navigationTitleColor],NSFontAttributeName:[LYTourscoolAPPStyleManager navigationTitleFont]}];
    [self.localGroupNavigationBarTitleView stopMarquee];
}

#pragma mark - Autorotate

#pragma mark - Private

- (void)setupUserInterface
{
    self.type = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    WKWebViewConfiguration *webViewconfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webViewconfiguration];
    self.webView.UIDelegate = self;
    self.webViewJavascriptBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.webViewJavascriptBridge setWebViewDelegate:self];
    [self addWebViewScriptJavascriptBridgeHandler];
    [self.view addSubview:self.webView];
    
    [self updateWebViewCookie];
    if (self.webViewStyle == LYWebViewStyleBottom) {
        self.view.backgroundColor = [UIColor clearColor];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_topMargin).offset(120.f);
            make.right.bottom.left.equalTo(self.view);
        }];
    }else{
        if (self.data) {
            NSString * url = self.data[@"url_path"];
            if ([url containsString:@"local_play_zh"]) {
                [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.mas_top);
                    make.right.bottom.left.equalTo(self.view);
                }];
            }else if ([url containsString:@"local_group"]) {
                [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.mas_top);
                    make.right.bottom.left.equalTo(self.view);
                }];
            }else if ([url containsString:@"custom"]) {
                [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.mas_top);
                    make.right.bottom.left.equalTo(self.view);
                }];
            }else if ([url containsString:@"local_play_foreign"]) {
                [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.mas_top);
                    make.right.bottom.left.equalTo(self.view);
                }];
            }else{
                [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    if (@available(iOS 11.0, *)) {
                        make.top.equalTo(self.view.mas_topMargin);
                    }else{
                        make.top.equalTo(self.view.mas_top).offset(kTopHeight);
                    }
                    
                    make.right.bottom.left.equalTo(self.view);
                }];
            }
        }
    }
    
    if (self.data) {
        NSString * url = self.data[@"url_path"];
        if ([url hasPrefix:@"https://tb.53kf.com"]) {
            self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            url = [NSString stringWithFormat:@"%@",url];
        } else {
            url = [self splicingURLAddress:url];
        }
        
        @weakify(self);
        if ([url containsString:@"local_play_zh"]) {
            [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(@"tourcity/withip") parameter:@{} cacheType:NO] subscribeNext:^(id  _Nullable x) {
                self.currentID = [NSString stringWithFormat:@"%@", x[@"data"][@"city_id"]];
                if ([self.currentID integerValue] != 0) {
                    [self webViewLoadURL:[NSString stringWithFormat:@"%@",[self splicingURLAddress:[NSString stringWithFormat:@"%@local_play_foreign?touCityId=%@", WebBaseUrl,self.currentID]]]];
                }else{
                    if ([url hasPrefix:@"http"] || [url hasPrefix:@"https"]) {
                        [self webViewLoadURL:url];
                    }else{
                        [self webViewLoadURL:[NSString stringWithFormat:@"http://%@", url]];
                    }
                }
            }];
        }else if ([url hasPrefix:@"http"] || [url hasPrefix:@"https"]) {
            [self webViewLoadURL:url];
        }else{
            [self webViewLoadURL:[NSString stringWithFormat:@"http://%@", url]];
        }
        
        if ([url containsString:@"local_play_zh"]) {
            [self createTitlView];
            [self.localGroupNavigationBarTitleView setTitle:[LYLanguageManager ly_localizedStringForKey:@"LY_Local_Fun_Title"]];
            [self.localGroupNavigationBarTitleView hiddenSearchButton];
            [self.localGroupNavigationBarTitleView setUserPrecessNavigationBarTitleViewSearchButtonBlock:^{
                @strongify(self);
               [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,@{@"item_type":@"0"}] urlKey:ProductListViewControllerKey];
            }];
        }else if ([url containsString:@"local_group"]) {
            [self createTitlView];
            [self.localGroupNavigationBarTitleView setTitle:[LYLanguageManager ly_localizedStringForKey:@"LY_Local_Group_Title"]];
            [self.localGroupNavigationBarTitleView setUserPrecessNavigationBarTitleViewSearchButtonBlock:^{
                @strongify(self);
                [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,@{@"item_type":@"1"}] urlKey:SearchViewControllerKey];
            }];
        }else if ([url containsString:@"custom"]) {
            [self createTitlView];
            [self.localGroupNavigationBarTitleView setTitle:[LYLanguageManager ly_localizedStringForKey:@"LY_High_End_Custom"]];
            [self.localGroupNavigationBarTitleView hiddenSearchButton];
        }else if ([url containsString:@"local_play_foreign"]) {
            [self createTitlView];
            [self.localGroupNavigationBarTitleView setTitle:[LYLanguageManager ly_localizedStringForKey:@"LY_Local_Fun_Title"]];
            [self.localGroupNavigationBarTitleView setUserPrecessNavigationBarTitleViewSearchButtonBlock:^{
                @strongify(self);
                if ([self.currentID integerValue] != 0) {
                    [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,@{@"item_type":@"0",@"start_city":self.currentID}] urlKey:ProductListViewControllerKey];
                }else{
                    [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,@{@"item_type":@"0"}] urlKey:ProductListViewControllerKey];
                }
            }];
        }else{
            self.currentNavBarBgAlpha = @"1.0";
        }
        
        [self.localGroupNavigationBarTitleView setUserPrecessNavigationBarTitleViewBackButtonBlock:^{
            @strongify(self);
            if (![self.webView canGoBack]) {
                [self backToVC];
            }else{
                [self.webView goBack];
            }
        }];
    }
}

- (void)addWebViewScriptJavascriptBridgeHandler
{
    @weakify(self);
    [self.webViewJavascriptBridge registerHandler:LYJumpToLoginView handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        [LYRouterManager openReconstructionLoginTypeViewControllerWithCurrentVC:self parameter:nil];
    }];
    
//    [self.webViewJavascriptBridge registerHandler:LYUserObtainNewcomerGiftSuccessful handler:^(id data, WVJBResponseCallback responseCallback) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kUserObtainNewcomerGiftInviteNewPeopleSuccessful object:nil];
//        [LYPopUpWindowsManager turnDownNewcomerGift];
//        [LYAutoLoginViewModel updateUserInfo];
//    }];
    
    [self.webViewJavascriptBridge registerHandler:LYGetUserToken handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        if (![LYUserInfoManager userIsLogin]) {
            [LYRouterManager openReconstructionLoginTypeViewControllerWithCurrentVC:self parameter:nil];
        }else{
            responseCallback(LYUserInfoManager.sharedUserInfoManager.userToken);
        }
    }];
    
    [self.webViewJavascriptBridge registerHandler:LYJumpProductDetailView handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        if (data) {
            [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,data] urlKey:LineDetailsViewControllerKey];
        }
        LYNSLog(@"LYJumpProductDetailView%@", data);
    }];
    
    [self.webViewJavascriptBridge registerHandler:LYJumpWebHTML handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        if (data) {
            [self jumpWebHTML:data];
        }
        LYNSLog(@"LYJumpWebHTML%@", data);
    }];
    
    [self.webViewJavascriptBridge registerHandler:LYWebCallUserToken handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(LYUserInfoManager.sharedUserInfoManager.userToken);
        LYNSLog(@"LYWebCallUserToken%@", data);
    }];
    
    [self.webViewJavascriptBridge registerHandler:LYJumpSearchView handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController] urlKey:SearchViewControllerKey];
    }];
    
    [self.webViewJavascriptBridge registerHandler:LYJumpDestinationView handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        if (self.presentingViewController) {
            [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:NO];
        }
        [LYToursCoolAPPManager switchDestination];
    }];
    
//    [self.webViewJavascriptBridge registerHandler:LYJumpCustomizationCouponsListView handler:^(id data, WVJBResponseCallback responseCallback) {
//        @strongify(self);
//        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYComerQuestionnaire" bundle:nil];
//        LYComerQuestionnaireMainViewController * comerQuestionnaireMainViewController = [sb instantiateViewControllerWithIdentifier:@"LYComerQuestionnaireMainViewController"];
//        comerQuestionnaireMainViewController.data = @{@"type":@"1"};
//        [self.navigationController pushViewController:comerQuestionnaireMainViewController animated:YES];
//    }];
    
//    [self.webViewJavascriptBridge registerHandler:LYJumpCouponsListView handler:^(id data, WVJBResponseCallback responseCallback) {
//        @strongify(self);
//        [LYAutoLoginViewModel updateUserInfo];
//        if (self.presentingViewController) {
//            [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
//        }else{
//            [self.navigationController popViewControllerAnimated:NO];
//        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [LYToursCoolAPPManager switchMine];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if ([LYUserInfoManager userIsLogin]) {
//                    [LYRouterManager openSomeOneVCWithParameters:@[[LYToursCoolAPPManager obtainMineNavigationController]] urlKey:MineCouponsVTMagicControllerKey];
//                }
//            });
//        });
//    }];
    
    [self.webViewJavascriptBridge registerHandler:LYBackPreviousView handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        [self backToVC];
    }];
    
    [self.webViewJavascriptBridge registerHandler:LYJumpProductListView handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        if (data) {
            [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,data] urlKey:ProductListViewControllerKey];
        }
        LYNSLog(@"LYJumpProductListView%@", data);
    }];
    
//    [self.webViewJavascriptBridge registerHandler:LYJumpSharedView handler:^(id data, WVJBResponseCallback responseCallback) {
//        @strongify(self);
//        if (data) {
//            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//            [data enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
//                if ([key isEqualToString:@"url"]) {
//                    [dic setObject:[self splicingURLAddress:obj] forKey:key];
//                }else{
//                    [dic setObject:obj forKey:key];
//                }
//            }];
//            [LYSharedUpdatedVersionViewController showSharedUpdatedVersionViewControllerWithParameter:dic showVC:self.navigationController];
//        }
//    }];
    //
    [self.webViewJavascriptBridge registerHandler:LYScrollViewDidScroll handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        [self webViewScrollViewDidScroll:data];
    }];
    
    [self.webViewJavascriptBridge callHandler:LYGetLocalStorage data:[NSString arrayToSting:[LYUserInfoManager obtainBrowsingHistory]] responseCallback:^(id responseData) {
        LYNSLog(@"LYGetLocalStorage%@", responseData);
    }];
    NSString * url = self.data[@"url_path"];
    if (![url containsString:@"activity/pull_new/app"]) {
        [self.webViewJavascriptBridge callHandler:LYObtainUserToken data:LYUserInfoManager.sharedUserInfoManager.userToken responseCallback:^(id responseData) {
            LYNSLog(@"LYObtainUserToken%@", responseData);
        }];
    }
}

- (void)createTitlView
{
    self.type = NO;
    self.currentNavBarBgAlpha = @"0.0";
    self.localGroupNavigationBarTitleView = [[LYLocalGroupNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44.f)];
    self.navigationItem.titleView = self.localGroupNavigationBarTitleView;
    [self.navigationItem setHidesBackButton:YES];
}

- (void)webViewLoadURL:(NSString *)urlStr
{
    LYNSLog(@"网页地址== %@", urlStr);
    if (urlStr.length) {
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [self.webView loadRequest:request];
    }
}

- (void)bindViewModel
{
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kUserLoginSuccessfulIdentifier object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self.webView reload];
    }];

    [RACObserve(self.webView, title) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSString * titleStr = [NSString stringWithFormat:@"%@", x];
        if (![titleStr isEqualToString:@"null"] && titleStr.length) {
            if (self.localGroupNavigationBarTitleView) {
                [self.localGroupNavigationBarTitleView setTitle:titleStr];
            }else{
                [self startMarqueeWithTitle:titleStr];
            }
        }
    }];

}

- (NSString *)obtainBrowsingHistory
{
    return [NSString arrayToSting:[LYUserInfoManager obtainBrowsingHistory]];
}

- (void)backToVC
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        if (self.presentingViewController) {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)webViewScrollViewDidScroll:(NSDictionary *)para
{
    if (self.localGroupNavigationBarTitleView) {
        CGFloat top = [para[@"top"] floatValue] / ScrollViewHeight;
//        if ([para[@"top"] floatValue] >= kTopHeight) {
//            [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.view.mas_top).offset(kTopHeight);
//            }];
//        }else{
//            [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.view.mas_top);
//            }];
//        }
        
        self.currentNavBarBgAlpha = [NSString stringWithFormat:@"%f", top];
        self.navBarBgAlpha = self.currentNavBarBgAlpha;
        [self.localGroupNavigationBarTitleView scrollViewChange:top];
    }
}

- (void)setNavBarAlpha:(NSString *)url
{
    if ([url containsString:@"local_play_zh"]) {
        [self webViewScrollViewDidScroll:@{@"top":@"0"}];
        return;
    }
    if ([url containsString:@"local_group"]) {
        [self webViewScrollViewDidScroll:@{@"top":@"0"}];
        return;
    }
    if ([url containsString:@"custom"]) {
        [self webViewScrollViewDidScroll:@{@"top":@"0"}];
        return;
    }
    if ([url containsString:@"more_city"]) {
        [self webViewScrollViewDidScroll:@{@"top":[NSString stringWithFormat:@"%f", ScrollViewHeight]}];
        return;
    }
    if ([url containsString:@"local_play_foreign"]) {
        [self webViewScrollViewDidScroll:@{@"top":@"0"}];
        return;
    }
    [self webViewScrollViewDidScroll:@{@"top":[NSString stringWithFormat:@"%f", ScrollViewHeight]}];
}

- (void)jumpWebHTML:(NSDictionary *)dic
{
    if (dic) {
        NSString * path = dic[@"path"];
        if (path.length) {
            [self webViewLoadURL:[self splicingURLAddress:[NSString stringWithFormat:@"%@%@",WebBaseUrl,path]]];
        }else{
            path = dic[@"url_path"];
            [self webViewLoadURL:[self splicingURLAddress:[NSString stringWithFormat:@"http://%@",path]]];
        }
    }
}

- (void)hideNavigationBar:(BOOL)hidden
{
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
    if (hidden) {
        [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_top).offset(-kStatusBarHeight);
            make.top.equalTo(self.view.mas_top);
            make.right.bottom.left.equalTo(self.view);
        }];
    }else{
        [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_topMargin);
            make.right.bottom.left.equalTo(self.view);
        }];
    }
}

- (NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

- (void)updateWebViewCookie
{
    NSString * cookieStr = [NSString stringWithFormat:@"document.cookie = 'currency=%@';", LYUserInfoManager.sharedUserInfoManager.userCurrency];
    WKUserScript *newCookieScript = [[WKUserScript alloc] initWithSource:cookieStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [self.webView.configuration.userContentController addUserScript:newCookieScript];
}

/**
 删除Cookie
 */
- (void)removeCookie
{
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         for (WKWebsiteDataRecord *record  in records){
                             [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                       forDataRecords:@[record]
                                                                    completionHandler:^{
                                                                        LYNSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                    }];
                         }
                     }];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
    NSError *errors;
    [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    
}

#pragma mark - Public

+ (void)goPushWebVCWithVC:(UIViewController *)vc para:(NSDictionary *)para
{
    LYWebViewController * webVC = [[LYWebViewController alloc] init];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.data = para;
    [vc.navigationController pushViewController:webVC animated:YES];
}

+ (void)goTransparentWebVCWithVC:(UIViewController *)vc para:(NSDictionary *)para
{
    LYWebViewController * webVC = [[LYWebViewController alloc] init];
    webVC.webViewStyle = LYWebViewStyleBottom;
    webVC.data = para;
    [webVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    [vc presentViewController:webVC animated:NO completion:nil];
}

#pragma mark - Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self backToVC];
}

- (BOOL)navigationShouldPopOnBackButton
{
    if (![self.webView canGoBack]) {
        [self backToVC];
    }else{
        [self.webView goBack];
    }
    return NO;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSDictionary * dic = [self dictionaryWithUrlString:navigationAction.request.URL.absoluteString];
    
    if ([dic[@"touCityId"] integerValue] != 0) {
        self.currentID = [NSString stringWithFormat:@"%@", dic[@"touCityId"]];
    }
    NSURL *url = navigationAction.request.URL;
    NSString *urlString = (url) ? url.absoluteString : @"";
    LYNSLog(@"decidePolicyForNavigationAction - %@", urlString);
    
    if ([urlString containsString:@"invite_friend"] && ![urlString containsString:@"invite_friend/rule_detail"]) {
        self.navigationItem.rightBarButtonItem = nil;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (@available(iOS 11.0, *)) {
            
        }else{
            button.frame = CGRectMake(0, 0, 60, 18);
        }
        [button setTitle:[LYLanguageManager ly_localizedStringForKey:@"Invited_Activity_Rules_Title"] forState:UIControlStateNormal];
        button.titleLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_13];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        @weakify(self);
        button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,@{@"url_path":[NSString stringWithFormat:@"%@/invite_friend/rule_detail", WebBaseUrl]}] urlKey:WebViewControllerKey];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }else if ([urlString containsString:@"activity/pull_new"]) {
        self.navigationItem.rightBarButtonItem = nil;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (@available(iOS 11.0, *)) {
            
        }else{
            button.frame = CGRectMake(0, 0, 26, 26);
        }
        [button setImage:[UIImage imageNamed:@"pull_activity_share_btn_normal"] forState:UIControlStateNormal];
        UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        @weakify(self);
        button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
//                NSMutableDictionary * sharedDic = [NSMutableDictionary dictionary];
//                [sharedDic setObject:@"偷偷告诉你一件事..." forKey:@"title"];
//                [sharedDic setObject:@"出境旅游不等侯，领了红包立刻走，跟好友一起浪~" forKey:@"content"];
//                [sharedDic setObject:[self splicingURLAddress:[NSString stringWithFormat:@"%@activity/pull_new",  WebBaseUrl]] forKey:@"url"];
//                [LYSharedUpdatedVersionViewController showSharedUpdatedVersionViewControllerWithParameter:sharedDic showVC:self.navigationController];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        
    }else if ([urlString containsString:@"/act/"]){
        self.navigationItem.rightBarButtonItem = nil;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (@available(iOS 11.0, *)) {
            
        }else{
            button.frame = CGRectMake(0, 0, 26, 26);
        }
        [button setImage:[UIImage imageNamed:@"pull_activity_share_btn_normal"] forState:UIControlStateNormal];
        UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        @weakify(self);
        button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                [self obtainSharingParameters];
//                NSMutableDictionary * sharedDic = [NSMutableDictionary dictionary];
//                [sharedDic setObject:@"偷偷告诉你一件事..." forKey:@"title"];
//                [sharedDic setObject:@"出境旅游不等侯，领了红包立刻走，跟好友一起浪~" forKey:@"content"];
//                [sharedDic setObject:[self splicingURLAddress:[NSString stringWithFormat:@"%@activity/pull_new",  WebBaseUrl]] forKey:@"url"];
//                [LYSharedUpdatedVersionViewController showSharedUpdatedVersionViewControllerWithParameter:sharedDic showVC:self.navigationController];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    
    [self setNavBarAlpha:urlString];
    if ([urlString isEqualToString:@"tourscool://xf.qa.tourscool.com"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [LYToursCoolAPPManager switchHome];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if ([urlString containsString:@"tourscool://"]) {
        [LYRouterManager allPowerfulOpenVCForServerWithUrlString:urlString userInfo:@{kCurrentNavigationVCKey:self.navigationController}];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if ([urlString containsString:@"tel:"]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        LYNSLog(@"%@", webView.URL);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSURL * url = webView.URL;
    NSString *urlString = (url) ? url.absoluteString : @"";
    if (![urlString containsString:@"activity/pull_new/app"]) {
        [self.webViewJavascriptBridge callHandler:LYObtainUserToken data:LYUserInfoManager.sharedUserInfoManager.userToken responseCallback:^(id responseData) {
            LYNSLog(@"LYObtainUserToken%@", responseData);
        }];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        LYNSLog(@"%@", webView.URL);
    }
}

- (void)obtainSharingParameters
{
    @weakify(self);
    [self.webView evaluateJavaScript:@"obtainSharingParameters()" completionHandler:^(NSDictionary * res, NSError * _Nullable error) {
        @strongify(self);
        LYNSLog(@"obtainSharingParameters -- %@", res);
        if (res) {
//            [LYSharedUpdatedVersionViewController showSharedUpdatedVersionViewControllerWithParameter:res showVC:self.navigationController];
        }
    }];
}

- (NSString *)splicingURLAddress:(NSString *)url
{
    if (self.webViewJavascriptBridge) {
        if (![url containsString:@"?"]) {
            url = [NSString stringWithFormat:@"%@?platform=app&language=%@&currency=%@&app_version=%@&phone_type=ios", url, [LYLanguageManager currentServerLanguage], LYUserInfoManager.sharedUserInfoManager.userCurrency, kAppVersion];
        }else{
            url = [NSString stringWithFormat:@"%@&platform=app&language=%@&currency=%@&app_version=%@&phone_type=ios", url, [LYLanguageManager currentServerLanguage], LYUserInfoManager.sharedUserInfoManager.userCurrency, kAppVersion];
        }
    }else{
        if (![url containsString:@"?"]) {
            url = [NSString stringWithFormat:@"%@?platform=app",url];
        }else{
            url = [NSString stringWithFormat:@"%@&platform=app",url];
        }
    }
    return url;
}

#pragma mark - dealloc

- (void)dealloc
{
    [self removeCookie];
    self.webView.navigationDelegate = nil;
    self.webView.UIDelegate = nil;
    self.webView = nil;
    LYNSLog(@"dealloc%@", NSStringFromClass([self class]));
}

/**
 window.webkit.messageHandlers.currentCookies.postMessage({
 "body": "buttonActionMessage"
 });
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
