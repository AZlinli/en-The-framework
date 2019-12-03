//
//  LYRouteSectionHeader.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString * _Nullable const LYRouteSectionHeaderViewID;

typedef void(^LYUserTapRouteSectionHeaderViewBlock)(void);

@interface LYRouteSectionHeader : UITableViewHeaderFooterView
@property (nonatomic, copy) LYUserTapRouteSectionHeaderViewBlock userTapRouteSectionHeaderViewBlock;

@end

NS_ASSUME_NONNULL_END
