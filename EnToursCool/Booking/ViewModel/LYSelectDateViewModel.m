//
//  LYHotelDetailsDatePickerViewModel.m
//  SouthEastProject
//
//  Created by luoyong on 2018/8/7.
//  Copyright © 2018年 Daqsoft. All rights reserved.
//

#import "LYSelectDateViewModel.h"
#import "LYSelectDateTitleModel.h"
#import "LYSelectDatePriceAndMonthModel.h"
#import "LYSelectDatePriceModel.h"
#import "LYDateTools.h"

#import "LYHTTPRequestManager.h"
#import "LYUserInfoManager.h"
#import <EventKit/EventKit.h>
#import "NSString+LYTool.h"
@interface LYSelectDateViewModel()
@property (nonatomic, readwrite, strong) NSArray<EKEvent *> *events;
@property (nonatomic, readwrite, strong) NSCache *cache;
@property (nonatomic, readwrite, strong) NSDate *minimumDate;
@property (nonatomic, readwrite, strong) NSDate *maximumDate;
@property (nonatomic, readwrite, copy) NSString * durationDays;

@property (nonatomic, readwrite, copy) NSString * maxNumGuest;
@property (nonatomic, readwrite, copy) NSString * maxChildAge;
@property (nonatomic, readwrite, assign) BOOL isKids;
@property (nonatomic, readwrite, assign) BOOL isSinglePu;

@property (nonatomic, readwrite, strong) NSMutableArray<NSArray *> * peopleMutableArray;
@property (nonatomic, readwrite, strong) NSArray * monthArray;
@property (nonatomic, readwrite, strong) NSArray * datePriceArray;

@property (nonatomic, readwrite, strong) NSArray<NSArray *> * peopleArray;

@property (nonatomic, readwrite, strong) RACCommand *loadCalendarEventsCommand;
@property (nonatomic, readwrite, strong) RACCommand *addPeopleCommand;
@property (nonatomic, readwrite, strong) RACCommand *selectDateCommand;
@property (nonatomic, readwrite, strong) RACCommand *httpRequestDateCommand;
@property (nonatomic, readwrite, strong) RACCommand *immediateBookingButtonCommand;
@end

@implementation LYSelectDateViewModel

@synthesize peopleArray = _peopleArray;

- (instancetype)initWithParameter:(NSDictionary *)parameter
{
    if (self = [super initWithParameter:parameter]) {
        _maxChildAge = parameter[@"maxChildAge"];
        _isSinglePu = [parameter[@"isSinglePu"] boolValue];
        _isKids = [parameter[@"isKids"] boolValue];
        if (parameter[@"durationDays"]) {
            _durationDays = parameter[@"durationDays"];
        }else{
            _durationDays = @"4";
        }
        
        if (parameter[@"maxNumGuest"]) {
            _maxNumGuest = parameter[@"maxNumGuest"];
        }else{
            _maxNumGuest = @"4";
        }
        
        @weakify(self);
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LYDeleteRoomNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            [self.addPeopleCommand execute:@{@"index":x.userInfo[@"index"]}];
        }];
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LYSubPeopleInRoomNotification object:nil] throttle:0.8] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            [self.calculateTotalPriceCommand execute:nil];
        }];
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LYAddPeopleInRoomNotification object:nil] throttle:0.8] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            [self.calculateTotalPriceCommand execute:nil];
        }];
        
        [RACObserve(self, peopleArray) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.calculateTotalPriceCommand execute:nil];
        }];
        
        [RACObserve(self, selectDateString) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x) {
                [self.calculateTotalPriceCommand execute:nil];
            }
        }];
        
        [[RACSignal combineLatest:@[RACObserve(self, minimumDate), RACObserve(self, maximumDate)] reduce:^(NSDate * min, NSDate * max){
            @strongify(self);
            if (min && max) {
                [self.loadCalendarEventsCommand execute:nil];
            }
            return @(min && max);
        }] subscribeNext:^(id  _Nullable x) {
            
        }];
    }
    return self;
}

