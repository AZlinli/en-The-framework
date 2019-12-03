//
//  UIView+LYLYSize.h
//  ToursCool
//
//  Created by tourscool on 5/28/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYLYSize)

- (void)ly_setEnlargeEdgeWithTop:(CGFloat)topEdge
                        right:(CGFloat)rightEdge
                       bottom:(CGFloat)bottomEdge
                         left:(CGFloat)leftEdge;
@end

NS_ASSUME_NONNULL_END
