//
//  GAActionSheet.m
//  GAIA供应
//
//  Created by  GAIA on 2017/9/25.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "GAActionSheet.h"

static CGFloat kAnimationDuration = .3;
@interface GAActionSheet ()

@end
@implementation GAActionSheet


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self prepare];
    
    [self layout];
    
    [self prepareAnimation];
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self prepare];
        
        [self layout];
        
        [self prepareAnimation];
    }
    
    return self;
}

+ (instancetype)actionSheet
{
    return [[self alloc] init];
}

- (void)prepareAnimation
{
    CGPoint center = self.contentView.center;
    center.y = self.contentView.bounds.size.height / 2.0f + self.bounds.size.height;
    self.contentView.center = center;
}


- (void)prepare
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor clearColor];
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
}

- (void)layout
{
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGPoint center = self.contentView.center;
          center.y = self.bounds.size.height - kSafeAreaHeight - self.contentView.bounds.size.height / 2.0f;
        self.contentView.center = center;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }];
}

- (void)showViewAddTo:(UIView *)placeView
{
    [placeView addSubview:self];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGPoint center = self.contentView.center;
        center.y = placeView.height - kSafeAreaHeight - self.contentView.bounds.size.height / 2.0f;
        self.contentView.center = center;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGPoint center = self.contentView.center;
        center.y = self.bounds.size.height +kSafeAreaHeight + self.contentView.bounds.size.height / 2.0f;
        self.contentView.center = center;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//触摸消失
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取任意触摸对象
    UITouch *touch = [touches anyObject];
    //得到触摸点
    CGPoint point = [touch locationInView:self];
    //坐标转换
    CGRect rect = [self convertRect:self.contentView.frame toView:self];
    //判断在alertView外
    if (!CGRectContainsPoint(rect, point))
    {
        //点击在AlertView外就消失
        [self dismiss];
    }
}
@end
