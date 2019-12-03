//
//  LYTourscoolBasicsTableViewController.h
//  ToursCool
//
//  Created by tourscool on 1/29/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYNetWorkErrorBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LYTourscoolBasicsTableViewController : UITableViewController

@property (nonatomic, copy) LYNetWorkErrorBlock netWorkErrorBlock;

/**
 登录成功
 */
- (void)userLoginSuccess;
- (void)addUserLoginSuccessNotification;

/**
 错误提示没有 网络或者网络请求错误
 */
- (void)showNetErrorView;
/**
 没有数据显示 或者 code != 0
 */
- (void)showNetErrorViewNoData;
- (void)removeNetErrorView;
- (void)startMarqueeWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END



