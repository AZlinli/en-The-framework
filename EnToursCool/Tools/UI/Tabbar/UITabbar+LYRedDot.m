//
//  UITabbar+LYRedDot.m
//  ToursCool
//
//  Created by tourscool on 6/28/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "UITabbar+LYRedDot.h"

static NSInteger TagNumber = 21100;
static CGFloat DotWidth = 8.f;

@implementation UITabBar (LYRedDot)

- (void)showRedDotOnItemIndex:(NSInteger)index
{
    [self removeBadgeOnItemIndex:index];
    UIView * tabBarSwappableImageView = [self obtainTabBarSwappableImageViewWithIndex:index];
    if (!tabBarSwappableImageView) {
        return;
    }
    UIView * badgeView = [[UIView alloc]init];
    badgeView.tag = TagNumber+ index;
    badgeView.layer.cornerRadius = DotWidth / 2.f;
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.frame = CGRectMake(CGRectGetWidth(tabBarSwappableImageView.frame) - DotWidth/2.f, 0, DotWidth, DotWidth);
    [tabBarSwappableImageView addSubview:badgeView];
    
}

- (UIView *)obtainTabBarSwappableImageViewWithIndex:(NSInteger)index
{
    UIView * tabBarButton = nil;
    int j = 0;
    NSArray * viewsArray = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView * _Nonnull obj1, UIView *  _Nonnull obj2) {
        return CGRectGetMinX(obj1.frame) - CGRectGetMinX(obj2.frame);
    }];
    for (int i = 0; i < viewsArray.count; i++) {
        UIView * view = viewsArray[i];
        if ([NSStringFromClass([view class]) isEqualToString:@"UITabBarButton"]) {
            if (j == index) {
                tabBarButton = view;
                break;
            }
            j ++;
        }
    }
    
    UIView * tabBarSwappableImageView = nil;
    for (UIView * view in tabBarButton.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:@"UITabBarSwappableImageView"]) {
            tabBarSwappableImageView = view;
            break;
        }
    }
    return tabBarSwappableImageView;
}

- (void)hideRedDotOnItemIndex:(NSInteger)index
{
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index
{
    UIView * tabBarSwappableImageView = [self obtainTabBarSwappableImageViewWithIndex:index];
    for(UIView*subView in tabBarSwappableImageView.subviews) {
        if(subView.tag == TagNumber + index) {
            [subView removeFromSuperview];
        }
    }
}

@end
