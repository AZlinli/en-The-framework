//
//  UIFont+LYTools.h
//  ToursCool
//
//  Created by tourscool on 10/29/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LYPingFangSCStyle){
    LYPingFangSCMedium = 1,
    LYPingFangSCRegular,
    LYPingFangSCLight,
    LYPingFangSCUltralight,
    LYPingFangSCSemibold,
    LYPingFangSCThin
};

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (LYTools)
+ (UIFont *)obtainPingFontWithStyle:(LYPingFangSCStyle)style size:(CGFloat)size;
+ (CGFloat)obtainWidthWithContent:(NSString *)content style:(LYPingFangSCStyle)style fontSize:(CGFloat)fontSize rectSizeHeight:(CGFloat)rectSizeHeight;
@end

NS_ASSUME_NONNULL_END
