//
//  LYRegisterViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYRegisterViewController.h"
#import "TTTAttributedLabel.h"
#import "LYRouterManager.h"
#import "UITextField+LYUtil.h"
#import "NSString+LYTool.h"
#import "UIView+LYHUD.h"
#import "AudioToolbox/AudioToolbox.h"
#import "UIView+LYUtil.h"
#import "LYRegisterViewModel.h"

@interface LYRegisterViewController ()<TTTAttributedLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *loginImageView;
@property (weak, nonatomic) IBOutlet UILabel *setupTipsLabel;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIView *PWD1View;
@property (weak, nonatomic) IBOutlet UITextField *PWD1TextField;
@property (weak, nonatomic) IBOutlet UIView *PWD2View;
@property (weak, nonatomic) IBOutlet UITextField *PWD2TextField;
@property (weak, nonatomic) IBOutlet UILabel *errorTipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *privacyLabel;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) LYRegisterViewModel *viewModel;
@end

@implementation LYRegisterViewController

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
    
    self.setupTipsLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.setupTipsLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.setupTipsLabel.text = [LYLanguageManager ly_localizedStringForKey:@"Sign_Up_Tips"];
    
    
    [self.nameTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_484848Color] conent:@"Name" font:[UIFont fontWithName:@"Arial" size: 14]];
    [self.nameTextField setFont:[UIFont fontWithName:@"Arial" size: 14]];
    [self.nameTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.emailTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_484848Color] conent:@"Email" font:[UIFont fontWithName:@"Arial" size: 14]];
    [self.emailTextField setFont:[UIFont fontWithName:@"Arial" size: 14]];
    [self.emailTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.PWD1TextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_484848Color] conent:@"Password" font:[UIFont fontWithName:@"Arial" size: 14]];
    [self.PWD1TextField setFont:[UIFont fontWithName:@"Arial" size: 14]];
    [self.PWD1TextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.PWD2TextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_484848Color] conent:@"Confirm password" font:[UIFont fontWithName:@"Arial" size: 14]];
    [self.PWD2TextField setFont:[UIFont fontWithName:@"Arial" size: 14]];
    [self.PWD2TextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
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
    self.viewModel = [[LYRegisterViewModel alloc] init];
    @weakify(self);
    
    [self.nameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.errorTipsLabel.hidden = YES;
        self.emailView.layer.borderColor = [UIColor colorWithHexString:@"C7D0D9"].CGColor;
        NSString *lang = self.nameTextField.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) {
            UITextRange *selectedRange = [self.emailTextField markedTextRange];
            UITextPosition *position = [self.emailTextField positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                self.nameTextField.text = [x trim];
            }
        } else {
            self.nameTextField.text = [x trim];
        }
        if (x.length >= 32) {
            self.nameTextField.text = [x substringToIndex:32];
        }
    }];
    RAC(self.viewModel, userName) = self.nameTextField.rac_textSignal;
    
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
    
     RAC(self.viewModel, userAccounts) = self.emailTextField.rac_textSignal;
    
    [self.PWD1TextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.errorTipsLabel.hidden = YES;
        self.PWD1View.layer.borderColor = [UIColor colorWithHexString:@"C7D0D9"].CGColor;
        if (x.length >= 20) {
            self.PWD1TextField.text = [x substringToIndex:20];
        }
    }];
    
    RAC(self.viewModel, userPWD1) = self.PWD1TextField.rac_textSignal;
    
    [self.PWD2TextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.errorTipsLabel.hidden = YES;
        self.PWD2View.layer.borderColor = [UIColor colorWithHexString:@"C7D0D9"].CGColor;
        if (x.length >= 20) {
            self.PWD2TextField.text = [x substringToIndex:20];
        }
    }];
    
    RAC(self.viewModel, userPWD2) = self.PWD2TextField.rac_textSignal;
    
    [self.viewModel.setupCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
           @strongify(self);
           [self login_modulesDismissHUD];
           if ([x[@"code"] integerValue] == 0) {
               [self login_modulesShowMSGCenterHUDWithMSG:@"Sign up success"];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self endFlowBackVC];
               });
           }else{
               if ([x[@"type"] integerValue] == 1) {
                   [self.emailTextField addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }
               else if ([x[@"type"] integerValue] == 2) {
                   [self.PWD1TextField addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }else if ([x[@"type"] integerValue] == 3) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.emailTextField addViewAnimation];
                   self.errorTipsLabel.text = @"Please enter a valid email address";
                   self.emailView.layer.borderColor = [UIColor colorWithHexString:@"EC6564"].CGColor;
                   //邮箱格式不对
               }else if ([x[@"type"] integerValue] == 4) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.PWD1TextField addViewAnimation];
                   self.errorTipsLabel.text = @"Password must contain 6 to 20 characters including letter and number";
                    //密码不符合规则
                   self.PWD1View.layer.borderColor = [UIColor colorWithHexString:@"EC6564"].CGColor;
               }
               else if ([x[@"type"] integerValue] == 5) {
                   [self.PWD2TextField addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }
               else if ([x[@"type"] integerValue] == 6) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.PWD2TextField addViewAnimation];
                   self.errorTipsLabel.text = @"Password must contain 6 to 20 characters including letter and number";
                    //密码不符合规则
                   self.PWD2View.layer.borderColor = [UIColor colorWithHexString:@"EC6564"].CGColor;
               }
               else if ([x[@"type"] integerValue] == 7) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.PWD2TextField addViewAnimation];
                   self.errorTipsLabel.text = @"Your Confirmation Password must match your Password";
                   self.PWD2View.layer.borderColor = [UIColor colorWithHexString:@"EC6564"].CGColor;
               }else if ([x[@"type"] integerValue] == 8) {
                   [self.nameTextField addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }else if ([x[@"type"] integerValue] == 9) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.nameTextField addViewAnimation];
                   self.errorTipsLabel.text = @"Name must between 2 and 32 characters";
                   self.nameView.layer.borderColor = [UIColor colorWithHexString:@"EC6564"].CGColor;
               }
               else{
                   [self login_modulesShowMSGCenterHUDWithMSG:x[@"msg"]];
               }
               
           }
       }];
       
       [self.viewModel.setupCommand.errors subscribeNext:^(NSError * _Nullable x) {
           @strongify(self);
           [self login_modulesDismissHUD];
           [self login_modulesShowMSGCenterHUDWithMSG:[LYLanguageManager ly_localizedStringForKey:@"HUD_Net_Working_Error"]];
       }];
    
    self.signUpButton.rac_command = self.viewModel.setupCommand;
}

- (IBAction)clickLoginButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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


@end
