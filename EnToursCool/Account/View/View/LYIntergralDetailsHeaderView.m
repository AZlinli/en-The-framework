//
//  LYIntergralDetailsHeaderView.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYIntergralDetailsHeaderView.h"
#import <Masonry/Masonry.h>

NSString * const LYIntergralDetailsHeaderViewID = @"LYIntergralDetailsHeaderViewID";
@implementation LYIntergralDetailsHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Detail";
        label.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        label.font = [LYTourscoolAPPStyleManager ly_ArialBold_12];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-4.f);
            make.left.equalTo(self.mas_left).offset(16.f);
        }];
    }
    return self;
}


@end
