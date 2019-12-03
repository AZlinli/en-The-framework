//
//  UIButton+LYStyle.h
//  ToursCool
//
//  Created by tourscool on 10/10/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYStyle)

- (void)ly_setButtonTitleFont:(UIFont *)font titleColor:(UIColor *)titleColor state:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
