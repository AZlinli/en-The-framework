//
//  LYShareTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYShareTableViewCell.h"
#import "LYShareModel.h"


NSString * const LYShareTableViewCellID = @"LYShareTableViewCellID";

@interface LYShareTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LYShareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_14];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    LYShareModel *model = self.data;
    self.iconImageView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.name;
}

@end
