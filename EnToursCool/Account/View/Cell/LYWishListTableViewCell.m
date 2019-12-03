//
//  LYWishListTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYWishListTableViewCell.h"
#import "LYWishListItemModel.h"
#import "LYImageShow.h"

NSString * const LYWishListTableViewCellID = @"LYWishListTableViewCellID";

@interface LYWishListTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *savePrice;
@property (weak, nonatomic) IBOutlet UILabel *depatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *start1;
@property (weak, nonatomic) IBOutlet UIImageView *start2;
@property (weak, nonatomic) IBOutlet UIImageView *start3;
@property (weak, nonatomic) IBOutlet UIImageView *start4;
@property (weak, nonatomic) IBOutlet UIImageView *start5;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIView *unavailableView;

@property (strong, nonatomic) LYWishListItemModel *model;
@end

@implementation LYWishListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.reviewsLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.depatureLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    self.priceLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16];
    self.savePrice.font = [UIFont fontWithName:@"Arial" size: 12];
    
    [self.selectButton setImage:[UIImage imageNamed:@"list_fliter_unselected"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"list_fliter_selected"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    self.model = self.data;
    self.selectButton.hidden = !self.model.isEdit;
    if (self.model.isEnable) {
        self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        self.reviewsLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        self.depatureLabel.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        self.savePrice.textColor = [UIColor colorWithHexString:@"EC6564"];
        self.fromLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        self.goodsImageView.alpha = 1.0f;
        self.unavailableView.hidden = YES;
    }else{
        self.titleLabel.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        self.reviewsLabel.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        self.depatureLabel.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        self.priceLabel.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        self.savePrice.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        self.fromLabel.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        self.goodsImageView.alpha = 0.47f;
        self.unavailableView.hidden = NO;
    }
    self.titleLabel.text = self.model.title;
    self.reviewsLabel.text = self.model.reviews;
    self.depatureLabel.text = self.model.depature;
    self.priceLabel.text = self.model.price;
    self.savePrice.text = self.model.savePrice;
    [LYImageShow ly_showImageInImageView:self.goodsImageView path:self.model.image cornerRadius:2.f placeholderImage:nil itemSize:CGSizeMake(90.f, 90.f)];

    NSInteger score = ceil(self.model.score.doubleValue);
    if(score == 5){
        self.start1.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start2.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start3.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start4.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start5.image = [UIImage imageNamed:@"list_comment_star_selected"];
    }else if(score == 4){
        self.start1.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start2.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start3.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start4.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start5.image = [UIImage imageNamed:@"list_comment_star_unselect"];
    }else if(score == 3){
        self.start1.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start2.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start3.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start4.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start5.image = [UIImage imageNamed:@"list_comment_star_unselect"];
    }else if(score == 2){
        self.start1.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start2.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start3.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start4.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start5.image = [UIImage imageNamed:@"list_comment_star_unselect"];
    }else if(score == 1){
        self.start1.image = [UIImage imageNamed:@"list_comment_star_selected"];
        self.start2.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start3.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start4.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start5.image = [UIImage imageNamed:@"list_comment_star_unselect"];
    }else if(score == 0){
        self.start1.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start2.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start3.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start4.image = [UIImage imageNamed:@"list_comment_star_unselect"];
        self.start5.image = [UIImage imageNamed:@"list_comment_star_unselect"];
    }
    
    RAC(self.selectButton, selected) = [RACObserve(self.model, isSelected) takeUntil:self.rac_prepareForReuseSignal];
       self.selectButton.rac_command = self.model.selectedCommand;
       @weakify(self);
       [[RACObserve(self.model, isEdit) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
           @strongify(self);
           self.selectButton.hidden = ![x boolValue];
       }];
    
}

- (IBAction)clickSelectButton:(id)sender {
    self.selectButton.selected = !self.selectButton;
}

@end
