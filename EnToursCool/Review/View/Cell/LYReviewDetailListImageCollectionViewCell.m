//
//  LYReviewDetailListImageCollectionViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailListImageCollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>
@interface LYReviewDetailListImageCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property(nonatomic, strong) NSString *url;

@end


@implementation LYReviewDetailListImageCollectionViewCell
-(void)dataDidChange {
    self.url = self.data;
    [self.collectionImageView sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionImageView.xk_radius = 8;
    self.collectionImageView.xk_clipType = XKCornerClipTypeAllCorners;
    self.collectionImageView.xk_openClip = YES;
    self.collectionImageView.contentMode = UIViewContentModeScaleAspectFill;
    
}

@end
