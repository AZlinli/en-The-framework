//
//  LYNavigationBarTitleView.m
//  SouthEastProject
//
//  Created by 罗勇 on 2017/11/22.
//  Copyright © 2017年 Saber. All rights reserved.
//

#import "LYNavigationBarTitleView.h"

@implementation LYNavigationBarTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
}

- (void)dealloc
{
    LYNSLog(@"dealloc - %@", NSStringFromClass([self class]));
}
@end
