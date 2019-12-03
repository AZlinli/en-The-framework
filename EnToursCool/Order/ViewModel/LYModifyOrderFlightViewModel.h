//
//  LYModifyOrderFlightViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYModifyOrderFlightViewModel : NSObject

@property(nonatomic, readwrite, copy) NSString *arrivalAirline;
@property(nonatomic, readwrite, copy) NSString *arrivalFlightNumber;
@property(nonatomic, readwrite, copy) NSString *arrivalLandingAirport;
@property(nonatomic, readwrite, copy) NSString *arrivalTime;
@property(nonatomic, readwrite, copy) NSString *departureAirline;
@property(nonatomic, readwrite, copy) NSString *departureFlightNumber;
@property(nonatomic, readwrite, copy) NSString *departureAirport;
@property(nonatomic, readwrite, copy) NSString *departureTime;

@property(nonatomic, readonly, strong) RACCommand *submitCommand;

- (instancetype)initWithParameter:(NSDictionary *)parameter;
@end

NS_ASSUME_NONNULL_END
