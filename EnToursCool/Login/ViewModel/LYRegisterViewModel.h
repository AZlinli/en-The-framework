//
//  LYRegisterViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYRegisterViewModel : NSObject
@property (nonatomic, readonly, strong) RACCommand * setupCommand;
@property (nonatomic, copy) NSString *  userAccounts;
@property (nonatomic, copy) NSString *  userName;
@property (nonatomic, copy) NSString *  userPWD1;
@property (nonatomic, copy) NSString *  userPWD2;
@end

NS_ASSUME_NONNULL_END
