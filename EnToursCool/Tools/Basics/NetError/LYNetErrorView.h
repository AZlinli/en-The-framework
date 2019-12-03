//
//  LYNetErrorView.h
//  ToursCool
//
//  Created by tourscool on 3/21/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYUserProcessRefreshButtonBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LYNetErrorView : UIView

@property (nonatomic, copy) LYUserProcessRefreshButtonBlock userProcessRefreshButtonBlock;

+ (void)setNetErrorViewContent:(NSString * _Nullable)content title:(NSString * _Nullable)title imageName:(NSString * _Nullable)imageName netErrorView:(LYNetErrorView *)netErrorView;
+ (LYNetErrorView *)showNetErrorViewWithView:(UIView *)view customConstraints:(BOOL)customConstraints refreshBlock:(void (^)(void))refreshBlock;
+ (LYNetErrorView *)showNoDataErrorViewWithView:(UIView *)view customConstraints:(BOOL)customConstraints refreshBlock:(void (^)(void))refreshBlock;

+ (void)setNetErrorViewConstraints:(CGFloat)top bottom:(CGFloat)bottom netErrorView:(LYNetErrorView *)netErrorView view:(UIView *)view;

+ (void)setNetErrorViewContent:(NSString * _Nullable)content title:(NSString *)title imageName:(NSString *)imageName netErrorView:(LYNetErrorView *)netErrorView fontColor:(UIColor *)color;

+ (void)removeNetErrorViewWithView:(UIView *)view;

- (void)setNoDateViewStyle;
@end

NS_ASSUME_NONNULL_END
