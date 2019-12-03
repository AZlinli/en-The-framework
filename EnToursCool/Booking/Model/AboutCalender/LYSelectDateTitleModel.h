//
//  LYSelectTitleModel.h
//  ToursCool
//
//  Created by tourscool on 11/1/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYBaseModel.h"
#import "LYProjectAllEnumeration.h"
@class LYSelectDatePeopleModel;

FOUNDATION_EXPORT NSString * _Nullable const LYDeleteRoomNotification;
FOUNDATION_EXPORT NSString * _Nullable const LYAddPeopleInRoomNotification;
FOUNDATION_EXPORT NSString * _Nullable const LYSubPeopleInRoomNotification;

NS_ASSUME_NONNULL_BEGIN

@interface LYSelectDateIndexModel : LYBaseModel
@property (nonatomic, assign) NSInteger index;
@end

@interface LYSelectDateTitleModel : LYSelectDateIndexModel
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) BOOL showDeleteButton;
@property (nonatomic, assign) LYPeopleCellCircularDirection circularDirection;
@end

@interface LYSelectDateWingRoomModel : LYSelectDateTitleModel
@property (nonatomic, assign) BOOL wingRoomState;
@property (nonatomic, strong) RACCommand * changeWingRoomCommand;
@end

@interface LYSelectDatePeopleModel : LYSelectDateTitleModel
@property (nonatomic, copy) NSString * number;
@property (nonatomic, copy) NSString * max;
@property (nonatomic, copy) NSString * min;
@property (nonatomic, copy) NSString * childrenSpike;
@property (nonatomic, assign) BOOL childrenState;
@property (nonatomic, strong) RACCommand * addNumberCommand;
@property (nonatomic, strong) RACCommand * subNumberCommand;
@end

@interface LYSelectDateAdultModel : LYSelectDatePeopleModel

@end

@interface LYSelectDateChildrenModel : LYSelectDatePeopleModel
@property (nonatomic, copy) NSString * maxChildAge;
@end



NS_ASSUME_NONNULL_END
