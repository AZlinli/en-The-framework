//
//  LYTourscoolBasicsViewController.m
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYTourscoolBasicsViewController.h"
#import "LYNetErrorView.h"
#import "LYMarqueeNavTitleView.h"
#import "UIViewController+LYNib.h"
#import <Masonry/Masonry.h>
@interface LYTourscoolBasicsViewController ()

@property (nonatomic, weak) LYMarqueeNavTitleView * marqueeNavTitleView;

@end

@implementation LYTourscoolBasicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航条颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [self findNavBarBottomImage:self.navigationController.navigationBar].hidden = YES;
    if (@available(iOS 11.0, *)) {
        
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    }
}

- (void)startMarqueeWithTitle:(NSString *)title
{
    if (!self.marqueeNavTitleView && title.length) {
        self.navigationItem.titleView = nil;
        LYMarqueeNavTitleView * marqueeNavTitleView = [[LYMarqueeNavTitleView alloc] initWithFrame:CGRectMake((kScreenWidth-200.f)/2, kStatusBarHeight + 7.f, kScreenWidth - 140.f, 30.f)];
        self.navigationItem.titleView = marqueeNavTitleView;
        [marqueeNavTitleView setupMarqueeWithTitle:title];
        [self addNotificationApplication];
        self.marqueeNavTitleView = marqueeNavTitleView;
    }
}

- (void)addNotificationApplication
{
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self stopMarqueeAnimation];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if (self.navigationController.topViewController == self) {
            [self startMarqueeAnimation];
        }
    }];
}

- (void)stopMarqueeAnimation
{
    [self.marqueeNavTitleView stopAnimation];
}

- (void)startMarqueeAnimation
{
    [self.marqueeNavTitleView startAnimation];
}

- (void)addUserLoginSuccessNotification
{
//    @weakify(self);
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kUserLoginSuccessfulIdentifier object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        @strongify(self);
//        [self userLoginSuccess];
//    }];
}

- (void)userLoginSuccess
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LYAnalyticsServiceManager pageBeginAnalyticsWithVCName:NSStringFromClass([self class])];
    if (self.navigationController.topViewController == self) {
        [self startMarqueeAnimation];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [LYAnalyticsServiceManager pageEndAnalyticsWithVCName:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopMarqueeAnimation];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

/**
 导航栏底部线条

 @param view view
 @return UIImageView
 */
- (UIImageView *)findNavBarBottomImage:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height < 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findNavBarBottomImage:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)removeNetErrorView
{
    [LYNetErrorView removeNetErrorViewWithView:self.view];
}

- (void)showNetErrorViewNoData
{
    if ([NSStringFromClass([self class]) isEqualToString:@"LYLineDetailsViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewConstraints:kTopHeight bottom:0 netErrorView:netErrorView view:self.view];
    }else if ([NSStringFromClass([self class]) isEqualToString:@"LYScenicAreaDetailsViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewConstraints:kTopHeight bottom:0 netErrorView:netErrorView view:self.view];
    }else if ([NSStringFromClass([self class]) isEqualToString:@"LYProductListViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewConstraints:kTopHeight + 72.f bottom:0 netErrorView:netErrorView view:self.view];
        [self.view insertSubview:netErrorView atIndex:1];
    }else if ([NSStringFromClass([self class]) isEqualToString:@"LYMineCollectViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewConstraints:0.f bottom:0.f netErrorView:netErrorView view:self.view];
        [LYNetErrorView setNetErrorViewContent:nil title:[LYLanguageManager ly_localizedStringForKey:@"You_Haven_Not_Focused_On_Where_You_WantTo_Go_Yet"] imageName:@"net_error_no_data_img" netErrorView:netErrorView];
    }else if ([NSStringFromClass([self class]) isEqualToString:@"LYMineCollectStrategyViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewConstraints:0.f bottom:0.f netErrorView:netErrorView view:self.view];
        [LYNetErrorView setNetErrorViewContent:nil title:[LYLanguageManager ly_localizedStringForKey:@"You_Haven_Not_Focused_On_Where_You_Strategy_Yet"] imageName:@"net_error_no_data_img" netErrorView:netErrorView];
    }else if ([NSStringFromClass([self class]) isEqualToString:@"LYOrderListViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:NO refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewContent:nil title:[LYLanguageManager ly_localizedStringForKey:@"Haven_Not_Been_Out_Lately"] imageName:@"net_error_no_data_img" netErrorView:netErrorView];
    }else if ([NSStringFromClass([self class]) isEqualToString:@"LYMineCouponsListViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:NO refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewContent:nil title:[LYLanguageManager ly_localizedStringForKey:@"You_Haven_Not_Got_Any_Coupons_Yet"] imageName:@"net_error_no_data_img" netErrorView:netErrorView];
    }else if ([NSStringFromClass([self class]) isEqualToString:@"LYScenicAreaListViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewConstraints:kTopHeight + 50.f bottom:0.f netErrorView:netErrorView view:self.view];
    }else if([NSStringFromClass([self class]) isEqualToString:@"LYGuideTourDownloadListViewController"]){
        LYNetErrorView * netErrorView = [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
        }];
        [LYNetErrorView setNetErrorViewConstraints:0.f bottom:0.f netErrorView:netErrorView view:self.view];
        [LYNetErrorView setNetErrorViewContent:nil title:[LYLanguageManager ly_localizedStringForKey:@"You_Haven_Not_voice_download_data"] imageName:@"net_error_no_voice_download_data_img" netErrorView:netErrorView fontColor:[UIColor colorWithHexString:@"93D3FA"]];
    }
    
    else{
        [LYNetErrorView showNoDataErrorViewWithView:self.view customConstraints:NO refreshBlock:^{
            
        }];
    }
}

- (void)showNetErrorView
{
    [self removeNetErrorView];
    @weakify(self);
    if ([NSStringFromClass([self class]) isEqualToString:@"LYLineDetailsViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNetErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
            @strongify(self);
            if (self.netWorkErrorBlock) {
                self.netWorkErrorBlock();
            }
        }];
        [LYNetErrorView setNetErrorViewConstraints:kTopHeight bottom:0 netErrorView:netErrorView view:self.view];
    }else if ([NSStringFromClass([self class]) isEqualToString:@"LYScenicAreaDetailsViewController"]) {
        LYNetErrorView * netErrorView = [LYNetErrorView showNetErrorViewWithView:self.view customConstraints:YES refreshBlock:^{
            @strongify(self);
            if (self.netWorkErrorBlock) {
                self.netWorkErrorBlock();
            }
        }];
        [LYNetErrorView setNetErrorViewConstraints:kTopHeight bottom:0 netErrorView:netErrorView view:self.view];
    }else{
        [LYNetErrorView showNetErrorViewWithView:self.view customConstraints:NO refreshBlock:^{
            @strongify(self);
            if (self.netWorkErrorBlock) {
                self.netWorkErrorBlock();
            }
        }];
    }
}

- (void)dealloc
{
    LYNSLog(@"dealloc - %@", NSStringFromClass([self class]));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
