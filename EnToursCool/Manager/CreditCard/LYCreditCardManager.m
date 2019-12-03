//
//  LYCreditCardManager.m
//  ToursCool
//
//  Created by tourscool on 1/8/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYCreditCardManager.h"
#import "LYToursCoolConfigurationHeader.h"
#import <AuthorizeNetAccept/AuthorizeNetAccept-Swift.h>

@implementation LYCreditCardManager

+ (RACSignal *)obtainUserCreditCardWihtUserCardMSG:(NSDictionary *)userCardMSG
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [LYCreditCardManager obtainUserCreditCardWihtUserCardMSG:userCardMSG success:^(NSString * _Nonnull token) {
            [subscriber sendNext:@{@"data":token, @"code":@"0"}];
            [subscriber sendCompleted];
        } failure:^(id  _Nonnull error) {
            [subscriber sendNext:@{@"msg":error, @"code":@"1"}];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

+ (void)obtainUserCreditCardWihtUserCardMSG:(NSDictionary *)userCardMSG success:(nullable void (^)(NSString *token))success failure:(nullable void (^)(id error))failure
{
    NSString * cardNumber = userCardMSG[@"cardNumber"];
    NSString * expirationMonth = userCardMSG[@"expirationMonth"];
    NSString * expirationYear = userCardMSG[@"expirationYear"];
    NSString * cardCode = userCardMSG[@"cardCode"];
    if (!cardNumber.length) {
        if (failure) {
            failure(@"请填写信用卡号");
        }
        return;
    }
    if (!expirationMonth.length) {
        if (failure) {
            failure(@"请填写信用卡月份");
        }
        return;
    }
    if (!expirationYear.length) {
        if (failure) {
            failure(@"请填写信用卡年");
        }
        return;
    }
    if (!expirationYear.length) {
        if (failure) {
            failure(@"请填写信用卡效验码");
        }
        return;
    }
    AcceptSDKEnvironment acceptSDKEnvironment = AcceptSDKEnvironmentENV_LIVE;
#ifdef DEBUG
    acceptSDKEnvironment = AcceptSDKEnvironmentENV_TEST;
#else
    acceptSDKEnvironment = AcceptSDKEnvironmentENV_LIVE;
#endif
    
    AcceptSDKHandler *handler = [[AcceptSDKHandler alloc] initWithEnvironment:acceptSDKEnvironment];
    AcceptSDKRequest *request = [[AcceptSDKRequest alloc] init];
    request.merchantAuthentication.name = AcceptSDKName;
    request.merchantAuthentication.clientKey = AcceptSDKClientKey;
    request.securePaymentContainerRequest.webCheckOutDataType.token.cardNumber = cardNumber;
    request.securePaymentContainerRequest.webCheckOutDataType.token.expirationMonth = expirationMonth;
    request.securePaymentContainerRequest.webCheckOutDataType.token.expirationYear = expirationYear;
    request.securePaymentContainerRequest.webCheckOutDataType.token.cardCode = cardCode;
    [handler getTokenWithRequest:request successHandler:^(AcceptSDKTokenResponse * _Nonnull response) {
        if (success) {
            success(response.getOpaqueData.getDataValue);
        }
    } failureHandler:^(AcceptSDKErrorResponse * _Nonnull errorResponse) {
        if (failure) {
            LYNSLog(@"getMessages -- %@", [[errorResponse getMessages] getMessages][0].getCode);
            LYNSLog(@"getMessages -- %@", [[errorResponse getMessages] getMessages][0].getText);
            failure([[errorResponse getMessages] getMessages][0].getText);
        }
    }];
}

+ (NSString * )validInputsCardNumber:(NSString *)cardNumber expirationMonth:(NSString *)expirationMonth expirationYear:(NSString *)expirationYear
{
    AcceptSDKCardFieldsValidator * acceptSDKCardFieldsValidator = [[AcceptSDKCardFieldsValidator alloc] init];
    
    if (![acceptSDKCardFieldsValidator validateCardWithLuhnAlgorithm:cardNumber]) {
        return @"卡号错误!";
    }
    
    if (![acceptSDKCardFieldsValidator validateExpirationDate:expirationMonth inYear:expirationYear]) {
        return @"日期错误!";
    }
    return nil;
}

@end
