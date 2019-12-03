//
//  LYResetPWDViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYResetPWDViewController.h"
#import "LYResetPWDViewModel.h"
#import "UITextField+LYUtil.h"
#import "UIView+LYHUD.h"
#import "UIView+LYUtil.h"
#import "AudioToolbox/AudioToolbox.h"
#import "LYSettingViewController.h"

@interface LYResetPWDViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *currentPWDLabel;
@property (weak, nonatomic) IBOutlet UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet UILabel *newerPWDLabel;
@property (weak, nonatomic) IBOutlet UITextField *newerPWDTextField;
@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *errorTipsLabel;
@property (strong, nonatomic) LYResetPWDViewModel *viewModel;
@end

@implementation LYResetPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.navigationItem.title = @"Tripscool";
    self.currentPWDLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.currentPWDLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.currentPWDLabel.text = @"Current password";
    
    self.newerPWDLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.newerPWDLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.newerPWDLabel.text = @"New password";
    
    self.confirmLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.confirmLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.confirmLabel.text = @"Confirm new password";
    
    self.resetButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    [self.resetButton setTitleColor:[UIColor colorWithHexString:@"f9f9f9"] forState:UIControlStateNormal];
    [self.resetButton setTitle:@"Save" forState:UIControlStateNormal];
    self.resetButton.backgroundColor = [UIColor colorWithHexString:@"19A8C7"];
    
    [self.currentTextField setPlaceholderWithColor:[UIColor colorWithHexString:@"A7A7A7"] conent:@"" font:[UIFont fontWithName:@"Arial" size: 14]];
    [self.currentTextField setFont:[UIFont fontWithName:@"Arial" size: 12]];
    [self.currentTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.newerPWDTextField setPlaceholderWithColor:[UIColor colorWithHexString:@"A7A7A7"] conent:@"6 to 20 characters" font:[UIFont fontWithName:@"Arial" size: 12]];
    [self.newerPWDTextField setFont:[UIFont fontWithName:@"Arial" size: 12]];
    [self.newerPWDTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.confirmTextFiled setPlaceholderWithColor:[UIColor colorWithHexString:@"A7A7A7"] conent:@"" font:[UIFont fontWithName:@"Arial" size: 12]];
    [self.confirmTextFiled setFont:[UIFont fontWithName:@"Arial" size: 12]];
    [self.confirmTextFiled setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    self.errorTipsLabel.hidden = YES;
    self.errorTipsLabel.textColor = [UIColor colorWithHexString:@"EC6564"];
    self.errorTipsLabel.font = [UIFont fontWithName:@"Arial" size: 12];

}

- (void)bindViewModel{
    self.viewModel = [[LYResetPWDViewModel alloc] init];
    @weakify(self);

    
    [self.currentTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.errorTipsLabel.hidden = YES;
        
        if (x.length >= 20) {
            self.currentTextField.text = [x substringToIndex:20];
        }
    }];
    
     RAC(self.viewModel, currentPWD) = self.currentTextField.rac_textSignal;
    
    [self.newerPWDTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.errorTipsLabel.hidden = YES;
        if (x.length >= 20) {
            self.newerPWDTextField.text = [x substringToIndex:20];
        }
    }];
    
    RAC(self.viewModel, userPWD1) = self.newerPWDTextField.rac_textSignal;
    
    [self.confirmTextFiled.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.errorTipsLabel.hidden = YES;
        if (x.length >= 20) {
            self.confirmTextFiled.text = [x substringToIndex:20];
        }
    }];
    
    RAC(self.viewModel, userPWD2) = self.confirmTextFiled.rac_textSignal;
    
    [self.viewModel.saveCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
           @strongify(self);
        [[[UIApplication sharedApplication] keyWindow] endEditing:NO];
           [self login_modulesDismissHUD];
           if ([x[@"code"] integerValue] == 0) {

               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   @strongify(self);
//                   [self endFlowBackVC];
                   LYSettingViewController *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
                   vc.isReset = YES;
                   [self.navigationController popToViewController:vc animated:YES];
               });
           }else{
               if ([x[@"type"] integerValue] == 1) {
                   [self.currentTextField addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }
               else if ([x[@"type"] integerValue] == 2) {
                   [self.newerPWDTextField addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }else if ([x[@"type"] integerValue] == 3) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.currentTextField addViewAnimation];
                   self.errorTipsLabel.text = @"Password must contain 6 to 20 characters including letter and number";
               }else if ([x[@"type"] integerValue] == 4) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.newerPWDTextField addViewAnimation];
                   self.errorTipsLabel.text = @"Password must contain 6 to 20 characters including letter and number";
                    //密码不符合规则
               }
               else if ([x[@"type"] integerValue] == 5) {
                   [self.confirmTextFiled addViewAnimation];
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
               }
               else if ([x[@"type"] integerValue] == 6) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.confirmTextFiled addViewAnimation];
                   self.errorTipsLabel.text = @"Password must contain 6 to 20 characters including letter and number";
                    //密码不符合规则
               }
               else if ([x[@"type"] integerValue] == 7) {
                   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   self.errorTipsLabel.hidden = NO;
                   [self.confirmTextFiled addViewAnimation];
                   self.errorTipsLabel.text = @"Your Confirmation Password must match your Password";
               }
               else{
                   [self login_modulesShowMSGCenterHUDWithMSG:x[@"msg"]];
               }
               
           }
       }];
       
       [self.viewModel.saveCommand.errors subscribeNext:^(NSError * _Nullable x) {
           @strongify(self);
           [self login_modulesDismissHUD];
           [self login_modulesShowMSGCenterHUDWithMSG:[LYLanguageManager ly_localizedStringForKey:@"HUD_Net_Working_Error"]];
       }];
    
    self.resetButton.rac_command = self.viewModel.saveCommand;
    //todo 重置成功是否需要退出登录？
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.currentTextField) {
        [self.newerPWDTextField becomeFirstResponder];
    }
    if (textField == self.newerPWDTextField) {
        [self.confirmTextFiled becomeFirstResponder];
    }
    if (textField == self.confirmTextFiled) {
        [textField resignFirstResponder];
    }
    
    return YES;
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


- (IBAction)clickButton1:(id)sender {
    [self.currentTextField becomeFirstResponder];
}

- (IBAction)clickButton2:(id)sender {
    [self.newerPWDTextField becomeFirstResponder];
}

- (IBAction)clickButton3:(id)sender {
    [self.confirmTextFiled becomeFirstResponder];
}

- (void)dealloc{
    
}


@end
