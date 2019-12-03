//
//  LYIntegralDetailsItemTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYIntegralDetailsItemTableViewCell.h"
#import "LYIntegralDetailsModel.h"

NSString * const LYIntegralDetailsItemTableViewCellID = @"LYIntegralDetailsItemTableViewCellID";

@interface LYIntegralDetailsItemTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation LYIntegralDetailsItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dataDidChange{
    LYIntegralDetailsModel *model = self.data;
    self.titleLabel.text = model.title;
    self.dateLabel.text = model.date;
    self.numberLabel.text = model.number;
    self.descLabel.text = model.desc;
    switch (model.status) {
        case IntegralDetailsStatus_Get:
            self.numberLabel.textColor = [UIColor colorWithHexString:@"5BC786"];
            break;
          case IntegralDetailsStatus_Pay:
            self.numberLabel.textColor = [UIColor colorWithHexString:@"EC6564"];
            break;
            case IntegralDetailsStatus_Pending:
            self.numberLabel.textColor = [UIColor colorWithHexString:@"FE7235"];
            break;
        default:
            break;
    }
  
}

@end
