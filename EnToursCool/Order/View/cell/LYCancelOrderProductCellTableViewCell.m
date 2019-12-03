//
//  LYCancelOrderProductCellTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCancelOrderProductCellTableViewCell.h"
#import "LYImageShow.h"
NSString * const LYCancelOrderProductCellTableViewCellID = @"LYCancelOrderProductCellTableViewCellID";
@interface LYCancelOrderProductCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation LYCancelOrderProductCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    
}

@end
