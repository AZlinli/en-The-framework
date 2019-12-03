//
//  LYCancelOrderViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCancelOrderViewModel : NSObject
@property(nonatomic, readwrite, copy) NSString *reason;
@property(nonatomic, readwrite, copy) NSString *otherText;
@property(nonatomic, readwrite, copy) NSArray *imageArray;
@property(nonatomic, readonly, strong) RACCommand *submitCommand;

- (instancetype)initWithParameter:(NSDictionary *)parameter;
@end

NS_ASSUME_NONNULL_END
