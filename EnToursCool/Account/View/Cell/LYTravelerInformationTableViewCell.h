//
//  LYTravelerInformationTableViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * _Nullable const LYTravelerInformationTableViewCellID;
typedef void (^LYTravelerInformationTableViewCellRemoveBlock)(NSString * _Nullable IDString);
typedef void (^LYTravelerInformationTableViewCellEditBlock)(NSString * _Nullable IDString);
NS_ASSUME_NONNULL_BEGIN

@interface LYTravelerInformationTableViewCell : UITableViewCell
@property (nonatomic, copy) LYTravelerInformationTableViewCellRemoveBlock removeBlock;
@property (nonatomic, copy) LYTravelerInformationTableViewCellEditBlock editBlock;
@end

NS_ASSUME_NONNULL_END
