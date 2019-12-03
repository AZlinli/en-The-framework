//
//  LYWishListViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYWishListViewModel.h"
#import "LYWishListItemModel.h"
#import "LYHTTPRequestManager.h"

@interface LYWishListViewModel()
@property (nonatomic, readwrite, copy) NSArray *dataArray;
@property (nonatomic, readwrite, copy) NSArray<LYWishListItemModel *> *deleteArray;
@property (nonatomic, readwrite, strong) NSNumber *isSelectedAll;
@property (nonatomic, readwrite, strong) RACCommand * deleteItemsCommand;
@property (nonatomic, readwrite, strong) RACCommand *getDataCommand;
@end

@implementation LYWishListViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        
        @weakify(self);
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kSelectedWishNotificationName object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            LYWishListItemModel * model = x.userInfo[@"model"];
            NSMutableArray * array = [NSMutableArray arrayWithArray:self.deleteArray];
            if (model.isSelected) {
                if (![array containsObject:model]) {
                    [array addObject:model];
                }
            }else{
                [array removeObject:model];
            }
            self.deleteArray = [array copy];
            self.isSelectedAll = @(self.deleteArray.count == self.dataArray.count);
        }];
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        LYWishListItemModel *item = [[LYWishListItemModel alloc] init];
        item.title = @"diagfsuagfiugasiduyfg";
        item.image = @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg";
        item.reviews = @"12 Reviews";
        item.depature = @"Depature :Las Vegas";
        item.price = @"US$8991.00";
        item.savePrice = @"US$900 saved";
        item.score = @"4.5";
        item.isEnable = YES;
        [tmpArray addObject:item];
        
        LYWishListItemModel *item1 = [[LYWishListItemModel alloc] init];
        item1.title = @"diagfsuagfiugasiduyfg";
        item1.image = @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg";
        item1.reviews = @"12 Reviews";
        item1.depature = @"Depature :Las Vegas";
        item1.price = @"US$8991.00";
        item1.savePrice = @"US$900 saved";
        item1.score = @"2.5";
        item1.isEnable = YES;
        [tmpArray addObject:item1];

        
        LYWishListItemModel *item2 = [[LYWishListItemModel alloc] init];
        item2.title = @"diagfsuagfiugasiduyfg";
        item2.image = @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg";
        item2.reviews = @"12 Reviews";
        item2.depature = @"Depature :Las Vegas";
        item2.price = @"US$8991.00";
        item2.savePrice = @"US$900 saved";
        item2.score = @"4.5";
        item2.isEnable = YES;
        [tmpArray addObject:item2];

        
        LYWishListItemModel *item3 = [[LYWishListItemModel alloc] init];
        item3.title = @"diagfsuagfiugasiduyfg";
        item3.image = @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg";
        item3.reviews = @"12 Reviews";
        item3.depature = @"Depature :Las Vegas";
        item3.price = @"US$8991.00";
        item3.savePrice = @"US$900 saved";
        item3.score = @"4.5";
        item3.isEnable = NO;
        [tmpArray addObject:item3];

        LYWishListItemModel *item4 = [[LYWishListItemModel alloc] init];
        item4.title = @"diagfsuagfiugasiduyfg";
        item4.image = @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg";
        item4.reviews = @"12 Reviews";
        item4.depature = @"Depature :Las Vegas";
        item4.price = @"US$8991.00";
        item4.savePrice = @"US$900 saved";
        item4.score = @"3.5";
        item4.isEnable = NO;
        [tmpArray addObject:item4];
        self.dataArray = [tmpArray copy];

    }
    return self;
}

// todo
- (RACCommand *)getDataCommand{
    if (!_getDataCommand) {
        @weakify(self);
        _getDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [[LYHTTPRequestManager HTTPGetRequestWithAction:LY_HTTP_Version_1(@"profile") parameter:@{} cacheType:NO] map:^id _Nullable(id  _Nullable value) {
                LYNSLog(@"wishlist - %@", value);
                if ([value[@"code"] integerValue] == 0) {
                    
                }
                return value;
            }];
        }];
    }
    return _getDataCommand;
    
}

// todo
- (RACCommand *)deleteItemsCommand{
    if (!_deleteItemsCommand) {
        @weakify(self);
        _deleteItemsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSIndexPath *  _Nullable input) {
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                   @strongify(self);
                    if(input){
                        //删一条 删文件、改数据库状态
                        LYWishListItemModel *model = [self.dataArray objectAtIndex:input.row];
                        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.dataArray];
                        if ([tmpArray containsObject:model]) {
                            [tmpArray removeObject:model];
                        }
                        self.dataArray = [tmpArray copy];
                        

                    }else{
                        //删多条
                        [self addDeleteDataArray];
                        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.dataArray];
                        for (LYWishListItemModel *model in self.deleteArray) {
                            if ([tmpArray containsObject:model]) {
                                [tmpArray removeObject:model];
                            }
                        }
                        self.deleteArray = [NSArray array];
                        self.dataArray = [tmpArray copy];
                    }
                   [subscriber sendCompleted];
                   return nil;
           }];
        }];
    }
    return _deleteItemsCommand;
}


- (void)addDeleteDataArray{
    __block NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.deleteArray];
    [self.dataArray enumerateObjectsUsingBlock:^(LYWishListItemModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            [tmpArray addObject:obj];
        }
    }];
    self.deleteArray = tmpArray;
}

@end
