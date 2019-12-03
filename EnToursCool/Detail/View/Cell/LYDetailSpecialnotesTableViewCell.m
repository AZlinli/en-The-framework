//
//  LYDetailSpecialnotesTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/28.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailSpecialnotesTableViewCell.h"
#import "LYDetailSpecialnotesModel.h"

NSString * const LYDetailSpecialnotesTableViewCellID = @"LYDetailSpecialnotesTableViewCellID";
@interface LYDetailSpecialnotesTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;
/**model*/
@property(nonatomic, strong) LYDetailSpecialnotesModel *model;
@end
@implementation LYDetailSpecialnotesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentTextLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.contentTextLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
}

- (void)dataDidChange {
    self.model = self.data;
    self.contentTextLabel.attributedText = self.model.attributedStringtext;
}
@end
