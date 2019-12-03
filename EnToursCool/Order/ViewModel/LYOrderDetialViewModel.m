//
//  LYOrderDetialViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOrderDetialViewModel.h"


@interface LYOrderDetialViewModel()
@property(nonatomic, readwrite, strong) LYOrderDetailInfoModel *infoModel;
@property(nonatomic, readwrite, strong) LYOrderDetailTravelPackageModel *travelPackageModel;
@property(nonatomic, readwrite, strong) RACCommand *getDataCommand;
@property(nonatomic, readwrite, strong) RACCommand *removeOrderCommand;
@property(nonatomic, readwrite, assign) NSInteger leftButtonType;
@property(nonatomic, readwrite, assign) NSInteger rightButtonType;
@end

@implementation LYOrderDetialViewModel
- (instancetype)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        self.infoModel = [[LYOrderDetailInfoModel alloc] init];
        self.infoModel.orderNumber = @"132";
        self.infoModel.purchaseTime = @"Jul,18,2019";
        self.infoModel.price = @"US$899.25";
        
        self.travelPackageModel = [[LYOrderDetailTravelPackageModel alloc] init];
        self.travelPackageModel.orderStatus = @"Payment Pending";
        self.travelPackageModel.productTitle = @"6 Days Yellowstone, Mt. Rushmore, Great Salt Lake Tour From Denver with Two Nights in ";
        self.travelPackageModel.productID = @"2333";
        self.travelPackageModel.date = @"Jul 12,2019-Jul 20,2019";
        self.travelPackageModel.valueAddedService = @"Proceed to Hatley Castle. Discover\r\nProceed to Hatley Castle. Discover\r\nProceed to Hatley Castle. Discover";
        self.travelPackageModel.traveler = @"Traveler 1：Lucy Laolunse\r\nTraveler 2：Lucy Laolunse\r\nTraveler 3：Lucy Laolunse";
        self.travelPackageModel.name = @"Name: liu shuoshuo";
        self.travelPackageModel.phone = @"Phone: 1-123456";
        self.travelPackageModel.email = @"Email: 1317410444@qq.com";
        self.travelPackageModel.isFlight = YES;
        
        self.travelPackageModel.arrivalAirline = @"Airline : Chengdou.China to ChungZhou.Korae";
        self.travelPackageModel.arrivalFlightNumber = @"Flight Number : CA302";
        self.travelPackageModel.arrivalLandingAirport = @"Landing airport : Incheon Airport,Soal";
        self.travelPackageModel.arrivalTime = @"Arrival Time  : Jul,18,2019";
        self.travelPackageModel.departureAirline = @"Airline : Chengdou.China to ChungZhou.Korae ";
        self.travelPackageModel.departureFlightNumber = @"Flight Number : CA302";
        self.travelPackageModel.departureLandingAirport = @"Landing airport : Incheon Airport,Soal";
        self.travelPackageModel.departureTime = @"Arrival Time  : Jul,18,2019";
        
        self.leftButtonType = 5;
        self.rightButtonType = 3;
    }
    return self;
}

- (RACCommand *)getDataCommand{
    if (!_getDataCommand) {
        @weakify(self);
        _getDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return nil;
        }];
    }
    return _getDataCommand;
}

- (RACCommand *)removeOrderCommand{
    if (!_removeOrderCommand) {
        @weakify(self);
        _removeOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [RACSignal return:@{@"code":@"0",@"type":@"1"}];
        }];
    }
    return _removeOrderCommand;
}
@end
