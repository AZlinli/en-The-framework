//
//  LYOderSectionHeadView.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOderSectionHeadView.h"
#import "LYOrderListModel.h"

NSString *const LYOderSectionHeadViewID = @"LYOderSectionHeadViewID";

@interface LYOderSectionHeadView()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation LYOderSectionHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.dateLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_12];
    self.dateLabel.textColor = [LYTourscoolAPPStyleManager ly_818D99Color];
    self.statusLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.statusLabel.textColor = [LYTourscoolAPPStyleManager ly_818D99Color];
}

- (void)dataDidChange
{
    //根据返回的数据，给左右label赋值
    LYOrderListModel *model = self.data;
    self.dateLabel.text = model.createDate ? model.createDate : model.createDate;
    self.statusLabel.text = model.statusName ? model.statusName : model.statusName;
}


@end
