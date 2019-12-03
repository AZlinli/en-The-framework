//
//  LYAbstractBookingViewModel.m
//  ToursCool
//
//  Created by tourscool on 7/8/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYAbstractBookingViewModel.h"
#import "LYSelectDateTitleModel.h"
#import "LYUserInfoManager.h"


#import "LYHTTPRequestManager.h"
#import "LYDateTools.h"
#import "NSString+LYTool.h"

@interface LYAbstractBookingViewModel ()
@property (nonatomic, readwrite, strong) RACCommand * calculateTotalPriceCommand;

@property (nonatomic, readwrite, copy) NSString * productID;
@property (nonatomic, readwrite, copy) NSString * productName;

@property (nonatomic, readwrite, copy) NSString * totalPrice;
@property (nonatomic, readwrite, copy) NSString * basePrice;

@property (nonatomic, readwrite, copy) NSString * adultNumber;
@property (nonatomic, readwrite, copy) NSString * childNumber;

@property (nonatomic, readwrite, copy) NSString * minNumGuest;

@property (nonatomic, readwrite, copy) NSString * selectDateString;

@property (nonatomic, readwrite, copy) NSString * roomNumber;

@property (nonatomic, readwrite, assign) NSInteger selfSupport;
@property (nonatomic, readwrite, assign) NSInteger productEntityType;
/**
 联盟优惠
 */
@property (nonatomic, readwrite, copy) NSString * agentDiscount;
/**
 新人优惠
 */
@property (nonatomic, readwrite, copy) NSString * comerDiscount;
/**
 单房差
 */
@property (nonatomic, readwrite, copy) NSDictionary *singleRoomPoor;
/**
 其他信息
 */
@property (nonatomic, readwrite, copy) NSDictionary *otherMSG;
/**
 优惠
 */
@property (nonatomic, readwrite, copy) NSArray *preferentialInformationArray;
@end

@implementation LYAbstractBookingViewModel

- (instancetype)initWithParameter:(NSDictionary *)parameter
{
    if (self = [self init]) {
        NSArray * rooms = parameter[@"rooms"];
        if (rooms.count) {
            self.rooms = parameter[@"rooms"];
            [self calculateOrderAffirmTotalPeople];
        }
        
        NSDate * selectDate = parameter[@"selectDate"];
        if (selectDate) {
            self.selectDate = parameter[@"selectDate"];
        }
        
        self.productID = parameter[@"id"];
        self.totalPrice = [NSString stringWithFormat:@"%@0.00",LYUserInfoManager.sharedUserInfoManager.userCurrencySymbol];
        if (parameter[@"dateString"]) {
            self.selectDate = [LYDateTools stringToDateWithFormatterStr:@"yyyy-MM-dd" dateStr:parameter[@"dateString"]];
        }
        if (parameter[@"minNumGuest"]) {
            self.minNumGuest = parameter[@"minNumGuest"];
        }else{
            self.minNumGuest = @"1";
        }
        self.productName = parameter[@"productName"];
        self.selfSupport = [parameter[@"selfSupport"] integerValue];
        self.productEntityType = [parameter[@"productEntityType"] integerValue];
        @weakify(self);
        [RACObserve(self, selectDate) subscribeNext:^(NSDate *  _Nullable x) {
            @strongify(self);
            if (x) {
                self.selectDateString = [LYDateTools dateToStringWithFormatterStr:@"yyyy-MM-dd" date:x];
            }else{
                self.selectDateString = nil;
            }
        }];
        
        [[RACObserve(self, peopleArray) skip:1] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self calculateTotalPeople];
        }];
    }
    return self;
}

