//
//  UIView+LYUtil.m
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import "UIView+LYUtil.h"
@implementation UIView (LYUtil)
@dynamic viewController;

- (UIViewController *)viewController
{
    UIViewController *viewController=nil;
    UIView* next = [self superview];
    UIResponder *nextResponder = [next nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        viewController = (UIViewController *)nextResponder;
    }else{
        viewController = [next viewController];
    }
    return viewController;
}

@dynamic cornerRadius, boardColor, borderWidth;

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBoardColor:(UIColor *)boardColor
{
    self.layer.borderColor = boardColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (void)setViewTopShadow
{
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, -5);
    self.layer.shadowOpacity = 0.3;
}

- (void)setViewBottomShadow
{
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.shadowOpacity = 0.3;
}

//左右抖动动画
- (void)addViewAnimation{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-5];
    shake.toValue = [NSNumber numberWithFloat:5];
    shake.duration = 0.1;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 2;//次数
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    self.alpha = 1.0;
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
    } completion:nil];
}

@end
