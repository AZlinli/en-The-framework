//
//  LYProductListVCNavigationTitleView.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListVCNavigationTitleView.h"
#import "UIView+LYUtil.h"
#import <Masonry/Masonry.h>
#import "UITextField+LYUtil.h"

@interface LYProductListVCNavigationTitleView ()<UITextFieldDelegate>
@property (nonatomic, readwrite, strong) UIButton * searchButton;
@property (nonatomic, readwrite, weak) UITextField * searchTextField;
@property (nonatomic, strong) UIView * searchBackView;
@end

@implementation LYProductListVCNavigationTitleView
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
        
        UITextField *searchTextField = [[UITextField alloc] init];
        [self addSubview:searchTextField];
        searchTextField.returnKeyType = UIReturnKeySearch;
        searchTextField.userInteractionEnabled = YES;
        
        [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.searchButton.mas_right).offset(10.f);
            make.right.equalTo(self.mas_right).offset(-15.f);
        }];
        
        self.searchTextField = searchTextField;
        
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
//        [self setSearchTextPlaceholderColor:@"999999" content:nil];
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

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (self.isCurrentSearch && self.searchReturnBlock) {
//        self.searchReturnBlock(textField.text);
//    }
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.isCurrentSearch && self.searchReturnBlock) {
        self.searchReturnBlock(textField.text);
    }
    [textField endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   if (self.goSearchVCBlock && !self.isCurrentSearch) {
        self.goSearchVCBlock();
    }
    return NO;
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(kScreenWidth - 100.f, 40.f);
}
@end
