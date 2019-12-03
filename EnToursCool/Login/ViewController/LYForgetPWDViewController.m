//
//  LYForgetPWDViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYForgetPWDViewController.h"
#import "LYForgetPWDViewModel.h"
#import "UITextField+LYUtil.h"
#import "NSString+LYTool.h"
#import "LYLoginViewModel.h"
#import "UIView+LYHUD.h"
#import "AudioToolbox/AudioToolbox.h"
#import "UIView+LYUtil.h"
#import "LYToursCoolAPPManager.h"

@interface LYForgetPWDViewController ()

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *descLabel1;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorTipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetPWDButton;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *descLabel2;


@property(nonatomic,strong) LYForgetPWDViewModel *viewModel;
@end

@implementation LYForgetPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.navigationItem.title = @"Tripscool";
    self.view1.hidden = NO;
    self.view2.hidden = YES;
    self.errorTipsLabel.hidden = YES;
    self.errorTipsLabel.textColor = [UIColor colorWithHexString:@"EC6564"];
    self.errorTipsLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    
    self.titleLabel1.text = @"Forgot password";
    self.titleLabel1.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel1.font = [UIFont fontWithName:@"Arial-BoldMT" size: 20];

    self.descLabel1.text = @"Enter the email address of your Tripscool account,and we will send an email to reset your password";
    self.descLabel1.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.descLabel1.font = [UIFont fontWithName:@"Arial" size: 12];
    
    [self.emailTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_484848Color] conent:@"Email" font:[UIFont fontWithName:@"Arial" size: 14]];
    [self.emailTextField setFont:[UIFont fontWithName:@"Arial" size: 14]];
    [self.emailTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    self.titleLabel2.text = @"Reset link sent to your mailbox";
    self.titleLabel2.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel2.font = [UIFont fontWithName:@"Arial-BoldMT" size: 20];

    self.descLabel2.text = @"We've just sent an email with instructions for selecting a new password. Please check your email now.If you haven't received an email from us, please contact us for help. Thanks!";
    self.descLabel2.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.descLabel2.font = [UIFont fontWithName:@"Arial" size: 12];
    
}

- (void)bindViewModel{
    self.viewModel = [[LYForgetPWDViewModel alloc] init];
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
    
    [self.viewModel.resetCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self login_modulesDismissHUD];
        if ([x[@"code"] integerValue] == 0) {
            self.view1.hidden = YES;
            self.view2.hidden = NO;
//            [self login_modulesShowMSGCenterHUDWithMSG:@"Login success"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self endFlowBackVC];
//            });
        }else{
            if ([x[@"type"] integerValue] == 1) {
                [self.emailTextField addViewAnimation];
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }else if ([x[@"type"] integerValue] == 2) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                self.errorTipsLabel.hidden = NO;
                [self.emailTextField addViewAnimation];
                self.errorTipsLabel.text = @"Incorrect email format";
                self.emailView.layer.borderColor = [UIColor colorWithHexString:@"EC6564"].CGColor;
                //邮箱格式不对
            }
            else{
                [self login_modulesShowMSGCenterHUDWithMSG:x[@"msg"]];
            }
            
        }
    }];
    
    [self.viewModel.resetCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self login_modulesDismissHUD];
        [self login_modulesShowMSGCenterHUDWithMSG:[LYLanguageManager ly_localizedStringForKey:@"HUD_Net_Working_Error"]];
    }];
    
    self.resetPWDButton.rac_command = self.viewModel.resetCommand;
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

- (IBAction)clickBackToHomeButton:(id)sender {
    [self endFlowBackVC];
    [LYToursCoolAPPManager switchHome];
}


- (IBAction)clickContactUsButton:(id)sender {
    // todo
}


@end
