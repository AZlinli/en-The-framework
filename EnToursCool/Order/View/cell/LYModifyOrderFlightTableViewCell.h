//
//  LYModifyOrderFlightTableViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString * _Nullable const LYModifyOrderFlightTableViewCellID;
NS_ASSUME_NONNULL_BEGIN

@protocol LYModifyOrderFlightTableViewCellDelegate <NSObject>

@optional

- (void)textViewReturnData:(NSString*)text type:(NSString*)type;
@end


@interface  LYModifyOrderFlightTableViewCell: UITableViewCell
@property (nonatomic, weak) id<LYModifyOrderFlightTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

