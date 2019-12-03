//
//  LYResetPWDViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYResetPWDViewModel.h"
#import "NSString+LYTool.h"
#import "LYHTTPRequestManager.h"

@interface LYResetPWDViewModel ()
@property (nonatomic, readwrite, strong) RACCommand *saveCommand;
@end

@implementation LYResetPWDViewModel

- (RACCommand *)saveCommand{
    if (!_saveCommand) {
        @weakify(self);

        _saveCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            if(self.currentPWD.length == 0){
                return [RACSignal return:@{@"code":@"1",@"type":@"1"}];
            }
            
            if (self.userPWD1.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"2"}];
            }
            
            if (self.currentPWD.length <= 5 || ![self.currentPWD validationPasswordStrength]) {
                return [RACSignal return:@{@"code":@"1",@"type":@"3"}];
            }
            
            if (self.userPWD1.length <= 5 || ![self.userPWD1 validationPasswordStrength]) {
                return [RACSignal return:@{@"code":@"1",@"type":@"4"}];
            }
            
            if (self.userPWD2.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"5"}];
            }
            
            if (self.userPWD2.length <= 5 || ![self.userPWD2 validationPasswordStrength]) {
                return [RACSignal return:@{@"code":@"1",@"type":@"6"}];
            }
            
            if (![self.userPWD2 isEqualToString: self.userPWD1]) {
                return [RACSignal return:@{@"code":@"1",@"type":@"7"}];
            }
            
            
             return [RACSignal return:@{@"code":@"0",@"type":@"200"}];
            
        
//            return [[LYHTTPRequestManager HTTPPostRequestWithAction:LY_HTTP_Version_1(@"login") parameter:@{@"email":self.userAccounts,@"password":self.userPWD} cacheType:NO] map:^id _Nullable(id  _Nullable value) {
//                LYNSLog(@"OauthLoginAction - %@", value);
//                if ([value[@"code"] integerValue] == 0) {
//                    NSString * token = [NSString stringWithFormat:@"%@", value[@"data"][@"token"]];
//                    if (token.length) {
//                        [self saveUserEmailLoginAccount];
////                        [self loginSuccessUpdateDataWithToken:token]; //todo
//                    }
//                }
//                return value;
//            }];
            
        }];
        
    }
    return _saveCommand;
}
@end
