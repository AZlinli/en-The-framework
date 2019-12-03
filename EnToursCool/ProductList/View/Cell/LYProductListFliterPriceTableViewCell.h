//
//  LYProductListFliterPriceTableViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * _Nullable const LYProductListFliterPriceTableViewCellID;

NS_ASSUME_NONNULL_BEGIN

@interface LYProductListFliterPriceTableViewCell : UITableViewCell

@property(nonatomic, weak) UITextField *startPriceTextField;
@property(nonatomic, weak) UITextField *endPriceTextField;

@end

NS_ASSUME_NONNULL_END
