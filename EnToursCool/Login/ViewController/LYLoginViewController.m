//
//  LYLoginViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYLoginViewController.h"
#import "TTTAttributedLabel.h"
#import "LYRouterManager.h"
#import "UITextField+LYUtil.h"
#import "NSString+LYTool.h"
#import "LYLoginViewModel.h"
#import "UIView+LYHUD.h"
#import "AudioToolbox/AudioToolbox.h"
#import "UIView+LYUtil.h"
#import "LYRegisterViewController.h"
#import "LYForgetPWDViewController.h"

@interface LYLoginViewController ()<TTTAttributedLabelDelegate>
@property (weak, nonatomic) IBOutlet UILabel *loginTipsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *loginImageview;
@property (weak, nonatomic) IBOutlet UIButton *forgetPWDButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *privacyLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorTipsLabel;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;

@property (strong, nonatomic) LYLoginViewModel *viewModel;
@end

@implementation LYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.navigationItem.title = @"Tripscool";
    
    self.errorTipsLabel.hidden = YES;
    self.errorTipsLabel.textColor = [UIColor colorWithHexString:@"EC6564"];
    self.errorTipsLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    
    self.loginTipsLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.loginTipsLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.loginTipsLabel.text = [LYLanguageManager ly_localizedStringForKey:@"Login_Tips"];
    
    [self.emailTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_484848Color] conent:@"Email" font:[UIFont fontWithName:@"Arial" size: 14]];
    [self.emailTextField setFont:[UIFont fontWithName:@"Arial" size: 14]];
    [self.emailTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.pwdTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_484848Color] conent:@"Password" font:[UIFont fontWithName:@"Arial" size: 14]];
    [self.pwdTextField setFont:[UIFont fontWithName:@"Arial" size: 14]];
    [self.pwdTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    self.forgetPWDButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    [self.forgetPWDButton setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:UIControlStateNormal];
    [self.forgetPWDButton setTitle:@"Forgot password" forState:UIControlStateNormal];
    
    self.registerButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    [self.registerButton setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:UIControlStateNormal];
    [self.registerButton setTitle:@"Sign up" forState:UIControlStateNormal];
    
    self.privacyLabel.delegate = self;
    self.privacyLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    self.privacyLabel.numberOfLines = 2;

    
    NSString *privacyContent = @"By creating or logging into an account you are agreeing with our Terms or Service and Privacy Statement";
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:privacyContent];
    [mutableAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"7F7F7F"],NSFontAttributeName:[UIFont fontWithName:@"Arial" size: 12]} range:NSMakeRange(0, 65)];
    [mutableAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"19A8C7"],NSFontAttributeName:[UIFont fontWithName:@"Arial" size: 12]} range:NSMakeRange(65, 38)];
    self.privacyLabel.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    self.privacyLabel.text = mutableAttributedString;
    
    NSURL *firstUrl = [NSURL URLWithString:@"http://www.touscool.com"];//Terms or Service
    NSURL *lastUrl = [NSURL URLWithString:@"http://www.touscool1.com"]; //@"Privacy Statement"
    [self.privacyLabel addLinkToURL:firstUrl withRange:NSMakeRange(65, 16)];
    [self.privacyLabel addLinkToURL:lastUrl withRange:NSMakeRange(86, 17)];
}

- (void)bindViewModel{
    self.viewModel = [[LYLoginViewModel alloc] init];
    
    RACChannelTerminal *modelTerminal = RACChannelTo(self.viewModel, userAccounts);
    RAC(self.emailTextField, text) = modelTerminal;
    [self.emailTextField.rac_textSignal subscribe:modelTerminal];
    @weakify(self);
    [self.emailTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.errorTipsLabel.hidden = YES;
        self.emailView.layer.borderColor = [UIColor colorWithHexString:@"C7D0D9"].CGColor;
        NSString *lang = self.emailTextField.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) {
            UITextRange *selectedRange = [self.emailTextField markedTextRange];
            UITextPosition *position = [self.emailTextField positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                self.emailTextField.text = [x trim];
            }
        } else {
            self.emailTextField.text = [x trim];
        }
    }];
    
    [self.pwdTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.errorTipsLabel.hidden = YES;
        self.pwdView.layer.borderColor = [UIColor colorWithHexString:@"C7D0D9"].CGColor;
        if (x.length >= 20) {
            self.pwdTextField.text = [x substringToIndex:20];
        }
    }];
    RAC(self.viewModel, userPWD) = self.pwdTextField.rac_textSignal;
