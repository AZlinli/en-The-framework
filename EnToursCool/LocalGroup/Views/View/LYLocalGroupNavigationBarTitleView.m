//
//  LYLocalGroupNavigationBarTitleView.m
//  ToursCool
//
//  Created by tourscool on 1/17/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYLocalGroupNavigationBarTitleView.h"
#import "QMUIMarqueeLabel.h"
#import "UIView+LYUtil.h"
#import "UIImage+LYUtil.h"
#import "UIButton+LYTourscoolSetImage.h"
#import "UIButton+LYTourscoolExtension.h"
#import <Masonry/Masonry.h>

@interface LYLocalGroupNavigationBarTitleView ()
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) QMUIMarqueeLabel * titleLabel;
@property (nonatomic, strong) UIButton * searchButton;
@end

@implementation LYLocalGroupNavigationBarTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backButton setEnlargeEdgeWithTop:10.f right:30.f bottom:10.f left:10.f];
        [self.backButton setImage:[[UIImage imageNamed:@"common_back_btn_normal"] imageTintedWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self addSubview:self.backButton];
        
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(8.f);
        }];
        
        self.titleLabel = [[QMUIMarqueeLabel alloc] init];
        self.titleLabel.text = @"xxxxxxx";
        self.titleLabel.font = [UIFont obtainPingFontWithStyle:LYPingFangSCRegular size:16.f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backButton.mas_centerY);
            make.centerX.equalTo(self.mas_centerX);
            make.width.offset(kScreenWidth - 160.f);
        }];
        
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.searchButton.cornerRadius = 11.f;
        [self.searchButton setButtonImageName:@"secondary_page_search_gray_img" forState:UIControlStateNormal];
        [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        self.searchButton.titleLabel.font = [UIFont obtainPingFontWithStyle:LYPingFangSCRegular size:11.f];
        [self.searchButton setTitleColor:[LYTourscoolAPPStyleManager ly_989898Color] forState:UIControlStateNormal];
        [self.searchButton setBackgroundColor:[UIColor whiteColor]];
        [self.searchButton setImagePosition:LYImagePositionLeft spacing:4.f];
        [self addSubview:self.searchButton];
        [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-8.f);
            make.height.offset(22.f);
            make.width.offset(60.f);
        }];
        
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        
        [self.backButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.backButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.backButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.backButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        @weakify(self);
        [[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.userPrecessNavigationBarTitleViewBackButtonBlock) {
                self.userPrecessNavigationBarTitleViewBackButtonBlock();
            }
        }];
        [[self.searchButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.userPrecessNavigationBarTitleViewSearchButtonBlock) {
                self.userPrecessNavigationBarTitleViewSearchButtonBlock();
            }
        }];
        [self addNotificationApplication];
    }
    return self;
}

- (void)hiddenSearchButton
{
    self.searchButton.hidden = YES;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    self.titleLabel.shouldFadeAtEdge = NO;
}

- (void)scrollViewChange:(CGFloat)alpha
{
    if (alpha <= 0) {
        [self.backButton setImage:[[UIImage imageNamed:@"common_back_btn_normal"] imageTintedWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self.searchButton setTitleColor:[LYTourscoolAPPStyleManager ly_989898Color] forState:UIControlStateNormal];
        [self.searchButton setBackgroundColor:[UIColor whiteColor]];
        [self.searchButton setButtonImageName:@"secondary_page_search_gray_img" forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor whiteColor];
    }else{
        [self.backButton setImage:[[UIImage imageNamed:@"common_back_btn_normal"] imageTintedWithColor:[UIColor colorWithHexString:@"404040" withAlpha:alpha]] forState:UIControlStateNormal];
        [self.searchButton setImage:[[UIImage imageNamed:@"secondary_page_search_gray_img"] imageTintedWithColor:[UIColor colorWithHexString:@"FFFFFF" withAlpha:alpha]] forState:UIControlStateNormal];
        [self.searchButton setTitleColor:[UIColor colorWithHexString:@"FFFFFF" withAlpha:alpha] forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"3E3E3E" withAlpha:alpha];
        [self.searchButton setBackgroundColor:[UIColor colorWithHexString:@"399EF6" withAlpha:alpha]];
    }
    
}

- (void)stopMarquee
{
    [self.titleLabel requestToStopAnimation];
}

- (void)startMarquee
{
    [self.titleLabel requestToStartAnimation];
}

- (void)addNotificationApplication
{
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self stopMarquee];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if (self.viewController.navigationController.topViewController == self.viewController) {
            [self startMarquee];
        }
    }];
}

@end
