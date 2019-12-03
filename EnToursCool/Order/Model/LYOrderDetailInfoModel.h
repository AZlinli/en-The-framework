//
//  LYOrderDetailInfoModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYOrderDetailInfoModel : NSObject
@property(nonatomic, copy) NSString *purchaseTime;
@property(nonatomic, copy) NSString *orderNumber;
@property(nonatomic, copy) NSString *price;
@end

@interface LYOrderDetailTravelPackageModel : NSObject
@property(nonatomic, copy) NSString *orderStatus;
@property(nonatomic, copy) NSString *productTitle;
@property(nonatomic, copy) NSString *productID;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *valueAddedService;
@property(nonatomic, copy) NSString *traveler;
//contact
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *email;

@property(nonatomic, assign) BOOL isFlight;//是否有接驳服务
@property(nonatomic, copy) NSString *arrivalAirline;
@property(nonatomic, copy) NSString *arrivalFlightNumber;
@property(nonatomic, copy) NSString *arrivalLandingAirport;
@property(nonatomic, copy) NSString *arrivalTime;

@property(nonatomic, copy) NSString *departureAirline;
@property(nonatomic, copy) NSString *departureFlightNumber;
@property(nonatomic, copy) NSString *departureLandingAirport;
@property(nonatomic, copy) NSString *departureTime;




@property(nonatomic, assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
