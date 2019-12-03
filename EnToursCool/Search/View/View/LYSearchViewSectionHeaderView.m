//
//  LYSearchViewSectionHeaderView.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYSearchViewSectionHeaderView.h"
#import "LYSearchSectionTitleModel.h"
NSString * const LYSearchViewSectionHeaderViewID = @"LYSearchViewSectionHeaderViewID";

@interface LYSearchViewSectionHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LYSearchViewSectionHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCSemiboldFont_20];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
}

-(void)dataDidChange{
    LYSearchSectionTitleModel *model = self.data;
    self.titleLabel.text = model.title;
}

@end
