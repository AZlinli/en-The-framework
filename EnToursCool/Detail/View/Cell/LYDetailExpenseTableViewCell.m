//
//  LYDetailExpenseTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/28.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailExpenseTableViewCell.h"
#import "LYDetailBaseModel.h"
#import "LYDetailExpenseModel.h"
NSString * const LYDetailExpenseTableViewCellID = @"LYDetailExpenseTableViewCellID";

@interface LYDetailExpenseTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seeMoreButtonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seeMoreButtonH;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeMoreButton;
/**基础模型*/
@property(nonatomic, strong) LYDetailExpenseModelItem *model;
@end

@implementation LYDetailExpenseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.nameLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.nameLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.contentTextLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.contentTextLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.seeMoreButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    [self.seeMoreButton setTitleColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] forState:0];
    [self.seeMoreButton setTitle:@"see more" forState:0];
    [self.seeMoreButton setTitle:@"see less" forState:UIControlStateSelected];
    
}

- (void)dataDidChange {
    self.model = self.data;
    self.nameLabel.text = self.model.title;
    if (self.model.isFixationHighlightsCellH) {
          self.seeMoreButtonH.constant = 14;
          self.seeMoreButtonTop.constant = 10;
          self.seeMoreButton.hidden = NO;
          self.seeMoreButton.selected = self.model.isShowMore;
      }else{
          self.seeMoreButton.hidden = YES;
          self.seeMoreButtonH.constant = 0;
          self.seeMoreButtonTop.constant = 0;
      }
    if (self.model.type == LYDetailExpenseModelItemPriceSpecialNote) {
        self.contentTextLabel.text = self.model.text;
    }else if (self.model.type == LYDetailExpenseModelItemInclusions){
        [self dealContentTextLabel:@"detail_gou"];
    }else if (self.model.type == LYDetailExpenseModelItemExclusions){
        [self dealContentTextLabel:@"detail_cha"];
    }
}

- (void)dealContentTextLabel:(NSString *)imageName {
    NSArray *textArray = [self.model.text componentsSeparatedByString:@"\r\n"];
    [self.contentTextLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        [textArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                confer.appendImage([UIImage imageNamed:imageName]).bounds(CGRectMake(0, 0, 10, 10));
            confer.text(@" ");
            confer.text(obj).textColor([LYTourscoolAPPStyleManager ly_484848Color]).font([LYTourscoolAPPStyleManager ly_ArialRegular_14]);
            if (idx < textArray.count) {
                confer.text(@"\n");
            }
        }];

    }];
}
- (IBAction)seeMoreButtonAction:(UIButton *)sender {
    if (self.expenseSeeMoreButtonBlock) {
        self.expenseSeeMoreButtonBlock();
    }
}
@end
