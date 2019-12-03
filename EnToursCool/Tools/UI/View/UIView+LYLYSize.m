//
//  UIView+LYLYSize.m
//  ToursCool
//
//  Created by tourscool on 5/28/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "UIView+LYLYSize.h"
#import <objc/runtime.h>

static char LYTopNameKey;
static char LYRightNameKey;
static char LYBottomNameKey;
static char LYLeftNameKey;

@implementation UIView (LYLYSize)

- (void)setEnlargeEdge:(CGFloat)aEdge
{
    [self ly_setEnlargeEdgeWithTop:aEdge right:aEdge bottom:aEdge left:aEdge];
}

- (void)ly_setEnlargeEdgeWithTop:(CGFloat)topEdge
                        right:(CGFloat)rightEdge
                       bottom:(CGFloat)bottomEdge
                         left:(CGFloat)leftEdge
{
    
    objc_setAssociatedObject(self, &LYTopNameKey, @(topEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &LYRightNameKey, @(rightEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &LYBottomNameKey, @(bottomEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &LYLeftNameKey, @(leftEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.bounds = [self enlargedRect];
}

- (CGRect)enlargedRect
{
    
    NSNumber* topEdge = objc_getAssociatedObject(self, &LYTopNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &LYRightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &LYBottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &LYLeftNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else{
        return self.bounds;
    }
}

@end
