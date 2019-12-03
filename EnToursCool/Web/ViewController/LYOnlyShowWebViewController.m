//
//  LYOnlyShowWebViewController.m
//  ToursCool
//
//  Created by tourscool on 4/1/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYOnlyShowWebViewController.h"
#import "UIViewController+LYNib.h"
#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>

@interface LYOnlyShowWebViewController ()<WKNavigationDelegate>
@property (nonatomic, weak) WKWebView * webView;
@property (nonatomic, weak) UIProgressView * progressView;
@end

@implementation LYOnlyShowWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUserInterface];
    @weakify(self);
    [[self.webView rac_valuesForKeyPath:@"estimatedProgress" observer:self] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        LYNSLog(@"%@", x);
        CGFloat newprogress = [x floatValue];
        if (newprogress == 1.f) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }];
    
    [RACObserve(self.webView, title) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSString * titleStr = [NSString stringWithFormat:@"%@", x];
        if (titleStr.length) {
            self.navigationItem.title = titleStr;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (BOOL)navigationShouldPopOnBackButton
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
    return NO;
}

- (void)setupUserInterface
{
    WKWebViewConfiguration *webViewconfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webViewconfiguration];
    [self.view addSubview:webView];
    [webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_topMargin);
        } else {
            make.top.equalTo(self.view.mas_top).offset(kTopHeight);
        }
        make.right.bottom.left.equalTo(self.view);
    }];
    webView.navigationDelegate = self;
    self.webView = webView;
    [self webViewLoadURL:self.data[@"url"]];
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    progressView.trackTintColor = [UIColor whiteColor];
    progressView.tintColor = [LYTourscoolAPPStyleManager ly_399EF6Color];
    [self.view addSubview:progressView];
    [progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_topMargin);
        } else {
            make.top.equalTo(self.view.mas_top).offset(kTopHeight);
        }
        make.right.left.equalTo(self.view);
        make.height.offset(2.f);
    }];
    self.progressView = progressView;
}

- (void)webViewLoadURL:(NSString *)urlStr
{
    LYNSLog(@"网页地址== %@", urlStr);
    if (urlStr.length) {
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [self.webView loadRequest:request];
    }
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
