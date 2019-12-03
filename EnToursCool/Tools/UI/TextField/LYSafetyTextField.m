//
//  LYSafetyTextField.m
//  ToursCool
//
//  Created by tourscool on 11/8/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSafetyTextField.h"

@implementation LYSafetyTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#ifdef __IPHONE_11_0
- (BOOL)willDealloc
{
    if (@available(iOS 11.0, *)) {
        return NO;
    }
    return YES;
}
#endif

@end
