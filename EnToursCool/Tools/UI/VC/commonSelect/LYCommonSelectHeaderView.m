//
//  LYCommonSelectHeaderView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCommonSelectHeaderView.h"

@interface LYCommonSelectHeaderView()
/**name*/
@property(nonatomic, strong) UILabel *titleLabel;
/**title*/
@property(nonatomic, copy) NSString *title;
@end

@implementation LYCommonSelectHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [LYTourscoolAPPStyleManager ly_F9F9F9Color];
        [self setUI];
    }
    return self;
}

- (void)dataDidChange {
    self.title = self.data;
    self.titleLabel.text = self.title;
}

- (void)setUI {
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.backgroundColor = [LYTourscoolAPPStyleManager ly_F9F9F9Color];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(28);
        make.right.mas_equalTo(-16);
    }];
    titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    titleLabel.textColor = [LYTourscoolAPPStyleManager ly_3D3D3DColor];
    self.titleLabel = titleLabel;
}
@end
