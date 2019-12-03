//
//  LYNavigationSearchTitleView.h
//  ToursCool
//
//  Created by tourscool on 12/13/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LYNavigationTitleViewSearchTextFieldReturnBlock)(NSString * _Nullable searchTitle);
typedef void (^LYTouchNavigationTitleViewBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface LYNavigationSearchTitleView : UIView
@property (nonatomic, readonly, strong) UIButton * searchButton;
@property (nonatomic, readonly, strong) UITextField * searchTextField;
@property (nonatomic, copy) LYNavigationTitleViewSearchTextFieldReturnBlock navigationTitleViewSearchTextFieldReturnBlock;
@property (nonatomic, copy) LYTouchNavigationTitleViewBlock touchNavigationTitleViewBlock;
- (void)openSearchTextUserInteractionEnabled;

- (void)setSearchTextColor:(NSString *)hexColor;

- (void)setSearchTextPlaceholder:(NSString *)placeholder;
- (void)setSearchButtonStateNormalImageWithImageName:(NSString *)imageName;

- (void)setSearchTextPlaceholderColor:(NSString *)hexColor content:(NSString*)content;

@end

NS_ASSUME_NONNULL_END
