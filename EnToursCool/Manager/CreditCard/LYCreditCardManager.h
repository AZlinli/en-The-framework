//
//  LYCreditCardManager.h
//  ToursCool
//
//  Created by tourscool on 1/8/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCreditCardManager : NSObject
+ (RACSignal *)obtainUserCreditCardWihtUserCardMSG:(NSDictionary *)userCardMSG;
/**
 信用卡支付

 @param userCardMSG 必填 cardNumber expirationMonth expirationYear cardCode
 @param success 回调
 @param failure 回调
 */
+ (void)obtainUserCreditCardWihtUserCardMSG:(NSDictionary *)userCardMSG success:(nullable void (^)(NSString *token))success failure:(nullable void (^)(id error))failure;
+ (NSString * )validInputsCardNumber:(NSString *)cardNumber expirationMonth:(NSString *)expirationMonth expirationYear:(NSString *)expirationYear;
@end

NS_ASSUME_NONNULL_END