- (RACCommand *)immediateBookingButtonCommand
{
    if (!_immediateBookingButtonCommand) {
        @weakify(self);
        _immediateBookingButtonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            
            if (![LYUserInfoManager userIsLogin]) {
                return [RACSignal return:@{@"code":@"8",@"type":@"1"}];
            }
            
            if (!self.selectDateString.length) {
                return [RACSignal return:@{@"code":@"1",@"msg":[LYLanguageManager ly_localizedStringForKey:@"Booking_Select_Date_Title"]}];
            }
            if (!self.peopleArray.count) {
                return [RACSignal return:@{@"code":@"1",@"msg":[LYLanguageManager ly_localizedStringForKey:@"HUD_ADD_Room"]}];
            }
            if (![self examinePeople]) {
                return [RACSignal return:@{@"code":@"1",@"msg":[NSString stringWithFormat:@"%@%@人", [LYLanguageManager ly_localizedStringForKey:@"HUD_ADD_Peopel"],self.minNumGuest]}];
            }
            
            return [RACSignal return:@{@"code":@"11",@"msg":[LYLanguageManager ly_localizedStringForKey:@"Register_Next_Button_Title"]}];
        }];
    }
    return _immediateBookingButtonCommand;
}

- (RACCommand *)loadCalendarEventsCommand
{
    if (!_loadCalendarEventsCommand) {
        _loadCalendarEventsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @weakify(self);
                EKEventStore *store = [[EKEventStore alloc] init];
                [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                    @strongify(self);
                    if(granted) {
                        NSDate *startDate = self.minimumDate;
                        NSDate *endDate = self.maximumDate;
                        NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
                        NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
                        
                        NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                            return event.calendar.subscribed;
                        }]];
                        self.events = [events copy];
                        [subscriber sendNext:@"1"];
                    }else{
                        self.events = nil;
                        [subscriber sendNext:@"0"];
                    }
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _loadCalendarEventsCommand;
}

- (RACCommand *)addPeopleCommand
{
    if (!_addPeopleCommand) {
        @weakify(self);
        _addPeopleCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                if ([input[@"type"] isEqualToString:@"1"]) {
                    [self.peopleMutableArray addObject:[self obtainRoom]];
                }else{
                    NSInteger index = [input[@"index"] integerValue];
                    NSMutableArray * deleteArray = [NSMutableArray array];
                    [self enumeratePeopleMutableArrayBlock:^(LYSelectDateIndexModel * _Nonnull model, NSUInteger objIdx, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (model.index == index) {
                            [deleteArray addObject:model];
                        }
                    }];
                    
                    if (deleteArray.count) {
                        [self.peopleMutableArray removeObject:deleteArray];
                        [self enumeratePeopleMutableArrayBlock:^(LYSelectDateIndexModel * _Nonnull model, NSUInteger objIdx, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([model isKindOfClass:[LYSelectDateTitleModel class]]) {
                                LYSelectDateTitleModel * selectDateTitleModel = (LYSelectDateTitleModel *)model;
                                selectDateTitleModel.title = [NSString stringWithFormat:@"%@%@", [LYLanguageManager ly_localizedStringForKey:@"Booking_Room_Title"],@(idx + 1)];
                            }
                        }];
                    }
                }
                [self updateCellStyle];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _addPeopleCommand;
}

- (void)updateCellStyle
{
    [self.peopleMutableArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(LYSelectDateTitleModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            model.circularDirection = LYPeopleCellCircularDirectionNothing;
            model.showDeleteButton = NO;
        }];
        if (obj.count == 1) {
            LYSelectDateTitleModel * firstSelectDateTitleModel = obj.firstObject;
            firstSelectDateTitleModel.showDeleteButton = YES;
            firstSelectDateTitleModel.circularDirection = LYPeopleCellCircularDirectionAll;
        }else{
            LYSelectDateTitleModel * firstSelectDateTitleModel = obj.firstObject;
            firstSelectDateTitleModel.circularDirection = LYPeopleCellCircularDirectionTop;
            LYSelectDateTitleModel * lastSelectDateTitleModel = obj.lastObject;
            lastSelectDateTitleModel.circularDirection = LYPeopleCellCircularDirectionBottom;
        }
    }];
    if (self.peopleMutableArray.count == 1) {
        LYSelectDateTitleModel * firstSelectDateTitleModel = self.peopleMutableArray.firstObject.firstObject;
        firstSelectDateTitleModel.showDeleteButton = YES;
    }
    self.peopleArray = [self.peopleMutableArray copy];
}

