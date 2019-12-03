//
//  UILabel+LYTools.m
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "UILabel+LYTools.h"

@implementation UILabel (LYTools)

- (void)setLabelText:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing - (self.font.lineHeight - self.font.pointSize);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)setLabelLineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing - (self.font.lineHeight - self.font.pointSize);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
}

- (void)setLabelFont:(UIFont *)font textColor:(UIColor *)textColor
{
    self.font = font;
    self.textColor = textColor;
}

@end
