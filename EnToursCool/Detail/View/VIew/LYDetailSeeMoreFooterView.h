//
//  LYDetailSeeMoreFooterView.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/28.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString * _Nullable const LYDetailSeeMoreFooterViewID;
typedef void(^FooterSeeMoreButtonBlock)(void);

@interface LYDetailSeeMoreFooterView : UITableViewHeaderFooterView
/**点击按钮的回调*/
@property(nonatomic, copy) FooterSeeMoreButtonBlock footerSeeMoreButtonBlock;

@end

NS_ASSUME_NONNULL_END
