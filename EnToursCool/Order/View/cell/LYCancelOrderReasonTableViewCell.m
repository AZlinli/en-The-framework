//
//  LYCancelOrderReasonTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCancelOrderReasonTableViewCell.h"

NSString * const LYCancelOrderReasonTableViewCellID = @"LYCancelOrderReasonTableViewCellID";
@interface LYCancelOrderReasonTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *reasonButton1;
@property (weak, nonatomic) IBOutlet UIButton *reasonButton2;
@property (weak, nonatomic) IBOutlet UIButton *reasonButton3;
@property (weak, nonatomic) IBOutlet UIButton *reasonButton4;
@property (weak, nonatomic) IBOutlet UIButton *reasonButton5;
@property (weak, nonatomic) IBOutlet UIButton *reasonButton6;

@end

@implementation LYCancelOrderReasonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.reasonButton1 setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
    [self.reasonButton1 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,10)];
    [self.reasonButton2 setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
    [self.reasonButton2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,10)];
    [self.reasonButton3 setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
    [self.reasonButton3 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,10)];
    [self.reasonButton4 setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
    [self.reasonButton4 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,10)];
    [self.reasonButton5 setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
    [self.reasonButton5 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,10)];
    [self.reasonButton6 setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
    [self.reasonButton6 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,10)];
    
    [self.reasonButton1 setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.reasonButton1 setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];
    
    [self.reasonButton2 setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.reasonButton2 setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];
    
    [self.reasonButton3 setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.reasonButton3 setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];
    
    [self.reasonButton4 setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.reasonButton4 setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];
    
    [self.reasonButton5 setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.reasonButton5 setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];
    
    [self.reasonButton6 setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
    [self.reasonButton6 setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];
    
    self.reasonButton1.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    
}

- (IBAction)clickReasonButton1:(id)sender {
    if (!self.reasonButton1.selected) {
        self.reasonButton1.selected = YES;
        self.reasonButton2.selected = NO;
        self.reasonButton3.selected = NO;
        self.reasonButton4.selected = NO;
        self.reasonButton5.selected = NO;
        self.reasonButton6.selected = NO;
        [self chooseReason:@"1"];
    }
}

- (IBAction)clickReasonButton2:(id)sender {
    if (!self.reasonButton2.selected) {
        self.reasonButton2.selected = YES;
        self.reasonButton1.selected = NO;
        self.reasonButton3.selected = NO;
        self.reasonButton4.selected = NO;
        self.reasonButton5.selected = NO;
        self.reasonButton6.selected = NO;
        [self chooseReason:@"2"];
    }
}

- (IBAction)clickReasonButton3:(id)sender {
    if (!self.reasonButton3.selected) {
        self.reasonButton3.selected = YES;
        self.reasonButton2.selected = NO;
        self.reasonButton1.selected = NO;
        self.reasonButton4.selected = NO;
        self.reasonButton5.selected = NO;
        self.reasonButton6.selected = NO;
        [self chooseReason:@"3"];
    }
}

- (IBAction)clickReasonButton4:(id)sender {
    if (!self.reasonButton4.selected) {
        self.reasonButton4.selected = YES;
        self.reasonButton2.selected = NO;
        self.reasonButton3.selected = NO;
        self.reasonButton1.selected = NO;
        self.reasonButton5.selected = NO;
        self.reasonButton6.selected = NO;
        [self chooseReason:@"4"];
    }
}

- (IBAction)clickReasonButton5:(id)sender {
    if (!self.reasonButton5.selected) {
        self.reasonButton5.selected = YES;
        self.reasonButton2.selected = NO;
        self.reasonButton3.selected = NO;
        self.reasonButton4.selected = NO;
        self.reasonButton1.selected = NO;
        self.reasonButton6.selected = NO;
        [self chooseReason:@"5"];
    }
}

- (IBAction)clickReasonButton6:(id)sender {
    if (!self.reasonButton6.selected) {
        self.reasonButton6.selected = YES;
        self.reasonButton2.selected = NO;
        self.reasonButton3.selected = NO;
        self.reasonButton4.selected = NO;
        self.reasonButton5.selected = NO;
        self.reasonButton1.selected = NO;
        [self chooseReason:@"6"];
    }
}

- (void)chooseReason:(NSString*)type{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickReason:)]){
        [self.delegate clickReason:type];
    }
}

@end
