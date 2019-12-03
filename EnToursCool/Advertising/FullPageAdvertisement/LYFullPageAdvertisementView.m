//
//  LYFullPageAdvertisementView.m
//  LYIGListKitTest
//
//  Created by tourscool on 2/18/19.
//  Copyright © 2019 Saber. All rights reserved.
//

#import "LYFullPageAdvertisementView.h"
#import "LYDownTimer.h"
#import "LYImageShow.h"
#import "LYFullPageAdvertisementModel.h"
#import "UIView+LYUtil.h"
#import "UIButton+LYTourscoolExtension.h"
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface LYFullPageAdvertisementView ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *downTimeButton;
@property (nonatomic, assign) NSInteger downTime;
@property (nonatomic, strong) LYDownTimer * downTimer;

@property (nonatomic, strong) LYFullPageAdvertisementModel * fullPageAdvertisementModel;
@end

@implementation LYFullPageAdvertisementView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    if (self = [super init]) {
        _downTime = 5;
        self.downTimer = [[LYDownTimer alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
//        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self);
        }];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
//        [[tap rac_gestureSignal] subscribeNext:^(id x) {
//            @strongify(self);
//            if (self.userTouchFullPageAdvertisementBlock && self.fullPageAdvertisementModel.linkUrl.length) {
//                self.userTouchFullPageAdvertisementBlock(self.fullPageAdvertisementModel.linkUrl);
//            }
//            [self removeView];
//        }];
//        [imageView addGestureRecognizer:tap];
        
        self.imageView = imageView;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        button.cornerRadius = 15.f;
        button.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        button.titleLabel.font = [UIFont obtainPingFontWithStyle:LYPingFangSCRegular size:14.f];
        [button setTitle:[NSString stringWithFormat:@"跳过%@s", @(_downTime)] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.mas_safeAreaLayoutGuideTop).offset(20.f);
            } else {
                make.top.equalTo(self.mas_top).offset(20.f);
            }
            make.right.equalTo(self.mas_right).offset(-20.f);
            make.height.offset(30.f);
            make.width.offset(80.f);
        }];
        [button setEnlargeEdgeWithTop:15.f right:10.f bottom:10.f left:15.f];
        self.downTimeButton = button;
        [[self.downTimeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self removeView];
        }];
        self.downTimeButton.hidden = YES;
        [self.downTimer startTimerWithTime:_downTime countDownBlock:^(NSString * _Nonnull second) {
            @strongify(self);
            if ([second integerValue] <= 4) {
                self.downTimeButton.hidden = NO;
            }
            if ([second integerValue] <= 0) {
                self.downTimeButton.hidden = YES;
                [self removeView];
            }else{
                [self.downTimeButton setTitle:[NSString stringWithFormat:@"%@%ds", [LYLanguageManager ly_localizedStringForKey:@"Full_Page_Ad_Jump"], [second intValue]] forState:UIControlStateNormal];
            }
        }];
    }
    return self;
}

- (void)removeView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.1;
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showImageWithImagePath:(NSString *)imagePath
{
    [LYImageShow showImageInImageView:self.imageView withPath:imagePath placeholderImage:nil];
}

- (void)setViewFullPageAdvertisementModel:(LYFullPageAdvertisementModel *)fullPageAdvertisementModel
{
    [LYImageShow showImageInImageView:self.imageView imagePath:fullPageAdvertisementModel.imageUrl];
    self.fullPageAdvertisementModel = fullPageAdvertisementModel;
}

- (void)dealloc
{
    [self.downTimer endDownTime];
    LYNSLog(@"%@", NSStringFromClass([self class]));
}

+ (LYFullPageAdvertisementView *)obtainFullPageAdvertisementView
{
    for (UIView * view in [UIApplication sharedApplication].delegate.window.rootViewController.view.subviews) {
        if ([view isKindOfClass:[LYFullPageAdvertisementView class]]) {
            return (LYFullPageAdvertisementView *)view;
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ([[[[event allTouches] anyObject] view] isKindOfClass:[UIButton class]]) {
        return;
    }
    if (self.userTouchFullPageAdvertisementBlock && self.fullPageAdvertisementModel.linkUrl.length) {
        self.userTouchFullPageAdvertisementBlock(self.fullPageAdvertisementModel.linkUrl);
    }
    [self removeView];
}

@end
