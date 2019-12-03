//
//  TourSearchView.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "TourSearchView.h"
#import "UIView+LYCorner.h"
#import "UIView+XKCornerBorder.h"

@interface TourSearchView()

@property (weak, nonatomic) IBOutlet UIView *leftBackView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UITextField *myTxd;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (nonatomic, copy) JumpBlock jump;
@property (nonatomic, copy) RightJumpBlock rightJump;




@end

@implementation TourSearchView

#pragma mark - life
- (instancetype)initWithLeftImgName:(NSString *)leftImgName placeString:(NSString *)placeString rightImgName:(NSString *)rightImgName click:(JumpBlock)jumpBlock rightClick:(RightJumpBlock)rightBlock
{
    if (self = [super init])
    {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        self.alpha = 0.86;
        if (leftImgName.filterSpace.length)
        {
            self.leftImg.image = [UIImage imageNamed:leftImgName];
        }
        if (placeString.filterSpace.length)
        {
            self.myTxd.placeholder = placeString;
        }
        if (rightImgName.filterSpace.length)
        {
            [self.rightBtn setImage:[UIImage imageNamed:rightImgName] forState:UIControlStateNormal];
        }
        self.jump = jumpBlock;
        self.rightJump = rightBlock;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.myTxd.userInteractionEnabled = NO;
    [self.leftBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToSearch)]];
    @weakify(self);
    [[self.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        OBJC_BLOCK_EXEC(self.rightJump,nil);
    }];
}

- (void)drawRect:(CGRect)rect
{
    [self.leftBackView setDirectionBorderWithTop:YES left:YES bottom:YES right:YES borderColor:[LYTourscoolAPPStyleManager ly_E4E4E4CColor] withBorderWidth:1];
    self.leftBackView.layer.cornerRadius = 4.0f;
    self.leftBackView.layer.masksToBounds = YES;
}

//内置大小
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(kScreenWidth, 30.0f);
}


#pragma mark - action

- (void)jumpToSearch
{
    OBJC_BLOCK_EXEC(self.jump,nil);
}
@end
