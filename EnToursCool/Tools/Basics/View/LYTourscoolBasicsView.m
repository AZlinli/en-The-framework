//
//  LYTourscoolBasicsView.m
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYTourscoolBasicsView.h"

@implementation LYTourscoolBasicsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
