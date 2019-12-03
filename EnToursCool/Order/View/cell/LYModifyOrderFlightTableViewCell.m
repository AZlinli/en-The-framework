//
//  LYModifyOrderFlightTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYModifyOrderFlightTableViewCell.h"
#import "UITextField+LYUtil.h"
#import "LYDateView.h"
#import "UIView+LYUtil.h"
#import "UIView+LYNib.h"
#import "LYDateTools.h"

NSString * const LYModifyOrderFlightTableViewCellID = @"LYModifyOrderFlightTableViewCellID";
@interface LYModifyOrderFlightTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *arrivalAirlineTextField;
@property (weak, nonatomic) IBOutlet UITextField *arrivalFligjtNumberTextFlightTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *arrivalLandingAirportTextField;
@property (weak, nonatomic) IBOutlet UITextField *arrivalTimeTextField;
@property (weak, nonatomic) IBOutlet UIButton *arrivalCalButton;
@property (weak, nonatomic) IBOutlet UITextField *departureAirlineTextField;
@property (weak, nonatomic) IBOutlet UITextField *departureFlightNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *departureAirportTextField;
@property (weak, nonatomic) IBOutlet UITextField *departureTimeTextField;
@property (weak, nonatomic) IBOutlet UIButton *departureCalButton;

@property (weak, nonatomic) IBOutlet UILabel *arrivalTipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureTipsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *arrivalAirLineSepLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrivalFlightSepLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrivalLandingSepLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *departureAirLineSepLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *departureFlightSepLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *departureLandingSepLineImageView;


@end

