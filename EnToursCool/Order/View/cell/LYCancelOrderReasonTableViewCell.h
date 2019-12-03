//
//  LYCancelOrderReasonTableViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * _Nullable const LYCancelOrderReasonTableViewCellID;

NS_ASSUME_NONNULL_BEGIN

@protocol LYCancelOrderReasonTableViewCellDelegate <NSObject>

@optional

- (void)clickReason:(NSString*)reason;
@end

@interface LYCancelOrderReasonTableViewCell : UITableViewCell
@property (nonatomic, weak) id<LYCancelOrderReasonTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END



