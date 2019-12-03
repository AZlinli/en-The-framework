//
//  LYReviewDetailTextTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailTextTableViewCell.h"
#import "LYReviewDetailModel.h"

@interface LYReviewDetailTextTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;
@property(nonatomic, strong) LYReviewDetailModel *model;

@end

@implementation LYReviewDetailTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textContentLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.textContentLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dataDidChange {
    self.model = self.data;
    self.textContentLabel.text = self.model.text;
}
@end
