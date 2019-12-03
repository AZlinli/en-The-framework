//
//  LYTravelerInformationViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYTravelerInformationViewModel : NSObject
@property(nonatomic, readonly, copy) NSArray *dataArray;

@property(nonatomic, readonly, strong) RACCommand *getDataCommand;
@property(nonatomic, readonly, strong) RACCommand *removeCommand;
@end

NS_ASSUME_NONNULL_END
