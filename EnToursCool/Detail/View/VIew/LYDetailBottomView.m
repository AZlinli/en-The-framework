//
//  LYDetailBottomView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailBottomView.h"

@interface LYDetailBottomView()
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;

@end

@implementation LYDetailBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bookButton.layer.cornerRadius = 17.f;
    self.bookButton.layer.masksToBounds = YES;
    [self.bookButton setTitle:@"Book now" forState:0];
    self.bookButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.bookButton.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_F9F9F9Color];
    self.bookButton.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
    
    [self.collectionButton setImage:[UIImage imageNamed:@"detail_star_unselect"] forState:0];
    [self.phoneButton setImage:[UIImage imageNamed:@"detail_phone"] forState:0];
}

#pragma mark - action
- (IBAction)bookingBtnClick:(UIButton *)sender
{
    OBJC_BLOCK_EXEC(self.bookingBtnClickBlock);
}

@end
