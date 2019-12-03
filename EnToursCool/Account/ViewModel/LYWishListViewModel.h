//
//  LYWishListViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYWishListViewModel : NSObject
@property (nonatomic, readonly, strong) RACCommand *getDataCommand;
@property (nonatomic, readonly, strong) RACCommand * deleteItemsCommand;
@property(nonatomic, readonly, copy) NSArray *dataArray;
@property (nonatomic, readonly, strong) NSNumber *isSelectedAll;
@property (nonatomic, readonly, copy) NSArray *deleteArray;
@end

NS_ASSUME_NONNULL_END
