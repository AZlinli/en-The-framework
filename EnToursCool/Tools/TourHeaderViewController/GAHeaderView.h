//
//  GAHeaderView.h
//  GAIA供应
//
//  Created by  GAIA on 2017/9/20.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击btn回调的block
typedef void(^titleBtnClick)(NSUInteger tag);
@interface GAHeaderView : UIView

/**
 返回一个全局的头条（可点击滑动）
 @param titleH 标题栏高度
 @param width 标题栏宽度
 @param titleArr 数组
 @param titleColor 默认字体颜色
 @param titleSelectColor 选中字体颜色
 @param lineColor 下划线颜色
 @param clickBlock 点击btn的回调
 @return 返回一个UIview类
 */
- (instancetype)initWithTitleH:(CGFloat)titleH headWidth:(CGFloat)width arr:(NSArray *)titleArr titleColor:(UIColor *)titleColor titleSelectColor:(UIColor *)titleSelectColor lineColor:(UIColor *)lineColor titleBlock:(titleBtnClick)clickBlock;

/**
 返回一个全局的头条（可点击滑动）
 @param titleH 标题栏高度
 @param width 标题栏宽度
 @param titleArr 数组
 @param titleColor 默认字体颜色
 @param titleSelectColor 选中字体颜色
 @param lineColor 下划线颜色
 @param clickBlock 点击btn的回调
 @return 返回一个UIview类
 */
+ (instancetype)headerWithTitleH:(CGFloat)titleH headWidth:(CGFloat)width arr:(NSArray *)titleArr titleColor:(UIColor *)titleColor titleSelectColor:(UIColor *)titleSelectColor lineColor:(UIColor *)lineColor titleBlock:(titleBtnClick)clickBlock;

/**
 让第几个按钮选中

 @param index 序号
 */
- (void)selectAtIndex:(NSUInteger)index;

/**
 清除头部bar
 */
- (void)clearHeadTag;

@end
