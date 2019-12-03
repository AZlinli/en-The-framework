//
//  LYWishListItemModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYWishListItemModel.h"

NSString *const kSelectedWishNotificationName  = @"kSelectedWishNotificationName";
@interface LYWishListItemModel()

@property (nonatomic, readwrite, strong) RACCommand * selectedCommand;

@end

@implementation LYWishListItemModel

- (RACCommand *)selectedCommand{
    if (!_selectedCommand) {
        @weakify(self);
        _selectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.isSelected = !self.isSelected;
                [[NSNotificationCenter defaultCenter] postNotificationName:kSelectedWishNotificationName object:nil userInfo:@{@"model":self}];
                [subscriber sendNext:@(self.isSelected)];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _selectedCommand;
}
@end
