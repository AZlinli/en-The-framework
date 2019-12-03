

//
//  LDLButton.m
//  01-news
//
//  Created by laidongling on 16/8/10.
//  Copyright © 2016年 Jin Liu. All rights reserved.
//

#import "LDLButton.h"

@implementation LDLButton

-(void)setHighlighted:(BOOL)highlighted
{
    //去高亮下的所有样式;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame])
    {
        [self setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:UIControlStateNormal];
        [self setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:UIControlStateSelected];
        self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    }
    return self;
}

@end
