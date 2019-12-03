//
//  LYAccountTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYAccountTableViewCell.h"
#import "LYAccountItemModel.h"

NSString * const LYAccountTableViewCellID = @"LYAccountTableViewCellID";

@interface LYAccountTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation LYAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    LYAccountItemModel *model = self.data;

    self.iconImageView.image = [UIImage imageNamed:model.image];
    self.titleLabel.text = model.title;
    
}

@end
