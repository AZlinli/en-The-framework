//
//  LYProductPopTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductPopTableViewCell.h"
#import "LYProductListPopFliterModel.h"


NSString * const LYProductPopTableViewCellID = @"LYProductPopTableViewCellID";
@interface LYProductPopTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LYProductPopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size: 14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    LYProductListPopFliterModel *model = self.data;
    self.titleLabel.text = model.title;
}

@end
