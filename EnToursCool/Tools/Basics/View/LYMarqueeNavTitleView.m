//
//  LYMarqueeNavTitleView.m
//  ToursCool
//
//  Created by tourscool on 9/25/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYMarqueeNavTitleView.h"
//#import "QMUIMarqueeLabel.h"

@interface LYMarqueeNavTitleView ()

//@property (nonatomic, weak) QMUIMarqueeLabel * marqueeLabel;

@end

@implementation LYMarqueeNavTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        QMUIMarqueeLabel * marqueeLabel = [[QMUIMarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
//        marqueeLabel.textAlignment = NSTextAlignmentCenter;
//        marqueeLabel.textColor = [LYTourscoolAPPStyleManager navigationTitleColor];
//        marqueeLabel.font = [LYTourscoolAPPStyleManager navigationTitleFont];
//        [self addSubview:marqueeLabel];
//        self.marqueeLabel = marqueeLabel;
    }
    return self;
}

- (void)setupMarqueeWithTitle:(NSString *)title
{
//    self.marqueeLabel.text = title;
//    self.marqueeLabel.shouldFadeAtEdge = NO;
}

- (void)stopAnimation
{
//    [self.marqueeLabel requestToStopAnimation];
}

- (void)startAnimation
{
//    [self.marqueeLabel requestToStartAnimation];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(kScreenWidth - 140.f, 30.f);
}

@end
