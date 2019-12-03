//
//  LYDetailSeeMoreFooterView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/28.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailSeeMoreFooterView.h"
#import "LYPickupDetailsModel.h"

NSString * const LYDetailSeeMoreFooterViewID = @"LYDetailSeeMoreFooterViewID";

@interface LYDetailSeeMoreFooterView()
@property (weak, nonatomic) IBOutlet UIButton *seeMoreButton;
/**model*/
@property(nonatomic, strong) LYPickupDetailsModel *model;
@end

@implementation LYDetailSeeMoreFooterView

- (void)dataDidChange {
    self.model = self.data;
    self.seeMoreButton.hidden = !self.model.isShowFooter;
    self.seeMoreButton.selected = self.model.isSeeMore;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.seeMoreButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:0];
    self.seeMoreButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    [self.seeMoreButton setTitle:@"See More" forState:0];
    [self.seeMoreButton setTitle:@"See Less" forState:UIControlStateSelected];

}
- (IBAction)seeMoreButtonAction:(UIButton *)sender {
    if (self.footerSeeMoreButtonBlock) {
        self.footerSeeMoreButtonBlock();
    }
}

@end