@implementation LYModifyOrderFlightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.arrivalTipsLabel.hidden = YES;
    self.departureTipsLabel.hidden = YES;
    
    [self.arrivalAirlineTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_7F7F7FColor] conent:@"Airline" font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.arrivalAirlineTextField setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.arrivalAirlineTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.arrivalFligjtNumberTextFlightTextFeild setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_7F7F7FColor] conent:@"Flight  Number" font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.arrivalFligjtNumberTextFlightTextFeild setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.arrivalFligjtNumberTextFlightTextFeild setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.arrivalLandingAirportTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_7F7F7FColor] conent:@"Landing airport" font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.arrivalLandingAirportTextField setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.arrivalLandingAirportTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.arrivalTimeTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_7F7F7FColor] conent:@"Arrival Time" font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.arrivalTimeTextField setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.arrivalTimeTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.departureAirlineTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_7F7F7FColor] conent:@"Airline" font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.departureAirlineTextField setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.departureAirlineTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.departureFlightNumberTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_7F7F7FColor] conent:@"Flight  Number" font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.departureFlightNumberTextField setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.departureFlightNumberTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.departureAirportTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_7F7F7FColor] conent:@"Departure airport" font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.departureAirportTextField setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.departureAirportTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    
    [self.departureTimeTextField setPlaceholderWithColor:[LYTourscoolAPPStyleManager ly_7F7F7FColor] conent:@"Departure  Time" font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.departureTimeTextField setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    [self.departureTimeTextField setTextColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    

    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:kOrderFlightInfoErrorNotificationName object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
             @strongify(self);
//           LYGuideTourDownloadItemModel * model = x.userInfo[@"model"];
        NSString *type = x.userInfo[@"type"];
        NSInteger typeValue = type.integerValue;
        NSString *msg = x.userInfo[@"msg"];
        switch (typeValue) {
            case 1:
                self.arrivalAirLineSepLineImageView.image = [UIImage imageNamed:@"red_sep_line"];
                self.arrivalTipsLabel.hidden = NO;
                self.arrivalTipsLabel.text = msg;
            break;
            case 2:
                self.arrivalFlightSepLineImageView.image = [UIImage imageNamed:@"red_sep_line"];
                self.arrivalTipsLabel.hidden = NO;
                self.arrivalTipsLabel.text = msg;
            break;
            case 3:
                self.arrivalLandingSepLineImageView.image = [UIImage imageNamed:@"red_sep_line"];
                self.arrivalTipsLabel.hidden = NO;
                self.arrivalTipsLabel.text = msg;
            break;
            case 4:
                self.arrivalTipsLabel.hidden = NO;
                self.arrivalTipsLabel.text = msg;
            break;
            case 5:
                self.departureAirLineSepLineImageView.image = [UIImage imageNamed:@"red_sep_line"];
                self.departureTipsLabel.hidden = NO;
                self.departureTipsLabel.text = msg;
            break;
            case 6:
                self.departureFlightSepLineImageView.image = [UIImage imageNamed:@"red_sep_line"];
                self.departureTipsLabel.hidden = NO;
                self.departureTipsLabel.text = msg;
            break;
            case 7:
                self.departureLandingSepLineImageView.image = [UIImage imageNamed:@"red_sep_line"];
                self.departureTipsLabel.hidden = NO;
                self.departureTipsLabel.text = msg;
            break;
            case 8:
                self.departureTipsLabel.hidden = NO;
                self.departureTipsLabel.text = msg;
            break;
                
            default:
                break;
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    
}

- (IBAction)clickArrivalCalButton:(id)sender {
    @weakify(self);
    LYDateView * dateView = [LYDateView loadFromNibWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [dateView customSetPicker];
    [dateView setUserSelectDateBlock:^(NSDate *selectDate) {
          @strongify(self);
          NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
          NSString *dateComponents = @"yMMM d, yyyy h:m aa";//MMM d, yyyy h:m:s aa

          NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:dateComponents options:0 locale:usLocale];
        self.arrivalTimeTextField.text = [LYDateTools dateToStringWithFormatterStr:dateFormat date:selectDate];;
        if (self.delegate && [self.delegate respondsToSelector:@selector(textViewReturnData:type:)]) {
             [self.delegate textViewReturnData:self.arrivalTimeTextField.text type:@"4"];
         }
      }];
      [kWindowRootViewController.view addSubview:dateView];
}

- (IBAction)clickDepartureCalButton:(id)sender {
    @weakify(self);
    LYDateView * dateView = [LYDateView loadFromNibWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [dateView customSetPicker];
    [dateView setUserSelectDateBlock:^(NSDate *selectDate) {
          @strongify(self);
          NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
          NSString *dateComponents = @"yMMM d, yyyy h:m aa";//MMM d, yyyy h:m:s aa

          NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:dateComponents options:0 locale:usLocale];
        self.departureTimeTextField.text = [LYDateTools dateToStringWithFormatterStr:dateFormat date:selectDate];;
        if (self.delegate && [self.delegate respondsToSelector:@selector(textViewReturnData:type:)]) {
            [self.delegate textViewReturnData:self.departureTimeTextField.text type:@"8"];
        }
      }];
      [kWindowRootViewController.view addSubview:dateView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *type = @"0";
    NSString *text = textField.text;
    if (textField == self.arrivalAirlineTextField) {
        type = @"1";
    }else if(textField == self.arrivalFligjtNumberTextFlightTextFeild){
        type = @"2";
    }else if(textField == self.arrivalLandingAirportTextField){
        type = @"3";
    }else if(textField == self.departureAirlineTextField){
        type = @"5";
    }else if(textField == self.departureFlightNumberTextField){
        type = @"6";
    }else if(textField == self.departureAirportTextField){
        type = @"7";
    }
    //同步 数据
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewReturnData:type:)]) {
        [self.delegate textViewReturnData:text type:type];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.arrivalAirLineSepLineImageView.image = [UIImage imageNamed:@"detail_sep_line"];
    self.arrivalFlightSepLineImageView.image = [UIImage imageNamed:@"detail_sep_line"];
    self.arrivalLandingSepLineImageView.image = [UIImage imageNamed:@"detail_sep_line"];
    self.departureAirLineSepLineImageView.image = [UIImage imageNamed:@"detail_sep_line"];
    self.departureFlightSepLineImageView.image = [UIImage imageNamed:@"detail_sep_line"];
    self.departureLandingSepLineImageView.image = [UIImage imageNamed:@"detail_sep_line"];
    self.arrivalTipsLabel.hidden = YES;
    self.departureTipsLabel.hidden = YES;
}

@end
