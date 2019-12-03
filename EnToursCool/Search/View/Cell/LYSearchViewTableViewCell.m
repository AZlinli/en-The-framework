//
//  LYSearchViewTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYSearchViewTableViewCell.h"
#import "LYSearchSectionTitleModel.h"

NSString * const LYSearchViewTableViewCellID = @"LYSearchViewTableViewCellID";
@interface LYSearchViewTableViewCell()
@property(nonatomic, strong) LYSearchItemModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIImageView *sepLineImageView;
@end

@implementation LYSearchViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_12];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dataDidChange{
    self.model = self.data;
    self.sepLineImageView.hidden = !self.model.showDeleteState;
    self.deleteButton.hidden = !self.model.showDeleteState;
    
    self.titleLabel.text = self.model.title;
}


- (IBAction)clickDeleteButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteItem:)]) {
        [self.delegate deleteItem:self.model.title];
    }
}

@end
