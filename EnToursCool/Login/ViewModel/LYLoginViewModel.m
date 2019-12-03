//
//  LYLoginViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYLoginViewModel.h"
#import "NSString+LYTool.h"
#import "LYHTTPRequestManager.h"
#import "LYUserInfoManager.h"
#import "LYUserInfoModel.h"

@interface LYLoginViewModel()
@property (nonatomic, readwrite, strong) RACCommand * loginCommand;

@property (nonatomic, readwrite, strong) RACCommand * obtainUserInfoCommand;
@end

@implementation LYLoginViewModel

- (RACCommand *)loginCommand{
    if (!_loginCommand) {
        @weakify(self);

        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            if(self.userAccounts.length == 0){
                return [RACSignal return:@{@"code":@"1",@"type":@"1"}];
            }
            if ([NSString verifyPhoneOrEmail:self.userAccounts] != PhoneOrEmailVerifyTypeEmail) {
                return [RACSignal return:@{@"code":@"1",@"type":@"3"}];
            }
            
            if (self.userPWD.length == 0) {
                return [RACSignal return:@{@"code":@"1",@"type":@"2"}];
            }
            
            if (self.userPWD.length <= 5 || ![self.userPWD validationPasswordStrength]) {
                return [RACSignal return:@{@"code":@"1",@"type":@"4"}];
            }
            return [[LYHTTPRequestManager HTTPPostRequestWithAction:LY_HTTP_Version_1(@"login") parameter:@{@"email":self.userAccounts,@"password":self.userPWD} cacheType:NO] map:^id _Nullable(id  _Nullable value) {
                LYNSLog(@"OauthLoginAction - %@", value);
                if ([value[@"code"] integerValue] == 0) {
                    NSString * token = [NSString stringWithFormat:@"%@", value[@"data"][@"token"]];
                    if (token.length) {
                        [self saveUserEmailLoginAccount];
//                        [self loginSuccessUpdateDataWithToken:token]; //todo
                    }
                }
                return value;
            }];
            
        }];
        
    }
    return _loginCommand;
}

- (void)saveUserEmailLoginAccount
{
    if (self.userAccounts.length) {
        [[NSUserDefaults standardUserDefaults] setObject:self.userAccounts forKey:kLoginUserAccount];
    }
}

- (void)loginSuccessUpdateDataWithToken:(NSString *)token
{
    [LYUserInfoManager saveUserTokenWith:token];
    [LYHTTPRequestManager setSessionManagerValue:token forHTTPHeaderField:@"Authorization"];
    [self.obtainUserInfoCommand execute:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginSuccessfulIdentifier object:nil];
}


- (RACCommand *)obtainUserInfoCommand
{
    if (!_obtainUserInfoCommand) {
        _obtainUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(@"profile") parameter:@{} cacheType:NO] map:^id _Nullable(id  _Nullable value) {
                LYNSLog(@"UserInfo - %@", value);
                if ([value[@"code"] integerValue] == 0) {
                    [LYUserInfoManager saveUserInfoWithUserInfo:[LYUserInfoModel mj_objectWithKeyValues:value[@"data"]]];
                    if ([LYUserInfoManager sharedUserInfoManager].userInfoModel) {
                        NSString * face = [LYUserInfoManager sharedUserInfoManager].userInfoModel.face;
                        if (face.length) {
                            [[NSUserDefaults standardUserDefaults] setObject:face forKey:LYUserFace];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                        }
                    }
                }
                return value;
            }];
        }];
    }
    return _obtainUserInfoCommand;
}
@end
