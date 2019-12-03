//
//  NSAttributedString+LYRichText.m
//  LYIGListKitTest
//
//  Created by tourscool on 5/22/19.
//  Copyright © 2019 Saber. All rights reserved.
//

#import "NSMutableAttributedString+LYRichText.h"
#import "UIColor+PXColors.h"

@implementation NSMutableAttributedString (LYRichText)

- (void)setUnderlineStyleThickrange:(NSRange)range hexColor:(NSString *)hexColor
{
    NSRange stringRange = NSMakeRange(0, self.string.length);
    if (stringRange.length < range.length || stringRange.location > range.location) {
        return;
    }
    [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleThick] range:range];
    if (hexColor.length) {
        [self addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:hexColor] range:range];
    }
}

- (void)setColor:(NSString *)hexColor range:(NSRange)range font:(UIFont *)font
{
    NSRange stringRange = NSMakeRange(0, self.string.length);
    if (stringRange.length < range.length || stringRange.location > range.location) {
        return;
    }
    if (hexColor.length) {
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:hexColor] range:range];
    }
    if (font) {
        [self addAttribute:NSFontAttributeName value:font range:range];
    }
}

- (void)ly_setColor:(NSString *)hexColor string:(NSString *)string font:(UIFont *)font
{
    NSRange stringRange = [self.string rangeOfString:string];
    [self setColor:hexColor range:stringRange font:font];
}

@end
