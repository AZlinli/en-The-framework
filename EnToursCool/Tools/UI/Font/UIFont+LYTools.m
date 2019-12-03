//
//  UIFont+LYTools.m
//  ToursCool
//
//  Created by tourscool on 10/29/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "UIFont+LYTools.h"
#import "LYLanguageManager.h"

//NSArray *familys = [UIFont familyNames];
//for (int i = 0; i<familys.count; i++) {
//    NSString *family = [familys objectAtIndex:i];
//    NSLog(@"family = %@",family);
//    
//    NSArray *fonts = [UIFont fontNamesForFamilyName:family];
//    for (int j = 0; j<fonts.count; j++) {
//        NSString *font = [fonts objectAtIndex:j];
//        NSLog(@"font = %@",font);
//    }
//}

@implementation UIFont (LYTools)

+ (UIFont *)obtainPingFontWithStyle:(LYPingFangSCStyle)style size:(CGFloat)size
{
//    switch (style) {
//        case LYPingFangSCMedium:
//            return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
//        case LYPingFangSCRegular:
//            return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
//        case LYPingFangSCLight:
//            return [UIFont fontWithName:@"PingFangSC-Light" size:size];
//        case LYPingFangSCUltralight:
//            return [UIFont fontWithName:@"PingFangSC-Ultralight" size:size];
//        case LYPingFangSCSemibold:
//            return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
//        case LYPingFangSCThin:
//            return [UIFont fontWithName:@"PingFangSC-Thin" size:size];
//    }
    return [UIFont fontWithName:[UIFont ly_obtainFontNameWithStyle:style] size:size];
}

+ (NSString *)ly_obtainFontNameWithStyle:(LYPingFangSCStyle)style
{
    switch (style) {
        case LYPingFangSCMedium:
            return [NSString stringWithFormat:@"%@-Medium", [UIFont ly_obtainFont]];
//            return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
        case LYPingFangSCRegular:
            return [NSString stringWithFormat:@"%@-Regular", [UIFont ly_obtainFont]];
//            return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
        case LYPingFangSCLight:
            return [NSString stringWithFormat:@"%@-Light", [UIFont ly_obtainFont]];
//            return [UIFont fontWithName:@"PingFangSC-Light" size:size];
        case LYPingFangSCUltralight:
            return [NSString stringWithFormat:@"%@-Ultralight", [UIFont ly_obtainFont]];
//            return [UIFont fontWithName:@"PingFangSC-Ultralight" size:size];
        case LYPingFangSCSemibold:
//            return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
            return [NSString stringWithFormat:@"%@-Semibold", [UIFont ly_obtainFont]];
        case LYPingFangSCThin:
            return [NSString stringWithFormat:@"%@-Thin", [UIFont ly_obtainFont]];
//            return [UIFont fontWithName:@"PingFangSC-Thin" size:size];
    }
}

+ (NSString *)ly_obtainFont
{
    NSString *language = [LYLanguageManager currentLanguage];
    if ([language hasPrefix:@"zh-Hant-TW"]) {
        return @"PingFangTC";
    }
    return @"PingFangSC";
}

+ (CGFloat)obtainWidthWithContent:(NSString *)content style:(LYPingFangSCStyle)style fontSize:(CGFloat)fontSize rectSizeHeight:(CGFloat)rectSizeHeight
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont obtainPingFontWithStyle:style size:fontSize]};
    CGSize textSize = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, rectSizeHeight)
                                           options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize.width;
}

@end