- (RACCommand *)httpRequestDateCommand
{
    if (!_httpRequestDateCommand) {
        @weakify(self);
        _httpRequestDateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            NSString * productCalendarPath = [NSString stringWithFormat:@"product/%@/calendar", self.productID];
            return [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(productCalendarPath) parameter:@{} cacheType:NO] map:^id _Nullable(id  _Nullable value) {
                // FIXME: LDL测试
                if ([value[@"code"] integerValue] == 200000)
                {
                    NSArray * data = value[@"data"];
                    
                    data = @[@{@"month":@"12",@"years":@"2019",@"days":@[@{@"day":@"7",@"is_soldout":@"0",@"price":@"￥6,589",@"status":@"1",@"isSpecial":@"1"},@{@"day":@"14",@"is_soldout":@"0",@"price":@"￥6,589",@"status":@"1"},@{@"day":@"21",@"isSpecial":@"1",@"is_soldout":@"0",@"price":@"￥7,385",@"status":@"1"},@{@"day":@"28",@"is_override":@"1",@"is_soldout":@"0",@"price":@"￥7,385",@"status":@"1"}]},@{@"month":@"1",@"years":@"2020",@"days":@[@{@"day":@"4",@"isSpecial":@"1",@"price":@"￥6,589",@"status":@"1"},@{@"day":@"18",@"is_soldout":@"0",@"price":@"￥6,589",@"status":@"1"},@{@"day":@"25",@"is_override":@"1",@"is_soldout":@"0",@"price":@"￥7,385",@"status":@"1"},@{@"day":@"28",@"is_override":@"1",@"is_soldout":@"0",@"price":@"￥7,385",@"status":@"1"}]},@{@"month":@"2",@"years":@"2020",@"days":@[@{@"day":@"7",@"is_soldout":@"0",@"price":@"￥6,589",@"status":@"1"},@{@"day":@"14",@"is_soldout":@"0",@"price":@"￥6,589",@"status":@"1"},@{@"day":@"21",@"is_override":@"1",@"is_soldout":@"0",@"price":@"￥7,385",@"status":@"1"},@{@"day":@"28",@"is_override":@"1",@"is_soldout":@"0",@"price":@"￥7,385",@"status":@"1"}]},@{@"month":@"3",@"years":@"2020",@"days":@[@{@"day":@"7",@"is_soldout":@"0",@"price":@"￥6,589",@"status":@"1"},@{@"day":@"14",@"is_soldout":@"0",@"price":@"￥6,589",@"status":@"1"},@{@"day":@"21",@"is_override":@"1",@"is_soldout":@"0",@"price":@"￥7,385",@"status":@"1"},@{@"day":@"28",@"is_override":@"1",@"is_soldout":@"0",@"price":@"￥7,385",@"status":@"1"}]}];
                    NSMutableArray * datePriceArray = [NSMutableArray array];
                    for (NSDictionary * dic in data) {
                        NSArray * datsArray = dic[@"days"];
                        for (NSDictionary * dayDic in datsArray) {
                            NSMutableDictionary * day = [NSMutableDictionary dictionaryWithDictionary:dayDic];
                            [day setObject:dic[@"years"] forKey:@"years"];
                            [day setObject:dic[@"month"] forKey:@"month"];
                            [datePriceArray addObject:[LYSelectDatePriceModel mj_objectWithKeyValues:day]];
                        }
                    }
                    self.datePriceArray = [datePriceArray copy];
                    [self addDefaultPeoples];
                    if (data.count >= 2) {
                        NSString * years = data.firstObject[@"years"];
                        NSString * month = data.firstObject[@"month"];
                        if (years.length && month.length) {
                            NSString * minimumStr = [NSString stringWithFormat:@"%@-%@-01", years,month];
                            self.minimumDate = [LYDateTools stringToDateWithFormatterStr:@"yyyy-MM-dd" dateStr:minimumStr];
                        }
                        NSString * maxYears = data.lastObject[@"years"];
                        NSString * maxMonth = data.lastObject[@"month"];
                        if (maxYears.length && maxYears.length) {
                            NSString * maximumStr = [NSString stringWithFormat:@"%@-%@-%@", maxYears,maxMonth, @([LYDateTools getSumOfDaysInMonth:maxYears month:maxMonth])];
                            self.maximumDate = [LYDateTools stringToDateWithFormatterStr:@"yyyy-MM-dd" dateStr:maximumStr];
                        }
                    }else if (data.count == 1) {
                        NSString * years = data.firstObject[@"years"];
                        NSString * month = data.firstObject[@"month"];
                        if (years.length && month.length) {
                            NSString * minimumStr = [NSString stringWithFormat:@"%@-%@-01", years,month];
                            self.minimumDate = [LYDateTools stringToDateWithFormatterStr:@"yyyy-MM-dd" dateStr:minimumStr];
                            NSString * maximumStr = [NSString stringWithFormat:@"%@-%@-%@", years,month, @([LYDateTools getSumOfDaysInMonth:years month:month])];
                            self.maximumDate = [LYDateTools stringToDateWithFormatterStr:@"yyyy-MM-dd" dateStr:maximumStr];
                        }
                    }
                    self.monthArray = [[LYSelectDatePriceAndMonthModel mj_objectArrayWithKeyValuesArray:data] copy];
                    LYSelectDatePriceAndMonthModel * model = self.monthArray.firstObject;
                    model.isSelected = YES;
                    
                }
                return value;
            }];
        }];
    }
    return _httpRequestDateCommand;
}

