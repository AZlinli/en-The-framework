//
//  LYPickupDetailsTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYPickupDetailsTableViewCell.h"
#import "LYPickupDetailsModel.h"
#import "UIView+XKCornerBorder.h"

NSString * const LYPickupDetailsTableViewCellID = @"LYPickupDetailsTableViewCellID";

@interface LYPickupDetailsTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *myContentView;
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;
/**model*/
@property(nonatomic, strong) LYPickupDetailsModelItem *model;
@end

@implementation LYPickupDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.myContentView.xk_borderType = XKBorderTypeAllCorners;
    self.myContentView.xk_openBorder = YES;
    self.myContentView.xk_borderColor = [UIColor blueColor];
    self.myContentView.xk_borderWidth = 0.5;
    self.myContentView.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
    
    self.textContentLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.textContentLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_16];
}

- (void)dataDidChange {
    self.model = self.data;
    [self.textContentLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(self.model.time).textColor([LYTourscoolAPPStyleManager ly_484848Color]).font([LYTourscoolAPPStyleManager ly_ArialRegular_16]);
        confer.text(@"\n");
        confer.text(self.model.text).textColor([LYTourscoolAPPStyleManager ly_484848Color]).font([LYTourscoolAPPStyleManager ly_ArialRegular_16]);
    }];
}
@end
