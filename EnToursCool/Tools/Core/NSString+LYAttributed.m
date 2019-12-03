//
//  NSString+LYAttributed.m
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "NSString+LYAttributed.h"

@implementation NSString (LYAttributed)
+ (NSAttributedString *)setupAdvancedAttributedStringWithFirstStr:(NSString *)firstStr
                                                    firstHexColor:(NSString *)firstHexColor
                                                        firstFont:(UIFont *)firstFont
                                                        secondStr:(NSString *)secondStr
                                                   secondHexColor:(NSString *)secondHexColor
                                                       secondFont:(UIFont *)secondFont
                                                       thirdlyStr:(NSString *)thirdlyStr
                                                  thirdlyHexColor:(NSString *)thirdlyHexColor
                                                      thirdlyFont:(UIFont *)thirdlyFont;
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@", firstStr?:@"",secondStr?:@"",thirdlyStr?:@""]];
    if (firstStr.length) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:firstHexColor] range:NSMakeRange(0, firstStr.length)];
        [attrStr addAttribute:NSFontAttributeName value:firstFont range:NSMakeRange(0, firstStr.length)];
    }
    if (secondStr.length) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:secondHexColor] range:NSMakeRange(firstStr.length, secondStr.length)];
        [attrStr addAttribute:NSFontAttributeName value:secondFont range:NSMakeRange(firstStr.length, secondStr.length)];
    }
    if (thirdlyStr.length) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:thirdlyHexColor] range:NSMakeRange(secondStr.length+firstStr.length, thirdlyStr.length)];
        [attrStr addAttribute:NSFontAttributeName value:thirdlyFont range:NSMakeRange(secondStr.length+firstStr.length, thirdlyStr.length)];
    }
    
    return attrStr;
}
@end
