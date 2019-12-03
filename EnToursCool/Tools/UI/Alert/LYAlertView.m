//
//  LYAlertViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYAlertView.h"
#import <Masonry/Masonry.h>



@interface LYAlertView ()

@property(nonatomic, strong) UIView *coverView;
@property(nonatomic, strong) UIView *alerView;
@end

@implementation LYAlertView

-(void)alertViewControllerWithMessage:(NSString *)message title:(NSString*)title leftButtonTitle:(NSString*)leftButtonTitle rightButtonTitle:(NSString*)rightButtonTitle{
    self.userInteractionEnabled = YES;
    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.75f;
    self.coverView = coverView;
    [self addSubview:coverView];
    
    UIView *alertView = [[UIView alloc] init];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 8.f;
    self.alerView = alertView;
    alertView.center = coverView.center;
    [self addSubview:alertView];
    alertView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.8, 135.f);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [alertView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 12];
    titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 20.f, alertView.bounds.size.width, 20.f);
    
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    msgLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    msgLabel.text = message;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.numberOfLines = 2;
    [alertView addSubview:msgLabel];
    CGFloat margin = 25;
    CGFloat msgX = margin;
    CGFloat msgY = titleLabel.frame.size.height + 18;
    CGFloat msgW = alertView.bounds.size.width - 2 * margin;
    CGFloat msgH = 44;
    msgLabel.frame = CGRectMake(msgX, msgY, msgW, msgH);
    
    CGFloat buttonWidth = 80;
    CGFloat buttonHigth = 26;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [alertView addSubview:cancelButton];
    [cancelButton setTitle:leftButtonTitle forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"19A8C7"] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.layer.cornerRadius = 13.f;
    cancelButton.layer.borderColor = [UIColor colorWithHexString:@"19A8C7"].CGColor;
    cancelButton.layer.borderWidth = 1.f;
    cancelButton.frame = CGRectMake(55, alertView.bounds.size.height - margin - buttonHigth, buttonWidth, buttonHigth);
    cancelButton.tag = 0;
    [cancelButton addTarget:self action:@selector(didClickBtnConfirm:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [alertView addSubview:confirmButton];
    [confirmButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.backgroundColor = [UIColor colorWithHexString:@"19A8C7"];
    confirmButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    confirmButton.layer.cornerRadius = 13.f;
    confirmButton.tag = 1;
    confirmButton.frame = CGRectMake(alertView.bounds.size.width - 55 - buttonWidth, alertView.bounds.size.height - margin - buttonHigth, buttonWidth, buttonHigth);
    [confirmButton addTarget:self action:@selector(didClickBtnConfirm:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didClickBtnConfirm:(UIButton *)sender{
    if (sender.tag == 0) {
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self removeFromSuperview];
        return;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(clickConfirmButton)]) {
        [self.delegate clickConfirmButton];
    }
    [self removeFromSuperview];
}

- (void)dealloc{
    
}

@end
