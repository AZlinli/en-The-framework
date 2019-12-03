//
//  LYEditTravelerInfoViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYEditTravelerInfoViewController.h"
#import "AudioToolbox/AudioToolbox.h"
#import "LYEditTravelerInfoViewModel.h"
#import "UIView+LYHUD.h"
#import "UIView+LYUtil.h"
#import "LYDateView.h"
#import "UIView+LYNib.h"
#import "LYDateTools.h"

@interface LYEditTravelerInfoViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIView *birthDateView;
@property (strong, nonatomic) LYEditTravelerInfoViewModel *viewModel;
@end

@implementation LYEditTravelerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.navigationItem.title = @"Traveler information";
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    [self.countryButton setImage:[UIImage imageNamed:@"list_down_arrow"] forState:UIControlStateNormal];
    [self.countryButton setTitle:@"Country" forState:UIControlStateNormal];
    [self.countryButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.countryButton.imageView.image.size.width, 0, self.countryButton.imageView.image.size.width + 10)];
    [self.countryButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.countryButton.titleLabel.bounds.size.width+ 10, 0, -self.countryButton.titleLabel.bounds.size.width)];
}

- (void)bindViewModel{
    if (self.data) {
        //修改
        self.viewModel = [[LYEditTravelerInfoViewModel alloc] initWithModel:self.data];
        self.firstNameTextField.text = self.viewModel.firstName;
        self.lastNameTextField.text = self.viewModel.lastName;
        self.birthDateLabel.text = self.viewModel.brithDate;
        [self.countryButton setTitle:self.viewModel.country forState:UIControlStateNormal];
        self.passwordTextField.text = self.viewModel.passport;
    }else{
        //新增
        self.viewModel = [[LYEditTravelerInfoViewModel alloc] init];
    }
    @weakify(self);
    RAC(self.viewModel, firstName) = self.firstNameTextField.rac_textSignal;
    RAC(self.viewModel, lastName) = self.lastNameTextField.rac_textSignal;
    RAC(self.viewModel, passport) = self.passwordTextField.rac_textSignal;
    
    [self.viewModel.saveCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
               @strongify(self);
            [[[UIApplication sharedApplication] keyWindow] endEditing:NO];
               [self login_modulesDismissHUD];
               if ([x[@"code"] integerValue] == 0) {

                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       @strongify(self);
    //                   [self endFlowBackVC];
                       [self.navigationController popViewControllerAnimated:YES];
//                       [self.navigationController popToViewController:vc animated:YES];
                   });
               }else{
                   if ([x[@"type"] integerValue] == 1) {
                       [self.firstNameTextField addViewAnimation];
                       AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   }
                   else if ([x[@"type"] integerValue] == 2) {
                       [self.lastNameTextField addViewAnimation];
                       AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                   }else if ([x[@"type"] integerValue] == 3) {
                       AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                       [self.birthDateView addViewAnimation];
                   }else if ([x[@"type"] integerValue] == 4) {
                       AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                       [self.countryButton addViewAnimation];
                   }
                   else if ([x[@"type"] integerValue] == 5) {
                       [self.passwordTextField addViewAnimation];
                       AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
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
        
    
    self.saveButton.rac_command = self.viewModel.saveCommand;
}

- (IBAction)clickDateButton:(id)sender {
    @weakify(self);
     LYDateView * dateView = [LYDateView loadFromNibWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
       [dateView setUserSelectDateBlock:^(NSDate *selectDate) {
           @strongify(self);
           NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
           NSString *dateComponents = @"yMMMMd";

           NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:dateComponents options:0 locale:usLocale];

           self.viewModel.brithDate = [LYDateTools dateToStringWithFormatterStr:dateFormat date:selectDate];
           self.birthDateLabel.text = self.viewModel.brithDate;
       }];
       [kWindowRootViewController.view addSubview:dateView];
}

- (IBAction)clickCountryButton:(id)sender {
    
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
