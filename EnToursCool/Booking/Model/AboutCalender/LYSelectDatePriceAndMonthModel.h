//
//  LYDateSelectPriceAndMonthModel.h
//  ToursCool
//
//  Created by tourscool on 11/2/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSelectDatePriceAndMonthModel : LYBaseModel
@property (nonatomic, copy) NSString * month;
@property (nonatomic, copy) NSString * monthDate;
@property (nonatomic, strong) NSDate * date;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * years;
@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
