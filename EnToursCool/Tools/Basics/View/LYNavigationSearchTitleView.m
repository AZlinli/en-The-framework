//
//  LYNavigationSearchTitleView.m
//  ToursCool
//
//  Created by tourscool on 12/13/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYNavigationSearchTitleView.h"
#import "UITextField+LYUtil.h"
#import "UIView+LYUtil.h"
#import <Masonry/Masonry.h>

@interface LYNavigationSearchTitleView()<UITextFieldDelegate>
@property (nonatomic, readwrite, strong) UIButton * searchButton;
@property (nonatomic, readwrite, strong) UITextField * searchTextField;
@property (nonatomic, strong) UIView * searchBackView;
@end
@implementation LYNavigationSearchTitleView

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
        _searchBackView = [[UIView alloc] init];
        [self addSubview:_searchBackView];
        _searchBackView.backgroundColor = [LYTourscoolAPPStyleManager ly_EBEBEBColor];
        [_searchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.left.equalTo(self);
            make.height.offset(34.f);
        }];
        _searchBackView.cornerRadius = 17.f;
        
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setImage:[UIImage imageNamed:@"destination_navigation_serach_img"] forState:UIControlStateNormal];
        [self addSubview:_searchButton];
        _searchButton.userInteractionEnabled = NO;
        [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(8.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        _searchTextField = [[UITextField alloc] init];
        [self addSubview:_searchTextField];
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.userInteractionEnabled = NO;
        
        [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.searchButton.mas_right).offset(6.f);
            make.right.equalTo(self.mas_right).offset(-17.f);
        }];
        
        [_searchButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_searchButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_searchButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_searchButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        [_searchTextField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [_searchTextField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        [_searchTextField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [_searchTextField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [_searchBackView addGestureRecognizer:tapGestureRecognizer];
        _searchTextField.userInteractionEnabled = NO;
        _searchTextField.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_14];
        [self setSearchTextPlaceholderColor:@"BFBFBF" content:[LYLanguageManager ly_localizedStringForKey:@"Destination_Search_Placeholder"]];
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            @weakify(self);
        [[tapGestureRecognizer rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            if (self.touchNavigationTitleViewBlock) {
                self.touchNavigationTitleViewBlock();
            }
        }];
    }
    return self;
}



- (void)openSearchTextUserInteractionEnabled
{
    self.searchTextField.userInteractionEnabled = YES;
    self.searchTextField.delegate = self;
}

- (void)setSearchTextColor:(NSString *)hexColor
{
    self.searchTextField.textColor = [UIColor colorWithHexString:hexColor];
}

- (void)setSearchTextPlaceholder:(NSString *)placeholder
{
    if (placeholder.length) {
        self.searchTextField.placeholder = placeholder;
    }
}

- (void)setSearchTextPlaceholderColor:(NSString *)hexColor content:(NSString*)content
{
    [self.searchTextField setPlaceholderWithColor:[UIColor colorWithHexString:hexColor] conent:content font:nil];
}

- (void)setSearchButtonStateNormalImageWithImageName:(NSString *)imageName
{
    [self.searchButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
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
    return CGSizeMake(kScreenWidth - 64.f, 40.f);
}

@end
