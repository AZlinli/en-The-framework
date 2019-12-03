//
//  LYIntegralDetailsInfoTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYIntegralDetailsInfoTableViewCell.h"
#import "UIView+LYUtil.h"
#import "LYIntegralDetailsViewModel.h"

NSString * const LYIntegralDetailsInfoTableViewCellID = @"LYIntegralDetailsInfoTableViewCellID";

@interface LYIntegralDetailsInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *receivedLabel;
@property (weak, nonatomic) IBOutlet UILabel *pendingLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation LYIntegralDetailsInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    LYIntegralDetailsInfoModel *model = self.data;
    self.totalLabel.text = model.total;
    self.receivedLabel.text = model.received;
    self.moneyLabel.text = model.receviedMoney;
    self.pendingLabel.text = model.pending;
}

- (IBAction)clickAboutButton:(id)sender {
    
}

@end
