//
//  LYReviewDetailImageTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailImageTableViewCell.h"
#import "LYReviewDetailModel.h"
#import <UIImageView+WebCache.h>

@interface LYReviewDetailImageTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property(nonatomic, strong) LYReviewDetailModel *model;
@end

@implementation LYReviewDetailImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dataDidChange {
    self.model = self.data;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:self.model.url] placeholderImage:nil];
}
@end
