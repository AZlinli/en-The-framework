//
//  NSString+LYSize.h
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (LYSize)
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

+ (NSString *)reverseString:(NSString *)strSrc;

//计算text的高度(带有行间距的情况)
- (CGFloat)getSpaceHeightWithFont:(UIFont *)font Width:(CGFloat)width space:(CGFloat)space;

@end