- (RACCommand *)calculateTotalPriceCommand
{
    if (!_calculateTotalPriceCommand) {
        @weakify(self);
        _calculateTotalPriceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            NSDictionary * parameters = [self obtainBudgetHTTPParameters];
            if (!parameters) {
                return [RACSignal return:@{@"code":@"1"}];
            }
            LYNSLog(@"parameters -- %@", [NSString dicToSting:parameters]);
            NSString * productBudgetPath = [NSString stringWithFormat:@"product/%@/budget", self.productID];
            return [[LYHTTPRequestManager HTTPPostRequestWithAction:LY_HTTP_Version_1(productBudgetPath) parameter:@{@"product":parameters} cacheType:NO] map:^id _Nullable(id  _Nullable value) {
                if ([value[@"code"] integerValue] == 0) {
                    NSString * total_price = [NSString stringWithFormat:@"%@", value[@"data"][@"total_price"]];
                    if ([total_price isEmpty]) {
                        self.totalPrice = [NSString stringWithFormat:@"%@0.00",LYUserInfoManager.sharedUserInfoManager.userCurrencySymbol];
                    } else {
                        self.totalPrice = total_price;
                    }
                    
                    self.basePrice = [NSString stringWithFormat:@"%@", value[@"data"][@"base_price"]];
                    
                    NSString * agentDiscount = [NSString stringWithFormat:@"%@", value[@"data"][@"agent"][@"discount"]];
                    if (![agentDiscount isEmpty]) {
                        self.agentDiscount = agentDiscount;
                    }else{
                        self.agentDiscount = @"";
                    }
                    
                    NSString * comerDiscount = [NSString stringWithFormat:@"%@", value[@"data"][@"newer"][@"discount"]];
                    if (![comerDiscount isEmpty]) {
                        self.comerDiscount = comerDiscount;
                    }else{
                        self.comerDiscount = @"";
                    }
                    
                    if (value[@"data"][@"dfc"]) {
                        self.singleRoomPoor = value[@"data"][@"dfc"];
                    }
                    if (value[@"nm"]) {
                        self.otherMSG = value[@"nm"];
                    }else{
                        self.otherMSG = nil;
                    }
                }else{
                    self.totalPrice = [NSString stringWithFormat:@"%@0.00",LYUserInfoManager.sharedUserInfoManager.userCurrencySymbol];
                }
                LYNSLog(@"budget -- %@", value);
                return value;
            }];
        }];
    }
    return _calculateTotalPriceCommand;
}

- (NSDictionary *)obtainBudgetHTTPParameters
{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    if (!self.selectDateString.length) {
        return nil;
    }
    if (![self examinePeople]) {
        return nil;
    }
    [self calculateOrderAffirmTotalPeople];
    
    [parameters setObject:self.productID forKey:@"product_id"];
    [parameters setObject:self.selectDateString forKey:@"departure_date"];
    [parameters setObject:@([self.roomNumber integerValue]) forKey:@"room_total"];
    [parameters setObject:[self obtainPeopleRoom] forKey:@"room_attributes"];
    return [parameters copy];
}

- (NSArray *)obtainPeopleRoom
{
    if (self.rooms.count) {
        return self.rooms;
    }
    NSMutableArray * array = [NSMutableArray array];
    [self.peopleArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [obj enumerateObjectsUsingBlock:^(id  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([model isKindOfClass:[LYSelectDateAdultModel class]]) {
                [dic setObject:((LYSelectDateAdultModel *)model).number forKey:@"adult"];
            }else if ([model isKindOfClass:[LYSelectDateChildrenModel class]]) {
                if ([((LYSelectDateChildrenModel *)model).number integerValue] != 0) {
                    [dic setObject:((LYSelectDateChildrenModel *)model).number forKey:@"child"];
                }
            }else if ([model isKindOfClass:[LYSelectDateWingRoomModel class]]) {
                if (((LYSelectDateWingRoomModel *)model).wingRoomState) {
                    [dic setObject:@"Y" forKey:@"pair"];
                }
            }
        }];
        [array addObject:dic];
    }];
    return array;
}



/**
 计算 儿童 成人 人数
 */
- (void)calculateTotalPeople
{
    __block NSInteger adult = 0;
    __block NSInteger child = 0;
    [self enumeratePeopleArrayBlock:^(id  _Nonnull model, NSUInteger objIdx, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model isKindOfClass:[LYSelectDateAdultModel class]]) {
            adult += [((LYSelectDateAdultModel *)model).number integerValue];
        }else if ([model isKindOfClass:[LYSelectDateChildrenModel class]]) {
            child += [((LYSelectDateChildrenModel *)model).number integerValue];
        }
    }];
    self.adultNumber = [NSString stringWithFormat:@"%@", @(adult)];
    self.childNumber = [NSString stringWithFormat:@"%@", @(child)];
}

- (void)calculateOrderAffirmTotalPeople
{
    __block NSInteger adult = 0;
    __block NSInteger child = 0;
    if (self.rooms.count) {
        [self.rooms enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            adult += [obj[@"adult"] integerValue];
            child += [obj[@"child"] integerValue];
        }];
    }else{
        [self enumeratePeopleArrayBlock:^(id  _Nonnull model, NSUInteger objIdx, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([model isKindOfClass:[LYSelectDateAdultModel class]]) {
                adult += [((LYSelectDateAdultModel *)model).number integerValue];
            }else if ([model isKindOfClass:[LYSelectDateChildrenModel class]]) {
                child += [((LYSelectDateChildrenModel *)model).number integerValue];
            }
        }];
    }
    
    
    self.childNumber = [NSString stringWithFormat:@"%@", @(child)];
    self.adultNumber = [NSString stringWithFormat:@"%@", @(adult)];
    self.roomNumber = [NSString stringWithFormat:@"%@", @(self.rooms.count)];
}

