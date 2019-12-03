//
//  LYDetailCommonSectionHeaderView.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString * _Nullable const LYDetailCommonSectionHeaderViewID;

@interface LYDetailCommonSectionHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;

@end

NS_ASSUME_NONNULL_END
