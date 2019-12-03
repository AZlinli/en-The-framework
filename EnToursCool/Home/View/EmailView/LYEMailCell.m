//
//  LYEMailCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYEMailCell.h"
#import "LYHomeSendEmailModel.h"
#import "UILabel+Extension.h"


@interface LYEMailCell()
@property (weak, nonatomic) IBOutlet UILabel *bigTitle;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UITextField *emailTxd;
@property (nonatomic, strong) LYHomeSendEmailModel *sendEmailM;

@end

@implementation LYEMailCell

#pragma mark - life
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backView.layer.borderColor = [LYTourscoolAPPStyleManager ly_E4E4E4CColor].CGColor;
    self.subTitle.font = [LYTourscoolAPPStyleManager ly_ArialRegular_15];
    self.backView.layer.borderWidth = 1;
    self.backView.layer.cornerRadius = 4.f;
    self.backView.layer.masksToBounds = YES;
    
    [[self.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //关闭邮件View
        [[NSNotificationCenter defaultCenter] postNotificationName:kCloseEmailViewNotificationIdentifier object:nil userInfo:nil];
    }];
    [[self.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
}

- (void)dataDidChange
{
    self.sendEmailM = self.data;
    self.subTitle.text = self.sendEmailM.subTitle;
    [self.subTitle changeLineSpace:2];
}


@end
