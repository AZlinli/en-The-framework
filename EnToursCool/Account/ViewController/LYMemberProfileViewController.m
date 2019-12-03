//
//  LYMemberProfileViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/29.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYMemberProfileViewController.h"
#import "LYMemberProfileViewModel.h"
#import "LYDateView.h"
#import "LYDateTools.h"
#import "UIView+LYNib.h"
#import "UIImage+LYUtil.h"
#import "LYSafeImagePickerViewController.h"

@interface LYMemberProfileViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *nameSepImageView;//detail_sep_line
@property (weak, nonatomic) IBOutlet UITextField *calTextField;
@property (weak, nonatomic) IBOutlet UIImageView *calSepImageView;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
@property (weak, nonatomic) IBOutlet UIButton *unkownButton;
@property (weak, nonatomic) IBOutlet UILabel *nameErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTitleLabel;
@property (nonatomic, strong) LYSafeImagePickerViewController *imagePickerController;
@property(nonatomic, strong) LYMemberProfileViewModel *viewModel;
@end

@implementation LYMemberProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.title = @"Member Profile";
    self.dateErrorLabel.hidden = YES;
    self.nameErrorLabel.hidden = YES;
    
    [self.maleButton setTitleEdgeInsets:UIEdgeInsetsMake(0,14, 0, 0)];
    [self.maleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,14)];
    [self.femaleButton setTitleEdgeInsets:UIEdgeInsetsMake(0,14, 0, 0)];
    [self.femaleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,14)];
    [self.unkownButton setTitleEdgeInsets:UIEdgeInsetsMake(0,14, 0, 0)];
    [self.unkownButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,14)];

    [self.maleButton setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.maleButton setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];

    [self.femaleButton setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.femaleButton setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];

    [self.unkownButton setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.unkownButton setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];
    self.maleButton.selected = YES;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Name *" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size: 14], NSForegroundColorAttributeName: [UIColor colorWithRed:248/255.0 green:76/255.0 blue:76/255.0 alpha:1.0]}];
    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size: 14], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"7f7f7f"]} range:NSMakeRange(0, 4)];
    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size: 14], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"F84C4C"]} range:NSMakeRange(5, 1)];
    self.nameTitleLabel.attributedText = string;
    
    
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"Date of Birth *" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size: 14], NSForegroundColorAttributeName: [UIColor colorWithRed:248/255.0 green:76/255.0 blue:76/255.0 alpha:1.0]}];

    [string1 addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size: 14], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"7f7f7f"]} range:NSMakeRange(0, 13)];

    [string1 addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size: 14], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"F84C4C"]} range:NSMakeRange(13, 2)];

    self.dateTitleLabel.attributedText = string1;
}

- (void)bindViewModel{
    self.viewModel = [[LYMemberProfileViewModel alloc] init];
    
    
    @weakify(self);
    [self.viewModel.saveCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            if ([x[@"type"] integerValue] == 1) {
                self.nameErrorLabel.hidden = NO;
                self.nameErrorLabel.text = @"Please enter name";
                self.nameSepImageView.image = [UIImage imageNamed:@"red_sep_line"];
            }
            else if ([x[@"type"] integerValue] == 2) {
                self.dateErrorLabel.hidden = NO;
                self.dateErrorLabel.text = @"Please choose date of birth";
              self.calSepImageView.image = [UIImage imageNamed:@"red_sep_line"];
            }
            

        }
    }];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:[LYLanguageManager ly_localizedStringForKey:@"Save"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Arial" size: 17];
    [button setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:UIControlStateNormal];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    button.rac_command = self.viewModel.saveCommand;
}

- (IBAction)clickMaleButton:(id)sender {
    if (!self.maleButton.selected) {
        self.maleButton.selected = YES;
        self.femaleButton.selected = NO;
        self.unkownButton.selected = NO;
        self.viewModel.gender = @"male";
    }
}

- (IBAction)clickFemaleButton:(id)sender {
    if (!self.femaleButton.selected) {
        self.femaleButton.selected = YES;
        self.maleButton.selected = NO;
        self.unkownButton.selected = NO;
        self.viewModel.gender = @"female";
    }
}

- (IBAction)clickUnkownButton:(id)sender {
    if (!self.unkownButton.selected) {
        self.unkownButton.selected = YES;
        self.maleButton.selected = NO;
        self.femaleButton.selected = NO;
        self.viewModel.gender = @"unkown";
    }
}


- (IBAction)clickCalcButton:(id)sender {
    
    @weakify(self);
     LYDateView * dateView = [LYDateView loadFromNibWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
       [dateView setUserSelectDateBlock:^(NSDate *selectDate) {
           @strongify(self);
           NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
           NSString *dateComponents = @"yMMMMd";

           NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:dateComponents options:0 locale:usLocale];

           self.viewModel.birthDate = [LYDateTools dateToStringWithFormatterStr:dateFormat date:selectDate];
           self.calTextField.text = self.viewModel.birthDate;
           self.calSepImageView.image = [UIImage imageNamed:@"detail_sep_line"];
           self.dateErrorLabel.hidden = YES;
       }];
       [kWindowRootViewController.view addSubview:dateView];
}


- (IBAction)clickPicButton:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
      UIAlertAction * acncelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          
      }];

      [alertController addAction:acncelAction];
      @weakify(self);
      
      UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"Take a photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          @strongify(self);
          [self setupImagePickerControllerWithType:0];
      }];

      [alertController addAction:photoAction];
      
      UIAlertAction * photoAlbumAction = [UIAlertAction actionWithTitle:@"Albums" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          @strongify(self);
          [self setupImagePickerControllerWithType:1];
      }];

      [alertController addAction:photoAlbumAction];
      [self presentViewController:alertController animated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *text = textField.text;
    if (textField == self.nameTextField) {
        self.viewModel.name = text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.nameSepImageView.image = [UIImage imageNamed:@"detail_sep_line"];
    self.nameErrorLabel.hidden = YES;
    return YES;
}


#pragma mark - UIImagePickerControllerDelegate

- (void)setupImagePickerControllerWithType:(NSInteger)type
{
    if (!self.imagePickerController) {
        LYSafeImagePickerViewController *imagePickerController = [[LYSafeImagePickerViewController alloc] init];
        imagePickerController.allowsEditing = YES;
        self.imagePickerController = imagePickerController;
    }
    if (!self.imagePickerController.delegate) {
        self.imagePickerController.delegate = self;
    }
    if (type == 0) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePickerController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.imagePickerController.delegate = nil;
}

//todo
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.viewModel.selectedImage = image;
    self.headerImageView.image =  [UIImage rescaleToSize:image toSize:CGSizeMake(30.f, 30.f)];;
    
//    self.userHeaderImageView.image = [UIImage rescaleToSize:image toSize:CGSizeMake(35.f, 35.f)];
//    self.modifyUserInfoViewModel.userUpdateFace = @"1";
//    [self.modifyUserInfoViewModel.updateImageCommand execute:image];
//
    [self.imagePickerController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.imagePickerController.delegate = nil;
}



@end
