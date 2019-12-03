//
//  UIView+Extension.h
//  farmlink
//
//  Created by ldl on 15/11/9.
//  Copyright © 2015年 farmlink. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint orgin;
@property (nonatomic, assign) CGSize size;



- (NSString *)getNametag;

- (void)setNametag:(NSString *)theNametag;

- (UIView *)viewNamed:(NSString *)aName;

/**
 圆特定的角

 @param rectCorner 传入上下左右type
 @param size 传入需要圆角的尺寸
 */
- (void)boundRect:(UIRectCorner)rectCorner cornerRadii:(CGSize)size;

/**
 添加阴影

 @param radius 阴影半径
 */
- (void)addShadowWithRadius:(CGFloat)radius;

/**
 同时添加圆角和阴影

 @param radius 阴影半径
 @param circleR 圆角半径
 */
- (void)addShadowWithRadius:(CGFloat)radius cornerRadius:(CGFloat)circleR;

/**
 添加渐变Img

 @param colorArray 颜色数组
 @param gradientType 渐变样式
 */
- (void)addGradientImgWithColorArry:(NSMutableArray *)colorArray ByGradientType:(GradientType)gradientType;

@end
