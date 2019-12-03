//
//  NSObject+LYCalculatedHeightWidth.h
//  ToursCool
//
//  Created by Lin Li on 2019/11/7.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LYCalculatedHeightWidth)

/// 根据固定高度得到宽度
/// @param text 文字内容
/// @param height 固定高度
/// @param font 字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font;


/// 根据固定宽度得到高度
/// @param text 文字内容
/// @param width 固定宽度
/// @param font 字体大小
- (CGFloat)getHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
