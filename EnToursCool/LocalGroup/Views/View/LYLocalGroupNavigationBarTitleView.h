//
//  LYLocalGroupNavigationBarTitleView.h
//  ToursCool
//
//  Created by tourscool on 1/17/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYNavigationBarTitleView.h"
typedef void(^LYUserPrecessNavigationBarTitleViewSearchButtonBlock)(void);
typedef void(^LYUserPrecessNavigationBarTitleViewBackButtonBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface LYLocalGroupNavigationBarTitleView : LYNavigationBarTitleView
@property (nonatomic, copy) LYUserPrecessNavigationBarTitleViewSearchButtonBlock userPrecessNavigationBarTitleViewSearchButtonBlock;
@property (nonatomic, copy) LYUserPrecessNavigationBarTitleViewBackButtonBlock
userPrecessNavigationBarTitleViewBackButtonBlock;
- (void)setTitle:(NSString *)title;
- (void)hiddenSearchButton;
- (void)scrollViewChange:(CGFloat)alpha;

- (void)startMarquee;
- (void)stopMarquee;

@end

NS_ASSUME_NONNULL_END
