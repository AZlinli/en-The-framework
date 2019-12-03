//
//  LYAddressCollectionViewCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYAddressCollectionViewCell.h"
#import "LYHomeExploreModel.h"

NSString *const LYAddressCollectionViewCellID = @"LYAddressCollectionViewCellID";

@interface LYAddressCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LYAddressCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imv.layer.cornerRadius = 8.f;
    self.imv.layer.masksToBounds = YES;
    
}

- (void)dataDidChange
{
//    LYExploreAdressModel *adressM = self.data;
    //赋值数据
    
}

@end
