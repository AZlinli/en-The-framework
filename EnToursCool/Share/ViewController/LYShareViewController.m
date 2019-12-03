//
//  LYshareViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYShareViewController.h"
#import "LYShareTableViewCell.h"
#import "LYShareViewModel.h"
#import "LYShareModel.h"
#import "UIView+LYHUD.h"
#import "UIView+LYCorner.h"
#import <ShareSDK/ShareSDK.h>

@interface LYShareViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *sharedBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) LYShareViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *topView;
@end

@implementation LYShareViewController

+ (void)showSharedViewControllerWithParameter:(NSDictionary *)parameter showVC:(UIViewController *)showVC
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYShareStoryboard" bundle:nil];
    LYShareViewController * sharedViewController = [sb instantiateViewControllerWithIdentifier:@"LYShareViewController"];
    sharedViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    sharedViewController.data = parameter;
    showVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    showVC.providesPresentationContextTransitionStyle = YES;
    showVC.definesPresentationContext = YES;
    [showVC presentViewController:sharedViewController animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    self.topView.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCSemibold_18];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_4B4B4BColor];
    self.titleLabel.text = [LYLanguageManager ly_localizedStringForKey:@"Share_Title"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYShareTableViewCell" bundle:nil] forCellReuseIdentifier:LYShareTableViewCellID];
    
    self.viewModel = [[LYShareViewModel alloc] initWithParameter:self.data];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.topView addGestureRecognizer:tap];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.sharedTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYShareTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYShareTableViewCellID];
    cell.data = [self.viewModel.sharedTypeArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     LYShareModel *model = [self.viewModel.sharedTypeArray objectAtIndex:indexPath.row];
    if (model.type == 4) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.viewModel.url;
        [UIView showMSGCenterHUDWithView:self.view msg:[LYLanguageManager ly_localizedStringForKey:@"LY_Successful_Copy_Title"]];
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
        });
        return;
    }
    
    [self sharedType:self.viewModel.type.integerValue title:self.viewModel.title content:self.viewModel.content urlPath:self.viewModel.url imagePath:self.viewModel.image imageHDPath:self.viewModel.imageHD];
}

- (void)sharedType:(NSInteger)type
             title:(NSString *)title
           content:(NSString *)content
           urlPath:(NSString *)urlPath
         imagePath:(id)imagePath
       imageHDPath:(id)imageHDPath
{
    SSDKContentType contentType = SSDKContentTypeAuto;
    if ([self.viewModel.type integerValue] == 1) {
        contentType = SSDKContentTypeImage;
    }
    
    SSDKPlatformType platformType = SSDKPlatformSubTypeWechatSession;
    if (type == 1) {
        platformType = SSDKPlatformTypeFacebook;
    } else if (type == 2) {
        platformType = SSDKPlatformTypeTwitter;
    } else if (type == 3) {
        platformType = SSDKPlatformTypeWhatsApp;
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    if (platformType == SSDKPlatformTypeFacebook) {
        NSURL *url = [NSURL URLWithString:urlPath];
        [shareParams SSDKSetupFacebookParamsByText:content image:imagePath url:url urlTitle:title urlName:nil attachementUrl:nil hashtag:nil quote:nil type:contentType];
    } else if (platformType == SSDKPlatformTypeTwitter) {
//        [shareParams SSDKSetupTwitterParamsByText:content images:imagePath video:nil latitude:10.f longitude:10.f type:contentType];
        // todo 获取经纬度
    } else if (platformType == SSDKPlatformTypeWhatsApp ) {
        [shareParams SSDKSetupWhatsAppParamsByText:content image:imagePath audio:nil video:nil menuDisplayPoint:CGPointZero type:contentType];
    }
    @weakify(self);
    [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        LYNSLog(@"%@", error);
        @strongify(self);
        if (state == SSDKResponseStateSuccess) {
//            [self analyticsSharedSuccess:type];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if (state == SSDKResponseStateCancel){
            [UIView showMSGCenterHUDWithView:self.view msg:@"您取消分享"];
        }else{
            [UIView showMSGCenterHUDWithView:self.view msg:@"分享失败"];
        }
    }];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.sharedBackGroundView circularBeadWithRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8.f, 8.f)];
}

- (IBAction)clickCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
