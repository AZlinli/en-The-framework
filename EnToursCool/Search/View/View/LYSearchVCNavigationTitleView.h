//
//  LYSearchVCNavigationTitleView.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LYNavigationTitleViewSearchTextFieldReturnBlock)(NSString * _Nullable searchTitle);
NS_ASSUME_NONNULL_BEGIN

@interface LYSearchVCNavigationTitleView : UIView
@property (nonatomic, copy) LYNavigationTitleViewSearchTextFieldReturnBlock navigationTitleViewSearchTextFieldReturnBlock;
@property (nonatomic, readonly, strong) UIButton * searchButton;
@property (nonatomic, readonly, strong) UITextField * searchTextField;
- (void)setSearchTextPlaceholder:(NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
