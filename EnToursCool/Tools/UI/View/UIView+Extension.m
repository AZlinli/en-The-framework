//
//  UIView+Extension.m
//  farmlink
//
//  Created by ldl on 15/11/9.
//  Copyright © 2015年 farmlink. All rights reserved.
//

#import "UIView+Extension.h"

#import <objc/runtime.h>

static char nametag_key;

@implementation UIView (Extension)
#pragma mark - setter
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setX:(CGFloat)x
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}

- (void)setY:(CGFloat)y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y  = y;
    self.frame = tempFrame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = CGRectStandardize(frame);
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = CGRectStandardize(frame);
}

- (void)setHeight:(CGFloat)height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}

- (void)setOrgin:(CGPoint)orgin
{
    CGRect frame = self.frame;
    frame.origin = orgin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

#pragma mark - getter
- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGPoint)orgin
{
    return self.frame.origin;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setNametag:(NSString *)theNametag {
    objc_setAssociatedObject(self, &nametag_key, theNametag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)getNametag {
    return objc_getAssociatedObject(self, &nametag_key);
}


- (UIView *)viewWithNameTag:(NSString *)aName {
    if (!aName) return nil;
    
    // Is this the right view?
    if ([[self getNametag] isEqualToString:aName])
        return self;
    // Recurse depth first on subviews;
    for (UIView *subview in self.subviews) {
        UIView *resultView = [subview viewNamed:aName];
        if (resultView) return  resultView;
    }
    // Not found
    return nil;
}
- (UIView *)viewNamed:(NSString *)aName {
    if (!aName) return nil;
    return [self viewWithNameTag:aName];
}

- (void)boundRect:(UIRectCorner)rectCorner cornerRadii:(CGSize)size
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addShadowWithRadius:(CGFloat)radius
{
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.5].CGColor;
    self.layer.shadowOpacity = .6;
}

- (void)addShadowWithRadius:(CGFloat)radius cornerRadius:(CGFloat)circleR
{
    CALayer *layer = [CALayer layer];
    layer.frame = self.frame;
    layer.backgroundColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 1);
    layer.shadowOpacity = 0.5;
    layer.shadowRadius = radius;
    layer.cornerRadius = 4.0f;
    [self.superview.layer insertSublayer:layer atIndex:0];
    self.layer.cornerRadius = circleR;
    self.layer.masksToBounds = YES;
}

- (void)addGradientImgWithColorArry:(NSMutableArray *)colorArray ByGradientType:(GradientType)gradientType
{
    UIImage *backImage = [self buttonImageFromColors:colorArray ByGradientType:gradientType];
    UIImageView *imv = [[UIImageView alloc]initWithImage:backImage];
    imv.frame = self.bounds;
    [self insertSubview:imv atIndex:0];
}

- (UIImage*) buttonImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, self.frame.size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(self.frame.size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(self.frame.size.width, self.frame.size.height);
            break;
        case 3:
            start = CGPointMake(self.frame.size.width, 0.0);
            end = CGPointMake(0.0, self.frame.size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}



@end
