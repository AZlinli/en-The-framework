//
//  LYProductListViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYProductListViewModel : NSObject
@property(nonatomic, readonly, copy) NSArray *dataArray;

@property(nonatomic, readonly, copy) NSArray *sortArray;
@property(nonatomic, readonly, copy) NSArray *durationArray;
@property(nonatomic, readonly, copy) NSArray *fliterArray;
@property(nonatomic, readonly, copy) RACCommand *getDataCommand;

- (instancetype)initWithParameter:(NSDictionary *)parameter;

-(void)buildFliterParameter;
@end

NS_ASSUME_NONNULL_END
