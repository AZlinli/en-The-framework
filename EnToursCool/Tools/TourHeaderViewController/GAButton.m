//
//  GAButton.m
//  GAIA供应
//
//  Created by  GAIA on 2017/8/24.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "GAButton.h"

@implementation GAButton

-(void)setHighlighted:(BOOL)highlighted
{
    //去高亮下的所有样式;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self setTitleColor:[UIColor hexColor:@"#00173A" alpha:1] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor hexColor:@"#0A197D" alpha:1] forState:UIControlStateSelected];
    }
    return self;
    
}

@end
