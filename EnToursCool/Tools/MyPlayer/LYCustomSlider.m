//
//  LYCustomSlider.m
//  ToursCool
//
//  Created by tourscool on 6/18/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYCustomSlider.h"

@implementation LYCustomSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, (CGRectGetHeight(bounds) - 4.f)/2.f, CGRectGetWidth(bounds), 4.f);
}

@end
