//
//  LYSelectTitleModel.m
//  ToursCool
//
//  Created by tourscool on 11/1/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSelectDateTitleModel.h"
NSString * const LYDeleteRoomNotification = @"LYDeleteRoomNotification";
NSString * const LYAddPeopleInRoomNotification = @"LYAddPeopleInRoomNotification";
NSString * const LYSubPeopleInRoomNotification = @"LYSubPeopleInRoomNotification";

@implementation LYSelectDateIndexModel

@end

@implementation LYSelectDateTitleModel
- (NSString *)cellReuseIdentifier
{
    return @"LYSelectDateTitleTableViewCellID";
}
@end

@implementation LYSelectDateWingRoomModel

- (RACCommand *)changeWingRoomCommand
{
    if (!_changeWingRoomCommand) {
        @weakify(self);
        _changeWingRoomCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.wingRoomState = !self.wingRoomState;
                [subscriber sendNext:@""];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _changeWingRoomCommand;
}

- (NSString *)cellReuseIdentifier
{
    return @"LYSelectDateWingRoomTableViewCellID";
}
@end

@implementation LYSelectDateAdultModel
- (NSString *)cellReuseIdentifier
{
    return @"LYSelectDateAdultTableViewCellID";
}
@end

@implementation LYSelectDateChildrenModel
- (NSString *)cellReuseIdentifier
{
    return @"LYSelectDateChildrenTableViewCellID";
}
@end

@implementation LYSelectDatePeopleModel

- (RACCommand *)subNumberCommand
{
    if (!_subNumberCommand) {
        RACSignal * enabled = [RACSignal combineLatest:@[RACObserve(self, min), RACObserve(self, number)] reduce:^id (NSString * min, NSString * number){
            return @([min integerValue] < [number integerValue]);
        }];
        _subNumberCommand = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                if (self.childrenState) {
                    if ([self.number integerValue] <= [self.min integerValue]) {
                        [subscriber sendNext:@"4"];
                    }else{
                        LYNSLog(@"%@", [self class]);
                        self.number = [NSString stringWithFormat:@"%@", @([self.number integerValue] - [self.childrenSpike integerValue])];
                        [subscriber sendNext:@"0"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:LYSubPeopleInRoomNotification object:nil];
                    }
                }else{
                    if ([self.number integerValue] <= [self.min integerValue]) {
                        [subscriber sendNext:@"4"];
                    }else{
                        LYNSLog(@"%@", [self class]);
                        self.number = [NSString stringWithFormat:@"%@", @([self.number integerValue] - [self.min integerValue])];
                        [subscriber sendNext:@"0"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:LYSubPeopleInRoomNotification object:nil];
                    }
                }
                
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _subNumberCommand;
}

- (RACCommand *)addNumberCommand
{
    if (!_addNumberCommand) {
        RACSignal * enabled = [RACSignal combineLatest:@[RACObserve(self, number),RACObserve(self, max)] reduce:^id (NSString * number, NSString * max){
            return @([max integerValue] > [number integerValue]);
        }];
        _addNumberCommand = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                if (self.childrenState) {
                    if ([self.number integerValue] >= [self.max integerValue]) {
                        [subscriber sendNext:@"3"];
                    }else{
                        self.number = [NSString stringWithFormat:@"%@", @([self.number integerValue] + [self.childrenSpike integerValue])];
                        [subscriber sendNext:@"1"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:LYAddPeopleInRoomNotification object:nil];
                    }
                }else{
                    if ([self.number integerValue] >= [self.max integerValue]) {
                        [subscriber sendNext:@"3"];
                    }else{
                        self.number = [NSString stringWithFormat:@"%@", @([self.number integerValue] + [self.min integerValue])];
                        [subscriber sendNext:@"1"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:LYAddPeopleInRoomNotification object:nil];
                    }
                }
                
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _addNumberCommand;
}
@end
