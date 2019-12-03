//
//  UIButton+LYTourscoolSetImage.h
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYTourscoolSetImage)
/**
 设置按钮图片

 @param imageName 图片名字
 @param controlState 状态
 */
- (void)setButtonImageName:(NSString *)imageName forState:(UIControlState)controlState;
/**
 设置按钮图片 颜色

 @param hexColorName ex:999999
 @param controlState 状态
 */
- (void)setButtonImageHexColorName:(NSString *)hexColorName forState:(UIControlState)controlState;
@end

NS_ASSUME_NONNULL_END
