//
//  LYDetailExpenseTableViewCell.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/28.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString * _Nullable const LYDetailExpenseTableViewCellID;
typedef void(^ExpenseSeeMoreButtonBlock)(void);

@interface LYDetailExpenseTableViewCell : UITableViewCell
/**点击按钮的回调*/
@property(nonatomic, copy) ExpenseSeeMoreButtonBlock expenseSeeMoreButtonBlock;
@end

NS_ASSUME_NONNULL_END
