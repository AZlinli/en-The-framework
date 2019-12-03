//
//  UIView+LYUtil.h
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYUtil)
@property (nonatomic,readonly) UIViewController *viewController;

@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic,strong) IBInspectable UIColor *boardColor;
@property (nonatomic,assign) IBInspectable CGFloat borderWidth;
- (void)setViewTopShadow;
- (void)setViewBottomShadow;

//左右抖动动画
- (void)addViewAnimation;
@end
