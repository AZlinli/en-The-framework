//
//  GASectionHeaderView.m
//  GAIA供应
//
//  Created by  GAIA on 2017/12/14.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "GASectionHeaderView.h"
@interface GASectionHeaderView()<UIGestureRecognizerDelegate>
@end
@implementation GASectionHeaderView

#pragma mark - lifeCycle
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addGesture];
}

#pragma mark - privitMethod
- (void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
}

- (void)click
{
    if ([self.delegate respondsToSelector:@selector(didSelectHeaderViewAtIndex:)])
    {
        [self.delegate didSelectHeaderViewAtIndex:self.indexPath];
    }
}
@end
