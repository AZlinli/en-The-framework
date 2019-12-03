//
//  LYLoginViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYLoginViewModel : NSObject
@property (nonatomic, readonly, strong) RACCommand * loginCommand;

@property (nonatomic, copy) NSString *  userAccounts;

@property (nonatomic, copy) NSString *  userPWD;
@end

NS_ASSUME_NONNULL_END
