//
//  NSObject+LYCalculatedHeightWidth.m
//  ToursCool
//
//  Created by Lin Li on 2019/11/7.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "NSObject+LYCalculatedHeightWidth.h"

@implementation NSObject (LYCalculatedHeightWidth)
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font {
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.width;
}

//根据宽度求高度  text 计算的内容  width 计算的宽度 font字体大小
- (CGFloat)getHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.height;
}
@end
