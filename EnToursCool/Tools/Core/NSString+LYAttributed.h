//
//  NSString+LYAttributed.h
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYAttributed)
+ (NSAttributedString *)setupAdvancedAttributedStringWithFirstStr:(NSString * _Nullable)firstStr
                                                    firstHexColor:(NSString * _Nullable)firstHexColor
                                                        firstFont:(UIFont * _Nullable)firstFont
                                                        secondStr:(NSString * _Nullable)secondStr
                                                   secondHexColor:(NSString * _Nullable)secondHexColor
                                                       secondFont:(UIFont * _Nullable)secondFont
                                                       thirdlyStr:(NSString * _Nullable)thirdlyStr
                                                  thirdlyHexColor:(NSString * _Nullable)thirdlyHexColor
                                                      thirdlyFont:(UIFont * _Nullable)thirdlyFont;
@end

NS_ASSUME_NONNULL_END
