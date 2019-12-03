//
//  UILabel+LYTools.h
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LYTools)
/**
 设置label文字 间距

 @param text 文字
 @param lineSpacing 间距
 */
- (void)setLabelText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;
/**
 设置label间距

 @param lineSpacing 间距
 */
- (void)setLabelLineSpacing:(CGFloat)lineSpacing;

- (void)setLabelFont:(UIFont *)font textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
