//
//  LYCanOrderOtherTableViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * _Nullable const LYCanOrderOtherTableViewCellID;
NS_ASSUME_NONNULL_BEGIN

@protocol LYCanOrderOtherTableViewCellDelegate <NSObject>

@optional

- (void)modifyImage:(NSArray*)imageArray;
- (void)textViewReturnData:(NSString*)text;
@end

@interface LYCanOrderOtherTableViewCell : UITableViewCell
@property (nonatomic, weak) id<LYCanOrderOtherTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END



