//
//  LYDetailHighlightsTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailHighlightsTableViewCell.h"
#import "LYDetailHighlightsModel.h"

NSString * const LYDetailHighlightsTableViewCellID = @"LYDetailHighlightsTableViewCellID";

@interface LYDetailHighlightsTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seeMoreButtonTop;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *conetntTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seeMoreButtonH;
@property (weak, nonatomic) IBOutlet UIButton *seeMoreButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;
/**model*/
@property(nonatomic, strong) LYDetailHighlightsModel *model;
@end

@implementation LYDetailHighlightsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_16];
    
    self.conetntTextLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.conetntTextLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    
    [self.seeMoreButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:0];
    self.seeMoreButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    [self.seeMoreButton setTitle:@"see more" forState:0];
    [self.seeMoreButton setTitle:@"see less" forState:UIControlStateSelected];

    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];
}

- (void)dataDidChange {
    self.model = self.data;
    self.conetntTextLabel.text = self.model.text;
    //当高度固定的时候（真实高度大于等于预定固定高度时，才会高度固定）才会显示seeMoreButton，是否展开是建立在按钮已经显示出来的前提下
    if (self.model.isFixationHighlightsCellH) {
        self.seeMoreButtonH.constant = 14;
        self.seeMoreButtonTop.constant = 20;
        self.seeMoreButton.hidden = NO;
        self.seeMoreButton.selected = self.model.isShowMore;
    }else{
        self.seeMoreButton.hidden = YES;
        self.seeMoreButtonH.constant = 0;
        self.seeMoreButtonTop.constant = 0;
    }
}
- (IBAction)seeMoreButtonAction:(UIButton *)sender {
    if (self.seeMoreButtonBlock) {
        self.seeMoreButtonBlock();
    }
}

@end
