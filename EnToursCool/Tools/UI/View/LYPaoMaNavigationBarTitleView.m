//
//  LYPaoMaNavigationBarTitleView.m
//  SouthEastProject
//
//  Created by luoyong on 2018/5/4.
//  Copyright © 2018年 Saber. All rights reserved.
//

#import "LYPaoMaNavigationBarTitleView.h"
#define TEXTFONTSIZE 18

@interface LYPaoMaNavigationBarTitleView()<CAAnimationDelegate>
{
    CGRect rectMark1;//标记第一个位置
    CGRect rectMark2;//标记第二个位置
    
    NSMutableArray* labelArr;
    
    NSTimeInterval timeInterval;//时间
    
    BOOL isStop;//停止
    
    BOOL useReserve;
}
@end

@implementation LYPaoMaNavigationBarTitleView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *name = title;
        title = [NSString stringWithFormat:@"       %@       ",title];//间隔
        timeInterval = [self displayDurationForString:title];
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        UILabel* textLb = [[UILabel alloc] initWithFrame:CGRectZero];
        textLb.textColor = [LYTourscoolAPPStyleManager navigationTitleColor];
        textLb.font = [LYTourscoolAPPStyleManager navigationTitleFont];
        textLb.text = title;
        textLb.textAlignment = NSTextAlignmentCenter;
        //计算textLb大小
        CGSize sizeOfText = [textLb sizeThatFits:CGSizeZero];
        
        rectMark1 = CGRectMake(0, 0, sizeOfText.width, self.bounds.size.height);
        rectMark2 = CGRectMake(rectMark1.origin.x+rectMark1.size.width, 0, sizeOfText.width, self.bounds.size.height);
        
        textLb.frame = rectMark1;
        [self addSubview:textLb];
        labelArr = [NSMutableArray arrayWithObject:textLb];
        //判断是否需要reserveTextLb
        useReserve = sizeOfText.width > frame.size.width ? YES : NO;
        if (useReserve) {
            UILabel* reserveTextLb = [[UILabel alloc] initWithFrame:rectMark2];
            reserveTextLb.textColor = [LYTourscoolAPPStyleManager navigationTitleColor];
            reserveTextLb.font = [LYTourscoolAPPStyleManager navigationTitleFont];
            reserveTextLb.text = title;
            reserveTextLb.textAlignment = NSTextAlignmentCenter;
            [self addSubview:reserveTextLb];
            [labelArr addObject:reserveTextLb];
            [self paomaAnimate];
        }else{
            textLb.frame =CGRectMake(0, 0, 200, frame.size.height);
            textLb.text = name;
            textLb.textAlignment =NSTextAlignmentCenter;
        }
    }
    return self;
}

/**
 开始动画
 */
- (void)paomaAnimate
{
    if (!isStop) {
        UILabel* lbindex0 = labelArr[0];
        UILabel* lbindex1 = labelArr[1];
        [UIView transitionWithView:self duration:timeInterval options:UIViewAnimationOptionCurveLinear animations:^{
            lbindex0.frame = CGRectMake(-self->rectMark1.size.width, 0, self->rectMark1.size.width, self->rectMark1.size.height);
            lbindex1.frame = CGRectMake(lbindex0.frame.origin.x+lbindex0.frame.size.width, 0, lbindex1.frame.size.width, lbindex1.frame.size.height);
        } completion:^(BOOL finished) {
            lbindex0.frame = self->rectMark2;
            lbindex1.frame = self->rectMark1;
            [self->labelArr replaceObjectAtIndex:0 withObject:lbindex1];
            [self->labelArr replaceObjectAtIndex:1 withObject:lbindex0];
            [self paomaAnimate];
        }];
    }
}

- (void)start
{
    if (useReserve == YES && isStop == YES){
        isStop = NO;
        UILabel* lbindex0 = labelArr[0];
        UILabel* lbindex1 = labelArr[1];
        lbindex0.frame = rectMark2;
        lbindex1.frame = rectMark1;
        [labelArr replaceObjectAtIndex:0 withObject:lbindex1];
        [labelArr replaceObjectAtIndex:1 withObject:lbindex0];
        [self paomaAnimate];
    }
}

- (void)stop
{
    isStop = YES;
}

/**
 动画时间

 @param string string
 @return NSTimeInterval
 */
- (NSTimeInterval)displayDurationForString:(NSString*)string
{
    return string.length/3;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(200, 30);
}

@end
