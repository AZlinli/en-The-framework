//
//  LYCustomDetailNavigationBar.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCustomDetailNavigationBar.h"
@interface LYCustomDetailNavigationBar()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation LYCustomDetailNavigationBar
-(void)awakeFromNib {
    [super awakeFromNib];
    self.bottomLineView.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];
    

}

- (void)setupViewStyleWithAlpha:(CGFloat)alpha {
    self.backButton.backgroundColor = [UIColor whiteColor];
    self.shareButton.backgroundColor = [UIColor whiteColor];

    if (alpha <= 0) {
//        [self.backButton setImage:[UIImage imageNamed:@""] forState:0];
//        [self.shareButton setImage:[UIImage imageNamed:@""] forState:0];
//
    }else{
//        [self.backButton setImage:[UIImage imageNamed:@""] forState:0];
//        [self.shareButton setImage:[UIImage imageNamed:@""] forState:0];
    }
    self.titleLabel.alpha = alpha;
    self.bottomLineView.alpha = alpha;

    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:alpha];
}

- (IBAction)backButtonAction:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}
- (IBAction)shareButtonAction:(UIButton *)sender {
    if (self.shareBlock) {
        self.shareBlock();
    }
}

@end
