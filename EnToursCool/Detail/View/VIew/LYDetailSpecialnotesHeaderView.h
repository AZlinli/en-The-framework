//
//  LYDetailSpecialnotesHeaderView.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/28.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString * _Nullable const LYDetailSpecialnotesHeaderViewID;

typedef void(^LYUserTapSpecialnotesSectionHeaderViewBlock)(void);

@interface LYDetailSpecialnotesHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) LYUserTapSpecialnotesSectionHeaderViewBlock userTapSpecialnotesSectionHeaderViewBlock;

@end

NS_ASSUME_NONNULL_END
