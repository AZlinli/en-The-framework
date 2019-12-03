//
//  LYDetailCommonSectionHeaderView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailCommonSectionHeaderView.h"

NSString * const LYDetailCommonSectionHeaderViewID = @"LYDetailCommonSectionHeaderViewID";

@interface LYDetailCommonSectionHeaderView()

@end

@implementation LYDetailCommonSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerTitleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.headerTitleLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_16];
}
@end
