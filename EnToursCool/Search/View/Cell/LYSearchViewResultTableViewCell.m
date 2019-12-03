//
//  LYSearchViewResultTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYSearchViewResultTableViewCell.h"
#import "LYSearchSectionTitleModel.h"

NSString * const LYSearchViewResultTableViewCellID = @"LYSearchViewResultTableViewCellID";

@interface LYSearchViewResultTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation LYSearchViewResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    
    self.descLabel.font = [UIFont fontWithName:@"Arial" size: 14];
    self.descLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)dataDidChange{
    LYSearchItemModel *model = self.data;
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
}

@end