//    [self.viewModel.loginCommand.executing subscribeNext:^(NSNumber * _Nullable x) {
//           @strongify(self);
//           if ([x boolValue]) {
//               [self login_modulesShowLoadingHUDWithMSG:nil];
//           }
//       }];
       
       [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
           @strongify(self);
           [self login_modulesDismissHUD];
           if ([x[@"code"] integerValue] == 0) {
               [self login_modulesShowMSGCenterHUDWithMSG:@"Login success"];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self endFlowBackVC];
               });
           }else{
               if ([x[@"type"] integerValue] == 1) {
                   [self.emailTextField addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }
               else if ([x[@"type"] integerValue] == 2) {
                   [self.pwdTextField addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }else if ([x[@"type"] integerValue] == 3) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.emailTextField addViewAnimation];
                   self.errorTipsLabel.text = @"Incorrect email format";
                   self.emailView.layer.borderColor = [UIColor colorWithHexString:@"EC6564"].CGColor;
                   //邮箱格式不对
               }else if ([x[@"type"] integerValue] == 4) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.pwdTextField addViewAnimation];
                   self.errorTipsLabel.text = @"Password must contain 6 to 20 characters including letter and number";
                    //密码不符合规则
                   self.pwdView.layer.borderColor = [UIColor colorWithHexString:@"EC6564"].CGColor;
               }
               else{
                   [self login_modulesShowMSGCenterHUDWithMSG:x[@"msg"]];
               }
               
           }
       }];
       
       [self.viewModel.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
           @strongify(self);
           [self login_modulesDismissHUD];
           [self login_modulesShowMSGCenterHUDWithMSG:[LYLanguageManager ly_localizedStringForKey:@"HUD_Net_Working_Error"]];
       }];
    
    self.loginButton.rac_command = self.viewModel.loginCommand;
}

- (void)attributedLabel:(TTTAttributedLabel*)label didSelectLinkWithURL:(NSURL*)url{
    if ([[url absoluteString] isEqualToString:@"http://www.touscool.com"]) {
//        [LYRouterManager openSomeOneVCWithParameters:@[self.viewController.navigationController,@{@"url":[NSString stringWithFormat:@"%@%@", WebBaseUrl, UserAgreementWebPath]}] urlKey:SafariViewControllerKey];
    }else{
//        [LYRouterManager openSomeOneVCWithParameters:@[self.viewController.navigationController,@{@"url":[NSString stringWithFormat:@"%@%@", WebBaseUrl, PrivacyPolicyWebPath]}] urlKey:SafariViewControllerKey];
    }
}

#pragma mark - LYHUD

- (void)login_modulesDismissHUD
{
    [UIView dismissHUDWithView:self.navigationController.view];
}

- (void)login_modulesShowMSGCenterHUDWithMSG:(NSString *)msg
{
    [UIView showMSGCenterHUDWithView:self.navigationController.view msg:msg];
}

- (void)login_modulesShowLoadingHUDWithMSG:(NSString *)msg
{
    [UIView showLoadingHUDWithView:self.navigationController.view msg:msg];
}

- (void)endFlowBackVC
{
    UIViewController * lastViewController = [self.navigationController.viewControllers objectAtIndex:0];
    if (self.navigationController.viewControllers.count >= 1) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    if (lastViewController.presentingViewController) {
        [lastViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}



- (IBAction)clickForgetPWDButton:(id)sender {
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYLoginViewControllerStoryboard" bundle:nil];
    LYForgetPWDViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYForgetPWDViewController"];

    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickRegisterButton:(id)sender {
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYLoginViewControllerStoryboard" bundle:nil];
    LYRegisterViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYRegisterViewController"];

    [self.navigationController pushViewController:vc animated:YES];
}

@end
