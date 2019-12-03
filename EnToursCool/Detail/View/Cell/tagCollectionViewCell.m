//
//  tagCollectionViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "tagCollectionViewCell.h"
#import "UIView+XKCornerBorder.h"

@implementation tagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tagTextLabel.xk_openClip = YES;
    self.tagTextLabel.xk_radius = 2;
    self.tagTextLabel.xk_clipType = XKCornerClipTypeAllCorners;
    self.tagTextLabel.xk_openBorder = YES;
    self.tagTextLabel.xk_borderWidth = 1;
    self.tagTextLabel.xk_borderRadius = 2;
    self.tagTextLabel.xk_borderType = XKBorderTypeAllCorners;
    self.tagTextLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_10];
}

- (void)setTagBorderColor:(UIColor *)tagBorderColor {
    _tagBorderColor = tagBorderColor;
    self.tagTextLabel.textColor = self.tagBorderColor;
    self.tagTextLabel.xk_borderColor = self.tagBorderColor;
}
- (void)dataDidChange {
}
@end
