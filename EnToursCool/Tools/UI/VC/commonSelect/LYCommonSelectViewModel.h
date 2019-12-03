//
//  LYCommonSelectViewModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCommonSelectViewModel : NSObject
@property (nonatomic, readonly, copy) NSArray * dataArray;
@property (nonatomic, readonly, copy) NSDictionary<NSString *, NSArray *>  * dataDictionary;
@property (nonatomic, readonly, copy) RACCommand * httpRequestCountriesCommand;
+ (void)updateCacheAllCountries;

@end

NS_ASSUME_NONNULL_END
