//
//  LYAccountViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAccountViewModel : NSObject
@property(nonatomic, readonly, copy) NSArray *dataArray;
@property(nonatomic, readonly, copy) NSString *headImage;
@property(nonatomic, readonly, copy) NSString *name;
@property(nonatomic, readonly, copy) NSString *point;
@end

NS_ASSUME_NONNULL_END
