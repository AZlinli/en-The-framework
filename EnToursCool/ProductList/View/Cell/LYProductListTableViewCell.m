//
//  LYProductListTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListTableViewCell.h"
#import "LYProductListItemModel.h"
#import "LHRatingView.h"
#import "LYImageShow.h"


NSString * const LYProductListTableViewCellID = @"LYProductListTableViewCellID";

@interface LYProductListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *specialShortImageView;
@property (weak, nonatomic) IBOutlet UILabel *specialShortLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *savedPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *depatureLabel;
@property (weak, nonatomic) IBOutlet LHRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property(nonatomic, strong) LHRatingView *starView1;
@property (weak, nonatomic) IBOutlet UILabel *originerPriceLabel;

@end

@implementation LYProductListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.nameLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.savedPriceLabel.textColor = [UIColor colorWithHexString:@"EC6564"];
    self.savedPriceLabel.font = [UIFont fontWithName:@"Arial" size: 10];
    self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.priceLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16];
    self.durationLabel.textColor = [UIColor colorWithHexString:@"7F7F7F"];
    self.durationLabel.font = [UIFont fontWithName:@"Arial" size: 10];
    self.depatureLabel.textColor = [UIColor colorWithHexString:@"7F7F7F"];
    self.depatureLabel.font = [UIFont fontWithName:@"Arial" size: 10];
    self.reviewsLabel.textColor = [UIColor colorWithHexString:@"878787"];
    self.reviewsLabel.font = [UIFont fontWithName:@"Arial" size: 10];
    
    self.specialShortLabel.hidden = YES;
    self.specialShortImageView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dataDidChange{
    LYProductListItemModel *model = self.data;
    
    self.nameLabel.text = model.name;
    self.reviewsLabel.text = model.reviews;
    self.depatureLabel.text = model.depature;
    self.durationLabel.text = model.duration;
    self.priceLabel.text = model.price;
    self.savedPriceLabel.text = model.savePrice;
    if (model.special.length > 0) {
        self.specialShortLabel.text = model.special;
        self.specialShortLabel.hidden = NO;
        self.specialShortImageView.hidden = NO;
    }else{
        self.specialShortLabel.hidden = YES;
        self.specialShortImageView.hidden = YES;
    }
    
    if (model.origanlPrice.length > 0 && ![model.origanlPrice isEqualToString:@"0.0"]) {

        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:model.origanlPrice];
        [attrStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attrStr.length)];
        [attrStr addAttribute:NSFontAttributeName value:[LYTourscoolAPPStyleManager ly_ArialRegular_10] range:NSMakeRange(0, attrStr.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[LYTourscoolAPPStyleManager ly_7F7F7FColor] range:NSMakeRange(0, attrStr.length)];
        
        self.originerPriceLabel.attributedText = attrStr;
//        self.originerPriceLabel.hidden = NO;
    }else{
        [self.originerPriceLabel removeFromSuperview];
//        self.originerPriceLabel.hidden = YES;
    }
    
 
    
    self.starView1 = [[LHRatingView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [self addSubview:self.starView1];
    [self.starView1 mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.goodsImageView.mas_right).offset(10.f);
        make.bottom.equalTo(self.depatureLabel.mas_top).offset(-3.f);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    NSInteger score = ceil(model.score.doubleValue);
    self.starView1.score = score;
    self.starView1.ratingType = INTEGER_TYPE;
    self.starView1.userInteractionEnabled = NO;
    [LYImageShow ly_showImageInImageView:self.goodsImageView path:model.image cornerRadius:8.f placeholderImage:nil itemSize:CGSizeMake(120.f, 160.f)];

}

@end
