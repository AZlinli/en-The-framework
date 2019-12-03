//
//  LYDealsCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDealsCell.h"

@interface LYDealsCell()
@property (weak, nonatomic) IBOutlet UIImageView *imv1;

@property (weak, nonatomic) IBOutlet UIImageView *imv2;
@property (weak, nonatomic) IBOutlet UIImageView *imv3;

@end

@implementation LYDealsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setView:self.imv1 corner:8.f];
    [self setView:self.imv2 corner:8.f];
    [self setView:self.imv3 corner:8.f];
}

- (void)setView:(UIView *)view corner:(CGFloat)cornerRadius
{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

@end
