//
//  LYUserInfoModel.h
//  ToursCool
//
//  Created by tourscool on 11/13/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUserInfoModel : NSObject
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * chineseName;
@property (nonatomic, copy) NSString * customerID;
@property (nonatomic, copy) NSString * dob;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * face;
@property (nonatomic, copy) NSString * firstName;
@property (nonatomic, copy) NSString * lastName;
@property (nonatomic, copy) NSString * gender;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * telCode;
@property (nonatomic, copy) NSString * totalPoints;
@property (nonatomic, copy) NSString * exchangePrice;
@property (nonatomic, copy) NSString * isPassword;
@property (nonatomic, copy) NSString * totalCoupons;
@property (nonatomic, copy) NSString * grade;

/**
 YES 未读 NO 已读
 */
@property (nonatomic, assign) BOOL redUnpay;
/**
 YES 未读 NO 已读
 */
@property (nonatomic, assign) BOOL redCoupons;

/**
 是否新用户

 @return YES 是 NO 否
 */
- (BOOL)ly_newUser;

- (void)updateUserInfoWithUserInfoModel:(LYUserInfoModel *)userInfoModel;

@end

NS_ASSUME_NONNULL_END