- (RACCommand *)selectDateCommand
{
    if (!_selectDateCommand) {
        @weakify(self);
        _selectDateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDate *  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.selectDate = input;
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _selectDateCommand;
}
/**
 获取事件
 
 @param date 时间
 @return 日期事件
 */
- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date
{
    NSArray<EKEvent *> *events = [self.cache objectForKey:date];
    if ([events isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];
    if (filteredEvents.count) {
        [self.cache setObject:filteredEvents forKey:date];
    } else {
        [self.cache setObject:[NSNull null] forKey:date];
    }
    return filteredEvents;
}

/**
 删除缓存
 */
- (void)removeCacheData
{
    [self.cache removeAllObjects];
}

- (NSString *)obtainPriceWithDate:(NSDate *)date
{
    __block NSString * price = nil;
    [self.datePriceArray enumerateObjectsUsingBlock:^(LYSelectDatePriceModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.date isEqualToDate:date]) {
            price = obj.price;
            *stop = YES;
        }
    }];
    return price;
}

- (LYSelectDatePriceModel *)obtainSelectDatePriceModelWithDate:(NSDate *)date
{
    __block LYSelectDatePriceModel * selectDatePriceModel = nil;
    [self.datePriceArray enumerateObjectsUsingBlock:^(LYSelectDatePriceModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.date isEqualToDate:date]) {
            selectDatePriceModel = obj;
            *stop = YES;
        }
    }];
    return selectDatePriceModel;
}

- (void)addDefaultPeoples
{
    [self.peopleMutableArray addObject:[self obtainRoom]];
    [self updateCellStyle];
    [self.calculateTotalPriceCommand execute:nil];
}

- (NSArray *)obtainRoom
{
    NSMutableArray * array = [NSMutableArray array];
    NSInteger index = [LYDateTools timeIntervalSince1970WithDate:[NSDate new]];
    
    if (self.selfSupport == 0 && self.productEntityType == 1) {
        LYSelectDateTitleModel * model = [[LYSelectDateTitleModel alloc] init];
        model.title = [NSString stringWithFormat:@"%@%@", [LYLanguageManager ly_localizedStringForKey:@"Booking_Room_Title"], @(self.peopleArray.count + 1)];
        model.index = index;
        model.circularDirection = LYPeopleCellCircularDirectionTop;
        [array addObject:model];
    }
    
    LYSelectDateAdultModel * selectDateAdultModel = [[LYSelectDateAdultModel alloc] init];
    if (self.peopleMutableArray.count) {
        selectDateAdultModel.number = @"1";
    }else{
        selectDateAdultModel.number = self.minNumGuest;
    }
    selectDateAdultModel.min = @"1";
    if ([self.maxNumGuest integerValue] == -1) {
        selectDateAdultModel.max = @"99999";
    }else{
        selectDateAdultModel.max = self.maxNumGuest;
    }
    
    selectDateAdultModel.index = index;
    [array addObject:selectDateAdultModel];
    @weakify(self);
    LYSelectDateChildrenModel * selectDateChildrenModel = nil;
    if (self.isKids) {
        selectDateChildrenModel = [[LYSelectDateChildrenModel alloc] init];
        selectDateChildrenModel.min = @"0";
        if ([self.maxNumGuest integerValue] == -1) {
            self.maxNumGuest = @"99999";
        }
        selectDateChildrenModel.max = self.maxNumGuest;
        selectDateChildrenModel.childrenSpike = @"1";
        selectDateChildrenModel.childrenState = YES;
        selectDateChildrenModel.maxChildAge = self.maxChildAge;
        selectDateChildrenModel.index = index;
        [array addObject:selectDateChildrenModel];
        
        [RACObserve(selectDateChildrenModel, number) subscribeNext:^(NSString *  _Nullable x) {
            @strongify(self);
            selectDateAdultModel.max = [NSString stringWithFormat:@"%@", @([self.maxNumGuest integerValue] - [x integerValue])];
        }];
        
        [RACObserve(selectDateAdultModel, number) subscribeNext:^(NSString *  _Nullable x) {
            @strongify(self);
            selectDateChildrenModel.max = [NSString stringWithFormat:@"%@", @([self.maxNumGuest integerValue] - [x integerValue])];
        }];
    }
    
    if (self.isSinglePu && [self.minNumGuest integerValue] == 1 && self.selfSupport == 0 && self.productEntityType == 1) {
        [self createSelectDateWingRoomModel:index array:array];
    }
    
    if (selectDateChildrenModel) {
        [[RACObserve(selectDateAdultModel, number) merge:RACObserve(selectDateChildrenModel, number)] subscribeNext:^(id  _Nullable x) {
            LYNSLog(@"selectDateAdultModel  %@ selectDateChildrenModel = %@", selectDateAdultModel.number, selectDateChildrenModel.number);
            NSInteger total = [selectDateAdultModel.number integerValue] + [selectDateChildrenModel.number integerValue];
            [self updateWingRoomWith:[NSString stringWithFormat:@"%@", @(total)] selectDateAdultModel:selectDateAdultModel];
        }];
    }else{
        [RACObserve(selectDateAdultModel, number) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self updateWingRoomWith:x selectDateAdultModel:selectDateAdultModel];
        }];
    }
    return [array copy];
}

