//
//  LYCountyCollectionCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCountyCollectionCell.h"
#import "LYHomeExploreModel.h"

NSString *const LYCountyCollectionCellID = @"LYCountyCollectionCellID";

@interface LYCountyCollectionCell()
@property (weak, nonatomic) IBOutlet UIButton *myTagBtn;

@end

@implementation LYCountyCollectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.myTagBtn.layer.cornerRadius = self.myTagBtn.height * 0.5;
    self.myTagBtn.layer.masksToBounds = YES;
}

- (void)dataDidChange
{
//    NSString *title = self.data;
    //赋值数据
}

@end
