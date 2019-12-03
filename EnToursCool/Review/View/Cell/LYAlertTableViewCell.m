//
//  LYAlertTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYAlertTableViewCell.h"
@interface LYAlertTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation LYAlertTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
    
}

- (void)dataDidChange {
    NSString *title = self.data;
    self.titleLabel.text = title;
}

@end
