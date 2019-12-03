//
//  UIButton+LYTourscoolSetImage.m
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "UIButton+LYTourscoolSetImage.h"
#import "UIColor+PXColors.h"
#import "UIImage+LYUtil.h"
@implementation UIButton (LYTourscoolSetImage)

- (void)setButtonImageName:(NSString *)imageName forState:(UIControlState)controlState
{
//    [self setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:controlState];
    [self setImage:[UIImage imageNamed:imageName] forState:controlState];
}

- (void)setButtonImageHexColorName:(NSString *)hexColorName forState:(UIControlState)controlState
{
    [self setImage:[UIImage imageTintedWithColor:[UIColor colorWithHexString:hexColorName] toSize:self.frame.size] forState:controlState];
}

@end
