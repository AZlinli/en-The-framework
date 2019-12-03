//
//  LYOrderSectionFootView.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOrderSectionFootView.h"
#import "LYOrderListModel.h"

NSString *const LYOrderSectionFootViewID = @"LYOrderSectionFootViewID";

@interface LYOrderSectionFootView()
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastBtn;


@end

@implementation LYOrderSectionFootView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.firstBtn.layer.cornerRadius = 17;
    self.firstBtn.layer.borderWidth = 0.5;
    self.secondBtn.layer.cornerRadius = 17;
    self.secondBtn.layer.borderWidth = 0.5;
    self.lastBtn.layer.cornerRadius = 17;
    self.lastBtn.layer.borderWidth = 0.5;
    self.firstBtn.layer.borderColor = [LYTourscoolAPPStyleManager ly_484848Color].CGColor;
    
    [self.firstBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.secondBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.lastBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dataDidChange
{
    LYOrderListModel *model = self.data;
    //根据返回的数据，给左右label赋值
    if ([model.statusName isEqualToString:@"Payment Pending"])     //待支付状态
    {
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = NO;
        self.lastBtn.hidden = NO;
        [self setButton:self.secondBtn titleColor:[UIColor whiteColor] title:@"Proceed to payment" backColor:[LYTourscoolAPPStyleManager ly_19A8C7Color] bordColor:[UIColor clearColor]];
        [self setButton:self.lastBtn titleColor:[LYTourscoolAPPStyleManager ly_484848Color] title:@"Cancle" backColor:[UIColor whiteColor] bordColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    }
    if ([model.statusName isEqualToString:@"Reservation pending"])    //待预定状态
    {
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.lastBtn.hidden = NO;
        [self  setButton:self.lastBtn titleColor:[LYTourscoolAPPStyleManager ly_484848Color] title:@"Cancel" backColor:[UIColor whiteColor] bordColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    }
    if ([model.statusName isEqualToString:@"Booking confirmed"])    //预定确认状态
    {
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = NO;
        self.lastBtn.hidden = NO;
        [self  setButton:self.secondBtn titleColor:[LYTourscoolAPPStyleManager ly_484848Color] title:@"Cancle" backColor:[UIColor whiteColor] bordColor:[LYTourscoolAPPStyleManager ly_484848Color]];
        [self  setButton:self.lastBtn titleColor:[LYTourscoolAPPStyleManager ly_484848Color] title:@"Edit Flight Info" backColor:[UIColor whiteColor] bordColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    }
    if ([model.statusName isEqualToString:@"Traveling"])    //旅行中
    {
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = YES;
        self.lastBtn.hidden = NO;
        [self  setButton:self.lastBtn titleColor:[LYTourscoolAPPStyleManager ly_484848Color] title:@"Write a Review" backColor:[UIColor whiteColor] bordColor:[LYTourscoolAPPStyleManager ly_484848Color]];
    }
    if ([model.statusName isEqualToString:@"Completed"])    //已完成
    {
        self.firstBtn.hidden = YES;
        self.secondBtn.hidden = NO;
        self.lastBtn.hidden = NO;
        [self  setButton:self.secondBtn titleColor:[LYTourscoolAPPStyleManager ly_484848Color] title:@"Write a Review" backColor:[UIColor whiteColor] bordColor:[LYTourscoolAPPStyleManager ly_484848Color]];
        [self  setButton:self.lastBtn titleColor:[LYTourscoolAPPStyleManager ly_EC6564Color] title:@"Remove" backColor:[UIColor whiteColor] bordColor:[LYTourscoolAPPStyleManager ly_EC6564Color]];
    }
    if ([model.statusName isEqualToString:@"Failed"])    //预定失败状态
       {
           self.firstBtn.hidden = YES;
           self.secondBtn.hidden = YES;
           self.lastBtn.hidden = NO;
           [self  setButton:self.lastBtn titleColor:[LYTourscoolAPPStyleManager ly_EC6564Color] title:@"Remove" backColor:[UIColor whiteColor] bordColor:[LYTourscoolAPPStyleManager ly_EC6564Color]];
       }
}

- (void)setButton:(UIButton *)btn titleColor:(UIColor *)titleColor title:(NSString *)title backColor:(UIColor *)backColor bordColor:(UIColor *)bordColor
{
   [btn setTitleColor:titleColor forState:UIControlStateNormal];
   [btn setTitle:title forState:UIControlStateNormal];
   [btn setBackgroundColor:backColor];
   btn.layer.borderColor = bordColor.CGColor;
}

#pragma mark - action

- (void)btnClick:(UIButton *)btn
{
    LYOrderListModel *model = self.data;
    if ([btn.currentTitle isEqualToString:@"Remove"])       //删除
    {
        OBJC_BLOCK_EXEC(self.removeBlock,model.travelID);
    }else if ([btn.currentTitle isEqualToString:@"Proceed to payment"])  //去支付
    {
        OBJC_BLOCK_EXEC(self.payBlock,model.travelID);
    }else if ([btn.currentTitle isEqualToString:@"Cancle"])  //取消
    {
        OBJC_BLOCK_EXEC(self.cancelBlock,model.travelID);
    }else if ([btn.currentTitle isEqualToString:@"Edit Flight Info"])  //编辑航班信息
    {
        OBJC_BLOCK_EXEC(self.flightBlock,model.travelID);
    }else if ([btn.currentTitle isEqualToString:@"Write a Review"])  //去评论
    {
        OBJC_BLOCK_EXEC(self.commentBlock,model.travelID);
    }
}

@end