- (void)enumeratePeopleArrayBlock:(void (^)(id _Nonnull model, NSUInteger objIdx, NSUInteger idx, BOOL * _Nonnull stop))enumerateBlock
{
    [self.peopleArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(id  _Nonnull model, NSUInteger objIdx, BOOL * _Nonnull stop) {
            if (enumerateBlock) {
                enumerateBlock(model, objIdx, idx, stop);
            }
        }];
    }];
}

/**
 获取价格详情

 @return 数组
 */
- (NSArray *)obtainExpenseDetail
{
    NSMutableArray * array = [NSMutableArray array];
    NSMutableArray * itemsMutableArray = [NSMutableArray array];
    if ([self.childNumber integerValue] == 0) {
        [itemsMutableArray addObject:@{@"name":[LYLanguageManager ly_localizedStringForKey:@"Booking_Adult_Title"],@"price":[NSString stringWithFormat:@"%@", self.adultNumber]}];
    }else{
        [itemsMutableArray addObject:@{@"name":[LYLanguageManager ly_localizedStringForKey:@"Booking_Adult_Title"],@"price":[NSString stringWithFormat:@"%@", self.adultNumber]}];
        [itemsMutableArray addObject:@{@"name":[LYLanguageManager ly_localizedStringForKey:@"Booking_Children_Title"],@"price":[NSString stringWithFormat:@"%@", self.childNumber]}];
    }
    
    
    if (self.basePrice.length) {
        [array addObject:@{@"title":@{@"name":[LYLanguageManager ly_localizedStringForKey:@"Booking_Capital_Cost"],@"total_price":self.basePrice},@"items":[itemsMutableArray copy]}];
    }
    
    
    if (self.singleRoomPoor.count) {
        if ([self.singleRoomPoor[@"price"] integerValue] != 0 && self.singleRoomPoor[@"name"]) {
            [array addObject:@{@"title":@{@"name":self.singleRoomPoor[@"name"],@"total_price":self.singleRoomPoor[@"price"]}}];
        }
    }
    if (self.otherMSG.count) {
        if ([[NSString stringWithFormat:@"%@", self.otherMSG[@"price"]] floatValue] > 0) {
            [array addObject:@{@"title":@{@"name":self.otherMSG[@"name"],@"total_price":self.otherMSG[@"price"]}}];
        }
    }
    NSMutableArray * preferentialInformationArray = [NSMutableArray array];
    if (self.agentDiscount.length) {
        [preferentialInformationArray addObject:@{@"name":[LYLanguageManager ly_localizedStringForKey:@"LY_Booking_Union_Discount"],@"price":[NSString stringWithFormat:@"-%@",self.agentDiscount]}];
    }
    if (self.comerDiscount.length) {
        [preferentialInformationArray addObject:@{@"name":[LYLanguageManager ly_localizedStringForKey:@"LY_Booking_Comer_Discount"],@"price":[NSString stringWithFormat:@"-%@",self.comerDiscount]}];
    }
    
    if (preferentialInformationArray.count) {
        self.preferentialInformationArray = [preferentialInformationArray copy];
        [array addObject:@{@"title":@{@"name":[LYLanguageManager ly_localizedStringForKey:@"Booking_Discounted_Prices"],@"total_price":@""},@"items":self.preferentialInformationArray}];
    }else{
        self.preferentialInformationArray = nil;
    }
    return [array copy];
}

- (BOOL)examinePeople
{
    if (self.rooms.count) {
        return YES;
    }
    __block NSInteger peopleNumber = 0;
    [self enumeratePeopleArrayBlock:^(id  _Nonnull model, NSUInteger objIdx, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model isKindOfClass:[LYSelectDateAdultModel class]]) {
            peopleNumber += [((LYSelectDateAdultModel *)model).number integerValue];
        }else if ([model isKindOfClass:[LYSelectDateChildrenModel class]]) {
            if ([((LYSelectDateChildrenModel *)model).number integerValue] != 0) {
                peopleNumber += [((LYSelectDateChildrenModel *)model).number integerValue];
            }
        }
    }];
    return peopleNumber >= [self.minNumGuest integerValue];
}

- (NSDictionary *)replicationNextPageParameter
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[self obtainPeopleRoom] forKey:@"rooms"];
    [dic setObject:self.selectDate forKey:@"selectDate"];
    [dic setObject:self.productID forKey:@"id"];
    [dic setObject:self.productName forKey:@"productName"];
    [dic setObject:self.selectDate forKey:@"selectDate"];
    [dic setObject:@(self.selfSupport) forKey:@"selfSupport"];
    [dic setObject:@(self.productEntityType) forKey:@"productEntityType"];
    [dic setObject:@([self.isSpecial integerValue]) forKey:@"isSpecial"];
    if ([self.childNumber integerValue] != 0) {
        [dic setObject:self.childNumber forKey:@"childNumber"];
    }
    [dic setObject:self.adultNumber forKey:@"adultNumber"];
    return [dic copy];
}

@end
