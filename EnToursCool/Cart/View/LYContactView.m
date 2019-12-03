//
//  LYContactView.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYContactView.h"
@interface LYContactView()

@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@property (nonatomic, copy) TelephoneBlock telephoneB;
@property (nonatomic, copy) OnlineBlock onlineB;
@property (nonatomic, copy) EmailBlock emailB;
@property (nonatomic, copy) CancleBlock cancle;


@end

@implementation LYContactView

#pragma mark - life

- (instancetype)initWithContactViewWithTelephone:(TelephoneBlock)teleblock online:(OnlineBlock)onlineBlock email:(EmailBlock)emailBlock cancle:(CancleBlock)cancleBlock
{
    if (self = [super init])
    {
        self =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        self.telephoneB = teleblock;
        self.onlineB = onlineBlock;
        self.emailB = emailBlock;
        self.cancle = cancleBlock;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telephone)]];
    [self.view2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(online)]];
    [self.view3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(email)]];
    self.cancleBtn.layer.cornerRadius = self.cancleBtn.height / 2;
    self.cancleBtn.layer.masksToBounds = YES;
     @weakify(self);
    [[self.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //点击了button
        OBJC_BLOCK_EXEC(self.cancle,nil);
    }];
}

#pragma mark - action

- (void)telephone
{
    OBJC_BLOCK_EXEC(self.telephoneB,nil);
}

- (void)online
{
    OBJC_BLOCK_EXEC(self.onlineB,nil);
}

- (void)email
{
    OBJC_BLOCK_EXEC(self.emailB,nil);

}


@end
