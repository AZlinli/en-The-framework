//
//  LYSettingVCTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYSettingVCTableViewCell.h"
#import <Masonry/Masonry.h>

NSString * const LYSettingVCTableViewCellID = @"LYSettingVCTableViewCellID";

@implementation LYSettingVCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *lockImageView = [[UIImageView alloc] init];
        lockImageView.image = [UIImage imageNamed:@"account_modify_pwd_icon"];
        [self addSubview:lockImageView];
        [lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(20.f);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
        titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        titleLabel.text = @"Change password";
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(lockImageView.mas_right).offset(12.f);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        arrowImageView.image = [UIImage imageNamed:@"right_arrow"];
        [self addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-26.f);
        }];
        
        //line
//        UIImageView *line = [[UIImageView alloc] init];
//        line.image = [UIImage imageNamed:@"detail_sep_line"];
//        [self addSubview:line];
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).offset(16.f);
//            make.right.equalTo(self.mas_right).offset(-16.f);
//            make.height.offset(1.f);
//            make.bottom.equalTo(self.mas_bottom);
//        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end



