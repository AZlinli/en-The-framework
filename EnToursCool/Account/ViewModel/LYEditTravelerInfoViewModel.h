//
//  LYEditTravelerInfoViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYTravelerInformationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYEditTravelerInfoViewModel : NSObject
@property(nonatomic, readonly, strong) RACCommand *saveCommand;
@property(nonatomic, readwrite, strong) NSString *firstName;
@property(nonatomic, readwrite, strong) NSString *lastName;
@property(nonatomic, readwrite, strong) NSString *brithDate;
@property(nonatomic, readwrite, strong) NSString *country;
@property(nonatomic, readwrite, strong) NSString *passport;

- (instancetype)initWithParameter:(NSDictionary *)parameter;
- (instancetype)initWithModel:(LYTravelerInformationModel*)model;
@end

NS_ASSUME_NONNULL_END

