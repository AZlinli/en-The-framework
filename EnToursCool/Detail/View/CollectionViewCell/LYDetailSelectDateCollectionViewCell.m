//
//  LYDetailSelectDateCollectionViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailSelectDateCollectionViewCell.h"
#import "LYDetailSelectDateModel.h"
#import "UIView+XKCornerBorder.h"

NSString * const LYDetailSelectDateCollectionViewCellID = @"LYDetailSelectDateCollectionViewCellID";

@interface LYDetailSelectDateCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tagImageView;
/**model*/
@property(nonatomic, strong) LYDetailSelectDateModelItem *model;
@end

@implementation LYDetailSelectDateCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.timeLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    
    self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.priceLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_9];
    
    self.contentView.xk_borderType = XKBorderTypeAllCorners;
    self.contentView.xk_openBorder = YES;
    self.contentView.xk_borderColor = [LYTourscoolAPPStyleManager ly_191919Color];
    self.contentView.xk_borderWidth = 0.5;
    
}

- (void)dataDidChange {
    self.model = self.data;
    self.timeLabel.text = self.model.time;
    self.priceLabel.text = self.model.price;
    self.tagImageView.hidden = !self.model.isSale;
    if (self.model.isSale) {
        self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_EC6564Color];
    }else{
        self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    }
    if (self.model.isSeeMore) {
        self.timeLabel.text = @"More>";
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
        self.priceLabel.hidden  = YES;
        self.tagImageView.hidden = YES;
    }
}

@end
