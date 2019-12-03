//
//  LYInspirationCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYInspirationCell.h"

NSString *const LYInspirationCellID = @"LYInspirationCellID";

@interface LYInspirationCell()

@property (weak, nonatomic) IBOutlet UIImageView *imv;

@end

@implementation LYInspirationCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imv.layer.cornerRadius = 8;
    self.imv.layer.masksToBounds = YES;
}

@end
