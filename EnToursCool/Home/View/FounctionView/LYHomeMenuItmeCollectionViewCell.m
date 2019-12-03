//
//  LYHomeMenuItmeCollectionViewCell.m
//  ToursCool
//
//  Created by tourscool on 11/26/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeMenuItmeCollectionViewCell.h"
#import "LYHomeMenuModel.h"
#import "LYImageShow.h"
#import <SDWebImage/SDWebImage.h>

NSString * const LYHomeMenuItmeCollectionViewCellID = @"LYHomeMenuItmeCollectionViewCellID";
@interface LYHomeMenuItmeCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UILabel * menuTypeNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView * menuTypeImageView;

@end
@implementation LYHomeMenuItmeCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.menuTypeNameLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_12];
    self.menuTypeNameLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
}

- (void)dataDidChange
{
    LYHomeMenuItemModel * model = self.data;
    self.menuTypeNameLabel.text = model.title;
    [LYImageShow ly_showImageInImageView:self.menuTypeImageView path:model.imageUrl cornerRadius:20.f placeholderImage:[UIImage imageNamed:@"home_menuType_img"] itemSize:CGSizeMake(40.f, 40.f)];

}
@end
