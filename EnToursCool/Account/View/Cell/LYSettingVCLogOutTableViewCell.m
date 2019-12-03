//
//  LYSettingVCLogOutTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYSettingVCLogOutTableViewCell.h"
#import <Masonry/Masonry.h>

NSString * const LYSettingVCLogOutTableViewCellID = @"LYSettingVCLogOutTableViewCellID";

@implementation LYSettingVCLogOutTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Sign out";
        label.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
        label.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button.backgroundColor = [UIColor colorWithHexString:@"EC6564"];
    //    button.layer.cornerRadius = 19.f;
    //    [button setTitle:@"" forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor colorWithHexString:@"f9f9f9"] forState:UIControlStateNormal];
    //    button.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    //    [button addTarget:self action:@selector(clickLogOutButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [view addSubview:button];
    //    [button mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(view.mas_left).offset(16.f);
    //        make.right.equalTo(view.mas_right).offset(-16.f);
    //        make.centerY.equalTo(view.mas_centerY);
    //        make.height.offset(37.f);
    //    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
