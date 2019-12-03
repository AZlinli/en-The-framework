//
//  LYProductListVCNavigationTitleView.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LYGoSearchVCBlock)(void);
typedef void (^LYProductListVCNavigationTitleViewSearchTextFieldReturnBlock)(NSString * _Nullable searchTitle);
NS_ASSUME_NONNULL_BEGIN

@interface LYProductListVCNavigationTitleView : UIView
@property (nonatomic, copy) LYGoSearchVCBlock goSearchVCBlock;
@property (nonatomic, copy) LYProductListVCNavigationTitleViewSearchTextFieldReturnBlock searchReturnBlock;
@property (nonatomic, readonly, weak) UITextField * searchTextField;
@property (nonatomic, assign) BOOL isCurrentSearch;//是否在当前页面搜索
@end

NS_ASSUME_NONNULL_END
