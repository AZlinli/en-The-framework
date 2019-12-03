//
//  UIButton+LYStyle.m
//  ToursCool
//
//  Created by tourscool on 10/10/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "UIButton+LYStyle.h"


@implementation UIButton (LYStyle)

- (void)ly_setButtonTitleFont:(UIFont *)font titleColor:(UIColor *)titleColor state:(UIControlState)state
{
    [self setTitleColor:titleColor forState:state];
    self.titleLabel.font = font;
}

@end
