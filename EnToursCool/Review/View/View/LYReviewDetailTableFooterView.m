//
//  LYReviewDetailTableFooterView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailTableFooterView.h"

@interface LYReviewDetailTableFooterView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation LYReviewDetailTableFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_747474Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    [self.goodButton setImage:[UIImage imageNamed:@"loading"] forState:0];
    [self.goodButton setTitle:@"120" forState:0];
    self.goodButton.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_FFFFFFColor];
    
    self.goodButton.titleEdgeInsets = UIEdgeInsetsMake(0, -30, -35, 0);
    self.goodButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -10);
    
}
- (IBAction)goodButtonAction:(UIButton *)sender {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
