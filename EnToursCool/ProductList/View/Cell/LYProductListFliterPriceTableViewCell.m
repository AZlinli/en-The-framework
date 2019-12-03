//
//  LYProductListFliterPriceTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListFliterPriceTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIView+LYHUD.h"
#import "UIView+LYUtil.h"

NSString * const LYProductListFliterPriceTableViewCellID = @"LYProductListFliterPriceTableViewCellID";

@interface LYProductListFliterPriceTableViewCell()<UITextFieldDelegate>

@end

@implementation LYProductListFliterPriceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *priceFlagLabel = [[UILabel alloc] init];
        priceFlagLabel.font = [UIFont fontWithName:@"Arial" size: 16];
        priceFlagLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        priceFlagLabel.text = @"$";
        [self addSubview:priceFlagLabel];
        [priceFlagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(27.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        UITextField *startPriceTextField = [[UITextField alloc] init];
        startPriceTextField.delegate = self;
        startPriceTextField.placeholder = @"0";
        startPriceTextField.returnKeyType = UIReturnKeyDone;
        startPriceTextField.keyboardType = UIKeyboardTypeNumberPad;
        startPriceTextField.borderStyle = UITextBorderStyleRoundedRect;
        startPriceTextField.layer.cornerRadius = 4.f;
        startPriceTextField.textColor = [UIColor colorWithHexString:@"999999"];
        startPriceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        startPriceTextField.layer.borderColor= [UIColor colorWithHexString:@"C7D0D9"].CGColor;
        startPriceTextField.layer.borderWidth= 1.0f;
        [self addSubview:startPriceTextField];
        [startPriceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(90.f);
            make.height.offset(37.f);
            make.left.equalTo(priceFlagLabel.mas_right).offset(8.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        self.startPriceTextField = startPriceTextField;
        
        UIView *priceLine = [[UIView alloc] init];
        priceLine.backgroundColor = [LYTourscoolAPPStyleManager ly_484848Color];
        [self addSubview:priceLine];
        [priceLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(16.f);
            make.height.offset(1.f);
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(startPriceTextField.mas_right).offset(8.f);
        }];
        
        UILabel *priceFlagLabel1 = [[UILabel alloc] init];
        priceFlagLabel1.font = [UIFont fontWithName:@"Arial" size: 16];
        priceFlagLabel1.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        priceFlagLabel1.text = @"$";
        [self addSubview:priceFlagLabel1];
        [priceFlagLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceLine.mas_right).offset(7.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        UITextField *endPriceTextField = [[UITextField alloc] init];
        endPriceTextField.delegate = self;
        endPriceTextField.placeholder = @"0";
        endPriceTextField.returnKeyType = UIReturnKeyDone;
        endPriceTextField.keyboardType = UIKeyboardTypeNumberPad;
        endPriceTextField.borderStyle = UITextBorderStyleRoundedRect;
        endPriceTextField.layer.cornerRadius = 4.f;
        endPriceTextField.textColor = [UIColor colorWithHexString:@"999999"];
        endPriceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        endPriceTextField.layer.borderColor= [UIColor colorWithHexString:@"C7D0D9"].CGColor;
        endPriceTextField.layer.borderWidth= 1.0f;
        [self addSubview:endPriceTextField];
        [endPriceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(90.f);
            make.height.offset(37.f);
            make.left.equalTo(priceFlagLabel1.mas_right).offset(8.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        self.endPriceTextField = endPriceTextField;
        
        UIImageView *sepLine = [[UIImageView alloc] init];
        sepLine.image = [UIImage imageNamed:@"detail_sep_line"];
        [self addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(1.f);
            make.left.equalTo(self.mas_left).offset(16.f);
            make.right.greaterThanOrEqualTo(self.mas_right).offset(-16.f);
            make.top.equalTo(startPriceTextField.mas_bottom).offset(20.f);
        }];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    
}

#pragma make -textFieldShouldReturn

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.endPriceTextField) {
        [textField resignFirstResponder];
        NSString *startPrice = self.startPriceTextField.text;
        NSString *endPrice = self.endPriceTextField.text;
        if (startPrice.integerValue > endPrice.integerValue) {
             [UIView showMSGCenterHUDWithView:self.viewController.view msg:@"Price input error"]; // todo msg
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.startPriceTextField) {
        [self.endPriceTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


@end
