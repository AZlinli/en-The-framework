//
//  LYCommitCommentTableViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString * _Nullable const LYCommitCommentTableViewCellID;
NS_ASSUME_NONNULL_BEGIN

@protocol LYCommitCommentTableViewCellDelegate <NSObject>

@optional

- (void)clickStarView:(NSDictionary*)dic;

@end

@interface LYCommitCommentTableViewCell : UITableViewCell
@property (nonatomic, weak) id<LYCommitCommentTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
