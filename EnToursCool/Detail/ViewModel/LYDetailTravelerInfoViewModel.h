//
//  LYDetailTravelerInfoViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDetailTravelerInfoViewModel : NSObject
@property(nonatomic, readonly, copy) NSArray *dataArray;
@property(nonatomic, readonly, strong) RACCommand *getDataCommand;

- (instancetype)initWithParameter:(NSDictionary *)parameter;
@end

NS_ASSUME_NONNULL_END
