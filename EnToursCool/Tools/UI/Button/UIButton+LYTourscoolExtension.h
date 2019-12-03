//
//  UIButton+LYTourscoolExtension.h
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LYImagePosition) {
    LYImagePositionLeft = 1,              //图片在左，文字在右，默认
    LYImagePositionRight = 2,             //图片在右，文字在左
    LYImagePositionTop = 3,               //图片在上，文字在下
    LYImagePositionBottom = 4,            //图片在下，文字在上
};
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYTourscoolExtension)
@property(nonatomic, strong) IBInspectable UIImage *rightImage;

@property(nonatomic, strong) IBInspectable UIImage *topImage;

@property(nonatomic, strong) IBInspectable UIColor *backgroundColorAtNormal;

@property(nonatomic, assign) IBInspectable BOOL txtColor;

@property(nonatomic,assign) IBInspectable NSInteger buttonEdgeInsetsstyle;
/**
 *  扩大整个按钮的大小
 */
@property (nonatomic,assign,readwrite) IBInspectable CGFloat enlargeEdge;
@property(nonatomic, assign) IBInspectable CGFloat space;
/**
 *   @brief  行间距
 */
@property(nonatomic, assign) IBInspectable CGFloat lineSpacing;
- (void)setImagePosition:(LYImagePosition)postion spacing:(CGFloat)spacing;

/**
 *  @brief 按需扩大按钮大小
 *
 *  @param topEdge    上边距
 *  @param rightEdge  右边距
 *  @param bottomEdge 下边距
 *  @param leftEdge   左边距
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)topEdge
                        right:(CGFloat)rightEdge
                       bottom:(CGFloat)bottomEdge
                         left:(CGFloat)leftEdge;
- (void)buttonTitleCenter;
@end

NS_ASSUME_NONNULL_END
