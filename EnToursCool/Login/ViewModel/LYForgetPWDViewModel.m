//
//  LYForgetPWDViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYForgetPWDViewModel.h"
#import "NSString+LYTool.h"
#import "LYHTTPRequestManager.h"

@interface LYForgetPWDViewModel()
@property (nonatomic, readwrite, strong) RACCommand *resetCommand;
@end

@implementation LYForgetPWDViewModel

- (RACCommand *)resetCommand{
    if (!_resetCommand) {
        _resetCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            if(self.userAccounts.length == 0){
                return [RACSignal return:@{@"code":@"1",@"type":@"1"}];
            }
            if ([NSString verifyPhoneOrEmail:self.userAccounts] != PhoneOrEmailVerifyTypeEmail) {
                return [RACSignal return:@{@"code":@"1",@"type":@"2"}];
            }
            
            //test
            return [RACSignal return:@{@"code":@"0",@"type":@"2"}];
            
//            return [[LYHTTPRequestManager HTTPPostRequestWithAction:LY_HTTP_Version_1(@"login") parameter:@{@"email":self.userAccounts} cacheType:NO] map:^id _Nullable(id  _Nullable value) {
//                LYNSLog(@"OauthLoginAction - %@", value);
//                if ([value[@"code"] integerValue] == 0) {
//                    NSString * token = [NSString stringWithFormat:@"%@", value[@"data"][@"token"]];
//                    if (token.length) {
////                        [self saveUserEmailLoginAccount];
////                        [self loginSuccessUpdateDataWithToken:token]; //todo
//                    }
//                }
//                return value;
//            }];
        }];
    }
    return _resetCommand;
}

@end
