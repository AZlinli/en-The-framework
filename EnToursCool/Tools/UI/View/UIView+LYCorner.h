//
//  UIView+LYCorner.h
//  ToursCool
//
//  Created by tourscool on 10/25/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYCorner)

@property (nonatomic, assign) BOOL addRadiusShadow;

/**
 任意圆角

 @param rectCorner UIRectCorner
 @param cornerRadii CGSize
 */
- (void)circularBeadWithRectCorner:(UIRectCorner)rectCorner
                       cornerRadii:(CGSize)cornerRadii;
- (void)cancelRectCorner;
- (void)applyRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;
- (void)applyViewRectBorder;

/**
 添加阴影
 */
- (void)addShadowPath;
- (void)addShadowPathWithCornerRadius:(CGFloat)cornerRadius;
- (void)ly_drawLeftInnerSemicircleAndRightOuterSemicircleWithRadius:(CGFloat)radius;

- (void)circularCouponsTopRect:(CGRect)topRect bottomRect:(CGRect)bottomRect;

- (void)ly_viewAddShadowPathWithCornerRadius:(CGFloat)cornerRadius
                                 shadowColor:(UIColor *)shadowColor
                                shadowOffset:(CGSize)shadowOffset
                               shadowOpacity:(CGFloat)shadowOpacity
                                shadowRadius:(CGFloat)shadowRadius;
- (void)ly_ignoreRepeatedlyAddShadowPathWithCornerRadius:(CGFloat)cornerRadius
                                             shadowColor:(UIColor *)shadowColor
                                            shadowOffset:(CGSize)shadowOffset
                                           shadowOpacity:(CGFloat)shadowOpacity
                                            shadowRadius:(CGFloat)shadowRadius;

- (void)applyRoundCornersDetail:(UIRectCorner)corners radius:(CGFloat)radius;
- (void)applyRoundCorners1:(UIRectCorner)corners radius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
