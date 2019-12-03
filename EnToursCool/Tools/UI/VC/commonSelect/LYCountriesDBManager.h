//
//  LYCountriesDBManager.h
//  EnToursCool
//
//  Created by Lin Li on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDBManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYCountriesDBManager : LYDBManager
+ (void)createCountriesTable;
+ (void)insertAllCountries:(NSArray *)countries;

@end

NS_ASSUME_NONNULL_END