- (void)updateWingRoomWith:(NSString *)x selectDateAdultModel:(LYSelectDateAdultModel *)selectDateAdultModel
{
    __block NSInteger index = 0;
    __block BOOL stopCirculation = NO;
    @weakify(self);
    [self.peopleMutableArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (stopCirculation) {
            *stop = YES;
        }
        index = idx;
        [obj enumerateObjectsUsingBlock:^(LYSelectDateIndexModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull interiorstop) {
            if ([x integerValue] >= 2) {
                if (model.index == selectDateAdultModel.index && [model isKindOfClass:[LYSelectDateWingRoomModel class]]) {
                    @strongify(self);
                    stopCirculation = YES;
                    *interiorstop = YES;
                    NSMutableArray * deleteArray = [NSMutableArray arrayWithArray:obj];
                    [deleteArray removeObject:model];
                    if (deleteArray.count) {
                        [self.peopleMutableArray replaceObjectAtIndex:index withObject:deleteArray];
                        [self updateCellStyle];
                    }
                }
            }else{
                if (model.index == selectDateAdultModel.index) {
                    if (self.isSinglePu && [self.minNumGuest integerValue] == 1 && self.selfSupport == 0 && self.productEntityType == 1) {
                        stopCirculation = YES;
                        *interiorstop = YES;
                        @strongify(self);
                        NSMutableArray * addArray = [NSMutableArray arrayWithArray:obj];
                        [self createSelectDateWingRoomModel:model.index array:addArray];
                        if (addArray.count) {
                            [self.peopleMutableArray replaceObjectAtIndex:index withObject:addArray];
                            [self updateCellStyle];
                        }
                    }
                }
            }
        }];
    }];
}

- (void)createSelectDateWingRoomModel:(NSInteger)index array:(NSMutableArray *)array
{
    LYSelectDateWingRoomModel * selectDateWingRoomModel = [[LYSelectDateWingRoomModel alloc] init];
    selectDateWingRoomModel.index = index;
    @weakify(self);
    [selectDateWingRoomModel.changeWingRoomCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.calculateTotalPriceCommand execute:nil];
    }];
    [array addObject:selectDateWingRoomModel];
}


- (void)enumeratePeopleMutableArrayBlock:(void (^)(LYSelectDateIndexModel *  _Nonnull model, NSUInteger objIdx, NSUInteger idx, BOOL * _Nonnull stop))enumerateBlock
{
    [self.peopleMutableArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(LYSelectDateIndexModel *  _Nonnull model, NSUInteger objIdx, BOOL * _Nonnull stop) {
            if (enumerateBlock) {
                enumerateBlock(model, objIdx, idx, stop);
            }
        }];
    }];
}

- (NSMutableArray *)peopleMutableArray
{
    if (!_peopleMutableArray) {
        _peopleMutableArray = [[NSMutableArray alloc] init];
    }
    return _peopleMutableArray;
}

@end
