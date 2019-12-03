//
//  LYResetPWDViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYResetPWDViewModel : NSObject
@property (nonatomic, readonly, strong) RACCommand *saveCommand;

@property (nonatomic, copy) NSString *  currentPWD;
@property (nonatomic, copy) NSString *  userPWD1;
@property (nonatomic, copy) NSString *  userPWD2;
@end

NS_ASSUME_NONNULL_END
