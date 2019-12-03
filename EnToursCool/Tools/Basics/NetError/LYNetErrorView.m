//
//  LYNetErrorView.m
//  ToursCool
//
//  Created by tourscool on 3/21/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYNetErrorView.h"
#import "UIView+LYNib.h"
#import <Masonry/Masonry.h>

@interface LYNetErrorView ()
@property (nonatomic, weak) IBOutlet UILabel * errorTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel * errorContentLabel;
@property (nonatomic, weak) IBOutlet UIImageView * errorImageView;
@property (nonatomic, weak) IBOutlet UIButton * refreshButton;
@end

@implementation LYNetErrorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    @weakify(self);
    self.errorTitleLabel.text = [LYLanguageManager ly_localizedStringForKey:@"Error_HUD_Network_Failed_Title"];
    self.errorContentLabel.text = [LYLanguageManager ly_localizedStringForKey:@"Error_HUD_Network_Failed_Refresh_Title"];
    [self.refreshButton setTitle:[LYLanguageManager ly_localizedStringForKey:@"Error_HUD_Refresh_Title"] forState:UIControlStateNormal];
    [[self.refreshButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.userProcessRefreshButtonBlock) {
            self.userProcessRefreshButtonBlock();
            [self removeFromSuperview];
        }
    }];
}


- (void)setNetErrorViewContent:(NSString *)content title:(NSString *)title imageName:(NSString *)imageName refreshTitle:(NSString *)refreshTitle fontColor:(UIColor*)fontColor;
{
    if (imageName.length) {
        self.errorImageView.image = [UIImage imageNamed:imageName];
    }
    if (content.length) {
        self.errorContentLabel.text = content;
    }else{
        self.errorContentLabel.hidden = YES;
    }
    if (title.length) {
        self.errorTitleLabel.text = title;
        if (fontColor) {
                self.errorTitleLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_12];
                self.errorTitleLabel.textColor = fontColor;
            }
    }else{
        self.errorTitleLabel.hidden = YES;
    }
    if (refreshTitle.length) {
        [self.refreshButton setTitle:refreshTitle forState:UIControlStateNormal];
    }else{
        self.refreshButton.hidden = YES;
    }
   
}

- (void)setNoDateViewStyle
{
    self.errorImageView.image = [UIImage imageNamed:@"net_error_no_data_img"];
    self.errorTitleLabel.text = [LYLanguageManager ly_localizedStringForKey:@"No_Date_Style_HUD_Title"];
    self.errorContentLabel.text = [LYLanguageManager ly_localizedStringForKey:@"No_Date_Style_HUD_SubTitle"];
    self.refreshButton.hidden = YES;
}

+ (LYNetErrorView *)showNoDataErrorViewWithView:(UIView *)view customConstraints:(BOOL)customConstraints refreshBlock:(void (^)(void))refreshBlock
{
    LYNetErrorView * netErrorView = [LYNetErrorView loadFromNib];
    [view addSubview:netErrorView];
    [netErrorView setNoDateViewStyle];
    if (refreshBlock) {
        [netErrorView setUserProcessRefreshButtonBlock:^{
            refreshBlock();
        }];
    }
    if (customConstraints) {
        
    }else{
        [LYNetErrorView setNetErrorViewConstraints:0 bottom:0 netErrorView:netErrorView view:view];
    }
    return netErrorView;
}

+ (LYNetErrorView *)showNetErrorViewWithView:(UIView *)view customConstraints:(BOOL)customConstraints refreshBlock:(void (^)(void))refreshBlock
{
    LYNetErrorView * netErrorView = [LYNetErrorView loadFromNib];
    [view addSubview:netErrorView];
    if (refreshBlock) {
        [netErrorView setUserProcessRefreshButtonBlock:^{
            refreshBlock();
        }];
    }
    if (customConstraints) {
        
    }else{
        [LYNetErrorView setNetErrorViewConstraints:0 bottom:0 netErrorView:netErrorView view:view];
    }
    return netErrorView;
}

+ (void)setNetErrorViewConstraints:(CGFloat)top bottom:(CGFloat)bottom netErrorView:(LYNetErrorView *)netErrorView view:(UIView *)view
{
    if (top > 0 && bottom > 0) {
        [netErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(top);
            make.bottom.equalTo(view.mas_bottom).offset(bottom);
            make.left.right.equalTo(view);
        }];
    }else if (top > 0) {
        [netErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(top);
            make.left.right.bottom.equalTo(view);
        }];
    }else if (bottom > 0) {
        [netErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view.mas_bottom).offset(bottom);
            make.left.right.top.equalTo(view);
        }];
    }else{
        [netErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(view);
        }];
    }
}

+ (void)setNetErrorViewContent:(NSString *)content title:(NSString *)title imageName:(NSString *)imageName netErrorView:(LYNetErrorView *)netErrorView
{
    [netErrorView setNetErrorViewContent:content title:title imageName:imageName refreshTitle:nil fontColor:nil];
}

+ (void)setNetErrorViewContent:(NSString *)content title:(NSString *)title imageName:(NSString *)imageName netErrorView:(LYNetErrorView *)netErrorView fontColor:(UIColor *)color{
    [netErrorView setNetErrorViewContent:content title:title imageName:imageName refreshTitle:nil fontColor:color];
}

+ (void)setNetErrorViewContent:(NSString *)content title:(NSString *)title imageName:(NSString *)imageName netErrorView:(LYNetErrorView *)netErrorView refreshTitle:(NSString *)refreshTitle
{
    [netErrorView setNetErrorViewContent:content title:title imageName:imageName refreshTitle:refreshTitle fontColor:nil];
}

+ (void)removeNetErrorViewWithView:(UIView *)view
{
    for (UIView * subView in view.subviews) {
        if ([subView isKindOfClass:[LYNetErrorView class]]) {
            [subView removeFromSuperview];
        }
    }
}

@end
