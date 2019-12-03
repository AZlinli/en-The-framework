//
//  LYOrderMainCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOrderMainCell.h"

NSString *const LYOrderMainCellID = @"LYOrderMainCellID";
@interface LYOrderMainCell()
@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *adultLabel;
@property (weak, nonatomic) IBOutlet UILabel *childLabel;

@end

@implementation LYOrderMainCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.dateLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_12];
    self.dateLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.detailTitle.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.detailTitle.textColor = [LYTourscoolAPPStyleManager ly_7E7E7EColor];
    self.priceLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_16];
    self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_EC6564Color];
    self.adultLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.adultLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.childLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.childLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}


@end
