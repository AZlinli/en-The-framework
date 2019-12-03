//
//  LYOrderListModel.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/26.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYOrderListModel : LYBaseModel

@property (nonatomic , copy) NSString * createDate;
@property (nonatomic , copy) NSString * statusName;
@property (nonatomic , copy) NSString * travelID;


@end

NS_ASSUME_NONNULL_END
