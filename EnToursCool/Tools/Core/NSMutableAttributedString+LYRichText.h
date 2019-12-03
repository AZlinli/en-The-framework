//
//  NSAttributedString+LYRichText.h
//  LYIGListKitTest
//
//  Created by tourscool on 5/22/19.
//  Copyright © 2019 Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (LYRichText)
- (void)setUnderlineStyleThickrange:(NSRange)range hexColor:(NSString *)hexColor;
- (void)setColor:(NSString *)hexColor range:(NSRange)range font:(UIFont *)font;
- (void)ly_setColor:(NSString *)hexColor string:(NSString *)string font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
