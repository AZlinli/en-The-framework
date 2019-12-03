//
//  LYNoteCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYNoteCell.h"

@interface LYNoteCell()
@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation LYNoteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.title.textColor = [LYTourscoolAPPStyleManager ly_747474Color];
    self.title.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
}

@end
