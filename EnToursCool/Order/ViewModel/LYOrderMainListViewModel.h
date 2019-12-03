//
//  LYOrderMainListViewModel.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYOrderMainListViewModel : NSObject

@property (nonatomic, readonly , copy) NSArray * dataArray;

@property (nonatomic, strong) RACCommand *mainOrderCommand;

@property (nonatomic, readonly, strong) RACCommand *removeCommand;

- (instancetype)initWithParameter:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
