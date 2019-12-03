//
//  LYLoadingView.m
//  ToursCool
//
//  Created by tourscool on 4/17/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYLoadingView.h"

#import <Masonry/Masonry.h>
static CGFloat LoadingViewWidth = 100.f;
@implementation LYLoadingView
{
    CAShapeLayer * _shapeLayerA;
    CAShapeLayer * _shapeLayerB;
    CAShapeLayer * _shapeLayerC;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    if (self = [super init]) {
        [self addThreeShapeLayer];
    }
    return self;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(LoadingViewWidth, LoadingViewWidth);
}

- (void)addThreeShapeLayer
{
    CAShapeLayer * shapeLayerB = [CAShapeLayer layer];
    shapeLayerB.bounds = CGRectMake(0, 0, 20.f, 20.f);
    shapeLayerB.position = CGPointMake(90.f, 50.f);
    shapeLayerB.backgroundColor = [UIColor colorWithRed:57/255.0 green:158/255.0 blue:246/255.0 alpha:0.6].CGColor;
    shapeLayerB.cornerRadius = 10.f;
    _shapeLayerC = shapeLayerB;
    [self.layer addSublayer:shapeLayerB];
    [self addAnimationWithLayer:shapeLayerB type:3];
    
    CAShapeLayer * shapeLayerA = [CAShapeLayer layer];
    shapeLayerA.bounds = CGRectMake(0, 0, 20.f, 20.f);
    shapeLayerA.position = CGPointMake(50.f, 50.f);
    shapeLayerA.backgroundColor = [UIColor colorWithRed:57/255.0 green:158/255.0 blue:246/255.0 alpha:1.0].CGColor;
    shapeLayerA.cornerRadius = 10.f;
    [self.layer addSublayer:shapeLayerA];
    _shapeLayerB = shapeLayerA;
    [self addAnimationWithLayer:shapeLayerA type:2];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = CGRectMake(0, 0, 20.f, 20.f);
    shapeLayer.position = CGPointMake(10.f, 50.f);
    shapeLayer.backgroundColor = [UIColor colorWithRed:57/255.0 green:158/255.0 blue:246/255.0 alpha:0.6].CGColor;
    shapeLayer.cornerRadius = 10.f;
    [self.layer addSublayer:shapeLayer];
    [self addAnimationWithLayer:shapeLayer type:1];
    _shapeLayerA = shapeLayer;
    
}

- (void)addAnimationWithLayer:(CAShapeLayer *)shapeLayer type:(NSInteger)type
{
    if (type == 1) {
        CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
        animaGroup.duration = 1.5f;
        animaGroup.autoreverses = YES;
        animaGroup.fillMode = kCAFillModeForwards;
        animaGroup.removedOnCompletion = NO;
        animaGroup.repeatCount = HUGE_VALF;
        animaGroup.animations = @[[self translationXAnimationWithType:type], [self scaleKeyAnimationWithType:type]];
        [shapeLayer addAnimation:animaGroup forKey:@"animaGroupA"];
    }else if (type == 2) {
        [shapeLayer addAnimation:[self scaleAnimationWithType:type] forKey:nil];
    }else if (type == 3) {
        CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
        animaGroup.duration = 1.5f;
        animaGroup.autoreverses = YES;
        animaGroup.fillMode = kCAFillModeForwards;
        animaGroup.removedOnCompletion = NO;
        animaGroup.repeatCount = HUGE_VALF;
        animaGroup.animations = @[[self translationXAnimationWithType:type], [self scaleKeyAnimationWithType:type]];
        [shapeLayer addAnimation:animaGroup forKey:@"animaGroupB"];
    }
}

- (CABasicAnimation *)translationXAnimationWithType:(NSInteger)type
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    if (type == 2) {
        scaleAnimation.duration = 2.f;
        scaleAnimation.autoreverses = YES;
        scaleAnimation.repeatCount = HUGE_VALF;
    }
    if (type == 1) {
        scaleAnimation.fromValue = @(0);
        scaleAnimation.toValue = @(70);
        [scaleAnimation setValue:@"TransformTranslationXA" forKey:@"TransformTranslationXA"];
    }else{
        scaleAnimation.fromValue = @(0);
        scaleAnimation.toValue = @(-70);
        [scaleAnimation setValue:@"TransformTranslationXAB" forKey:@"TransformTranslationXAB"];
    }
    return scaleAnimation;
}

- (CAKeyframeAnimation *)scaleKeyAnimationWithType:(NSInteger)type
{
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@(1),@(0.7),@(1)];
    [scaleAnimation setValue:@"ScaleKeyframeAnimation" forKey:@"ScaleKeyframeAnimation"];
    return scaleAnimation;
}

- (CABasicAnimation *)scaleAnimationWithType:(NSInteger)type
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    if (type == 2) {
        scaleAnimation.duration = 1.5f;
        scaleAnimation.autoreverses = YES;
        scaleAnimation.repeatCount = HUGE_VALF;
    }
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = @(1);
    scaleAnimation.toValue = @(0.7);
    [scaleAnimation setValue:@"scaleAnimation" forKey:@"scaleAnimation"];
    return scaleAnimation;
}

@end
