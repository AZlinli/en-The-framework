//
//  LYOrderDetailInfoTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOrderDetailInfoTableViewCell.h"
#import "LYOrderDetailInfoModel.h"


NSString * const LYOrderDetailInfoTableViewCellID = @"LYOrderDetailInfoTableViewCellID";
@interface LYOrderDetailInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderSNLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation LYOrderDetailInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    LYOrderDetailInfoModel *model = self.data;
    self.timeLabel.text = model.purchaseTime;
    self.orderSNLabel.text = model.orderNumber;
    self.priceLabel.text = model.price;
}

@end
