//
//  LYProductListMoreFilterSectionHeader.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/29.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListMoreFilterSectionHeader.h"
#import <Masonry.h>

NSString * const LYProductListMoreFilterSectionHeaderID = @"LYProductListMoreFilterSectionHeaderID";

@interface LYProductListMoreFilterSectionHeader()
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation LYProductListMoreFilterSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithReuseIdentifier:reuseIdentifier];

    if (self) {
        self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [LYTourscoolAPPStyleManager ly_F9F9F9Color];
        view;});
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"3d3d3d"];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(16.f);
        }];

    }
    return self;
}

-(void)dataDidChange{
    NSString *text = self.data;
    self.titleLabel.text = text;
}
@end
