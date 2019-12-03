//
//  LYContactSheet.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYContactSheet.h"

@interface LYContactSheet()

@property (nonatomic, strong) LYContactView *contactView;
@property (nonatomic, copy) TelephoneBlock telephoneB;
@property (nonatomic, copy) OnlineBlock onlineB;
@property (nonatomic, copy) EmailBlock emailB;
@end

@implementation LYContactSheet

#pragma mark - life
- (instancetype)initWithContactViewWithTelephone:(TelephoneBlock)teleblock online:(OnlineBlock)onlineBlock email:(EmailBlock)emailBlock
{
    if (self = [super init])
    {
        self.telephoneB = teleblock;
        self.onlineB = onlineBlock;
        self.emailB = emailBlock;
    }
    return self;
}

- (void)prepare
{
    [super prepare];
    __weak typeof(self)weakSelf = self;
    self.contactView = [[LYContactView alloc] initWithContactViewWithTelephone:^{
        OBJC_BLOCK_EXEC(weakSelf.telephoneB,nil);
    } online:^{
        OBJC_BLOCK_EXEC(weakSelf.onlineB,nil);
    } email:^{
        OBJC_BLOCK_EXEC(weakSelf.emailB,nil);
    } cancle:^{
         [weakSelf dismiss];
    }];
    [self.contentView addSubview:self.contactView];
}

- (void)layout
{
    [super layout];
    self.contentView.frame = CGRectMake(0, self.bounds.size.height - 285 * kScreenWidth / 375, self.bounds.size.width,  285 * kScreenWidth / 375);
    self.contactView.frame = self.contentView.bounds;
}

@end
