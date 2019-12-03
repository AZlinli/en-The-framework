
//
//  LYCancelOrderReasonWithPayedTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/26.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCancelOrderReasonWithPayedTableViewCell.h"

NSString * const LYCancelOrderReasonWithPayedTableViewCellID = @"LYCancelOrderReasonWithPayedTableViewCellID";

@interface LYCancelOrderReasonWithPayedTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *customerButton;

@end

@implementation LYCancelOrderReasonWithPayedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Cancellation and Change Notice"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:[LYTourscoolAPPStyleManager ly_19A8C7Color] range:titleRange];
    [self.customerButton setAttributedTitle:title
                      forState:UIControlStateNormal];
    [self.customerButton.titleLabel setFont:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)clickCustomButton:(id)sender {
    
}

@end
