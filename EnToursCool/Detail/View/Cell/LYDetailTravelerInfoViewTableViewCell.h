//
//  LYDetailTravelerInfoViewTableViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * _Nullable const LYDetailTravelerInfoViewTableViewCellID;
typedef void (^LYTravelerInformationTableViewCellEditBlock)(NSString * _Nullable IDString);
typedef void (^LYTravelerInformationTableViewCellSelectedBlock)(NSString * _Nullable IDString);
NS_ASSUME_NONNULL_BEGIN

@interface LYDetailTravelerInfoViewTableViewCell : UITableViewCell
@property (nonatomic, copy) LYTravelerInformationTableViewCellEditBlock editBlock;
@property (nonatomic, copy) LYTravelerInformationTableViewCellSelectedBlock selectedBlock;
@end

NS_ASSUME_NONNULL_END
