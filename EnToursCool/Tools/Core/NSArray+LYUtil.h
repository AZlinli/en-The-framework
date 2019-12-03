//
//  NSArray+LYUtil.h
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LYUtil)
/**
 *  @brief  是否为array
 *
 *  @param obj 范型
 *
 *  @return 布尔
 */
+ (BOOL)isArray:(id)obj;

/**
 *  @brief  是否为array并且是否为空
 *
 *  @param obj 范型
 *
 *  @return 布尔
 */
+ (BOOL)isEmpty:(id)obj;

/**
 *  @brief 是否为空
 *
 *  @return 是否为空
 */
- (BOOL)isEmpty;

/**
 *  防止数组越界
 */
- (id)objectAt:(NSUInteger)index;
/**
 去除数组重复

 @return 数组
 */
- (NSArray *)removeDuplicate;

@end
