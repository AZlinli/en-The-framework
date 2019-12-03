//
//  LYDetailHighlightsTableViewCell.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString * _Nullable const LYDetailHighlightsTableViewCellID;

typedef void(^SeeMoreButtonBlock)(void);

@interface LYDetailHighlightsTableViewCell : UITableViewCell
/**点击按钮的回调*/
@property(nonatomic, copy) SeeMoreButtonBlock seeMoreButtonBlock;

@end

NS_ASSUME_NONNULL_END
