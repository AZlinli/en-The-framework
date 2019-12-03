//
//  LYSelectDatePriceModel.h
//  ToursCool
//
//  Created by tourscool on 11/2/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSelectDatePriceModel : LYBaseModel
@property (nonatomic, copy) NSString * day;
@property (nonatomic, copy) NSString * month;
@property (nonatomic, copy) NSString * years;
@property (nonatomic, copy) NSString * dateString;
@property (nonatomic, strong) NSDate * date;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * isSoldout;
@property (nonatomic, copy) NSString * isSpecial;
@property (nonatomic, copy) NSString * isOverride;
@end

NS_ASSUME_NONNULL_END
