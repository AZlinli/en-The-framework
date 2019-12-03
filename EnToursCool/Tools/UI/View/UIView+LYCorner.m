//
//  UIView+LYCorner.m
//  ToursCool
//
//  Created by tourscool on 10/25/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "UIView+LYCorner.h"

static const char kLYViewAddRadiusShadow;

@implementation UIView (LYCorner)

@dynamic addRadiusShadow;

- (void)setAddRadiusShadow:(BOOL)addRadiusShadow
{
    objc_setAssociatedObject(self, &kLYViewAddRadiusShadow, @(addRadiusShadow), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addRadiusShadow
{
    return [objc_getAssociatedObject(self, &kLYViewAddRadiusShadow) boolValue];
}

- (void)circularCouponsTopRect:(CGRect)topRect bottomRect:(CGRect)bottomRect
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(6.f, 6.f)];
//    CGFloat x = CGRectGetMinX(self.frame);
    CGFloat y = CGRectGetMinY(self.frame);
    
//    [path moveToPoint:CGPointMake(x, y)];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(topRect)/2.f + CGRectGetMinX(topRect), CGRectGetMinY(topRect)) radius:CGRectGetWidth(topRect)/2.f startAngle:M_PI endAngle:0.f clockwise:NO];
    
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(bottomRect)/2.f + CGRectGetMinX(bottomRect), y) radius:CGRectGetWidth(bottomRect)/2.f startAngle:M_PI endAngle:0.f clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.frame = self.bounds;
    self.layer.mask = shapeLayer;
}

- (void)circularBeadAndShadowWithRectCorner:(UIRectCorner)rectCorner
                                cornerRadii:(CGSize)cornerRadii
                                shadowColor:(UIColor *)shadowColor
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                           byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.frame = self.bounds;
    shapeLayer.bounds = self.bounds;
    self.layer.mask = shapeLayer;
}

- (void)circularBeadWithRectCorner:(UIRectCorner)rectCorner
                       cornerRadii:(CGSize)cornerRadii
{
    [self circularBeadAndShadowWithRectCorner:rectCorner cornerRadii:cornerRadii shadowColor:nil];
}

- (void)cancelRectCorner
{
    self.layer.mask = nil;
}

- (void)ly_drawLeftInnerSemicircleAndRightOuterSemicircleWithRadius:(CGFloat)radius
{
    CGRect rect = self.frame;
    CGFloat widht = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(widht-radius, 0)];
//    [path addLineToPoint:CGPointMake(widht-radius, height/2.f)];
    [path addArcWithCenter:CGPointMake(widht-radius, height/2.f) radius:radius startAngle:1.5*M_PI endAngle:0.5*M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(widht-radius, height)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path addArcWithCenter:CGPointMake(0, height/2.f) radius:radius startAngle:0.5*M_PI endAngle:1.5*M_PI clockwise:NO];
    [path addLineToPoint:CGPointMake(0, 0)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.frame = self.bounds;
    self.layer.mask = shapeLayer;
}

- (void)applyRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *temp = [CAShapeLayer layer];
    temp.lineWidth = 1.f;
    temp.fillColor = [UIColor clearColor].CGColor;
    temp.strokeColor = [UIColor colorWithHexString:@"DCDCDC"].CGColor;
    temp.frame = self.bounds;
    temp.path = path.CGPath;
    [self.layer addSublayer:temp];
    
    CAShapeLayer *mask = [[CAShapeLayer alloc] initWithLayer:temp];
    mask.path = path.CGPath;
    self.layer.mask = mask;
}

- (void)applyRoundCorners1:(UIRectCorner)corners radius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *temp = [CAShapeLayer layer];
    temp.lineWidth = 1.f;
    temp.fillColor = [UIColor clearColor].CGColor;
    temp.strokeColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
    temp.frame = self.bounds;
    temp.path = path.CGPath;
    [self.layer addSublayer:temp];
    
    CAShapeLayer *mask = [[CAShapeLayer alloc] initWithLayer:temp];
    mask.path = path.CGPath;
    self.layer.mask = mask;
}

- (void)applyRoundCornersDetail:(UIRectCorner)corners radius:(CGFloat)radius{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *temp = [CAShapeLayer layer];
    temp.lineWidth = 1.f;
    temp.fillColor = [UIColor whiteColor].CGColor;
    temp.strokeColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
    temp.frame = self.bounds;
    temp.path = path.CGPath;
    
    temp.shadowColor = [LYTourscoolAPPStyleManager ly_343434ColorAlpha:0.15f].CGColor;
       
   temp.shadowOffset = CGSizeMake(0.f, 1.f);
   temp.shadowOpacity = 1;
   temp.shadowRadius = 10.f;
   temp.shadowPath = path.CGPath;

    [self.layer insertSublayer:temp atIndex:0];
     self.clipsToBounds = NO;
}

- (void)applyViewRectBorder
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    CAShapeLayer *temp = [CAShapeLayer layer];
    temp.lineWidth = 1.f;
    temp.fillColor = [UIColor clearColor].CGColor;
    temp.strokeColor = [UIColor colorWithHexString:@"DCDCDC"].CGColor;
    temp.frame = self.bounds;
    temp.path = path.CGPath;
    [self.layer addSublayer:temp];
    
    CAShapeLayer *mask = [[CAShapeLayer alloc] initWithLayer:temp];
    mask.path = path.CGPath;
    self.layer.mask = mask;
}

- (void)addShadowPath
{
    [self addShadowPathWithCornerRadius:24.f];
}

- (void)addShadowPathWithCornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *shadowPath = nil;
    if (cornerRadius) {
        shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    }else{
        shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // width -> x height -> y
    self.layer.shadowOffset = CGSizeMake(0.f, 2.f);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 2.f;
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)ly_viewAddShadowPathWithCornerRadius:(CGFloat)cornerRadius
                                 shadowColor:(UIColor *)shadowColor
                                shadowOffset:(CGSize)shadowOffset
                               shadowOpacity:(CGFloat)shadowOpacity
                                shadowRadius:(CGFloat)shadowRadius
{
    if (self.addRadiusShadow) {
        return;
    }
    UIBezierPath *shadowPath = nil;
    UIBezierPath *cornerRadiusPath = nil;
    if (cornerRadius) {
        shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
        cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:cornerRadius];
    }else{
        shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
        cornerRadiusPath = [UIBezierPath bezierPathWithRect:self.frame];
    }
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = shadowPath.CGPath;
    layer.cornerRadius = cornerRadius;
    layer.shadowColor = shadowColor.CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    layer.shadowOffset = shadowOffset;
    layer.shadowOpacity = shadowOpacity;
    layer.shadowRadius = shadowRadius;
    layer.shadowPath = shadowPath.CGPath;

    [self.layer insertSublayer:layer atIndex:0];
    self.clipsToBounds = NO;
    self.addRadiusShadow = YES;
}

- (void)ly_ignoreRepeatedlyAddShadowPathWithCornerRadius:(CGFloat)cornerRadius
                                             shadowColor:(UIColor *)shadowColor
                                            shadowOffset:(CGSize)shadowOffset
                                           shadowOpacity:(CGFloat)shadowOpacity
                                            shadowRadius:(CGFloat)shadowRadius
{
    UIBezierPath *shadowPath = nil;
    if (cornerRadius) {
        shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    }else{
        shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowPath = shadowPath.CGPath;
}

@end
