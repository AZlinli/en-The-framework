//
//  LYSearchVCNavigationTitleView.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYSearchVCNavigationTitleView.h"
#import "UIView+LYUtil.h"
#import <Masonry/Masonry.h>
#import "UITextField+LYUtil.h"

@interface LYSearchVCNavigationTitleView()<UITextFieldDelegate>
@property (nonatomic, readwrite, strong) UIButton * searchButton;
@property (nonatomic, readwrite, strong) UITextField * searchTextField;
@property (nonatomic, strong) UIView * searchBackView;
@end

@implementation LYSearchVCNavigationTitleView


- (instancetype)init{
    self = [super init];
    if (self) {
        _searchBackView = [[UIView alloc] init];
        [self addSubview:_searchBackView];
        _searchBackView.backgroundColor = [LYTourscoolAPPStyleManager ly_EBEBEBColor];
        [_searchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.left.equalTo(self);
            make.height.offset(30.f);
        }];
        _searchBackView.cornerRadius = 4.f;
        
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
        [self addSubview:_searchButton];
        _searchButton.userInteractionEnabled = NO;
        [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        _searchTextField = [[UITextField alloc] init];
        [self addSubview:_searchTextField];
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.userInteractionEnabled = YES;
        
        [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.searchButton.mas_right).offset(10.f);
            make.right.equalTo(self.mas_right).offset(-15.f);
        }];
        
        [_searchButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
       [_searchButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
       [_searchButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
       [_searchButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
       
       [_searchTextField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
       [_searchTextField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
       [_searchTextField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
       [_searchTextField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        
//        UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
//       [_searchBackView addGestureRecognizer:tapGestureRecognizer];
        _searchTextField.delegate = self;
       _searchTextField.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_16];
        [self setSearchTextPlaceholderColor:@"999999" content:nil];
       _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//           @weakify(self);
//       [[tapGestureRecognizer rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
//           @strongify(self);
////           if (self.touchNavigationTitleViewBlock) {
////               self.touchNavigationTitleViewBlock();
////           }
//       }];
    }
    return self;
}

- (void)setSearchTextPlaceholderColor:(NSString *)hexColor content:(NSString*)content
{
    [self.searchTextField setPlaceholderWithColor:[UIColor colorWithHexString:hexColor] conent:content font:nil];
}

- (void)setSearchTextPlaceholder:(NSString *)placeholder
{
    if (placeholder.length) {
        self.searchTextField.placeholder = placeholder;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.navigationTitleViewSearchTextFieldReturnBlock) {
        self.navigationTitleViewSearchTextFieldReturnBlock(textField.text);
    }
    [textField endEditing:YES];
    return YES;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(kScreenWidth - 130.f, 40.f);
}

@end
