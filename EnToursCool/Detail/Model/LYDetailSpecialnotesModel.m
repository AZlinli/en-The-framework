//
//  LYDetailSpecialnotesModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/26.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailSpecialnotesModel.h"

@implementation LYDetailSpecialnotesModel
- (NSAttributedString *)attributedStringtext {
    NSMutableAttributedString * contentAttributedString;
    if (self.text) {
       contentAttributedString = [[NSMutableAttributedString alloc] initWithData:[self.text dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [contentAttributedString addAttribute:NSFontAttributeName value:[LYTourscoolAPPStyleManager ly_ArialRegular_14] range:NSMakeRange(0, contentAttributedString.length)];
        }
    return contentAttributedString.copy;
}
@end
