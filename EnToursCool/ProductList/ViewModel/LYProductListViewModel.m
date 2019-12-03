//
//  LYProductListViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListViewModel.h"
#import "LYProductListItemModel.h"
#import "LYProductListPopFliterModel.h"
#import "LYProductListFliterModel.h"

@interface LYProductListViewModel ()
@property(nonatomic, readwrite, copy) NSArray *dataArray;
@property(nonatomic, readwrite, copy) NSArray *sortArray;
@property(nonatomic, readwrite, copy) NSArray *durationArray;
@property(nonatomic, readwrite, copy) NSArray *fliterArray;
@property(nonatomic, readwrite, copy) RACCommand *getDataCommand;
@end

@implementation LYProductListViewModel


- (instancetype)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        LYProductListPopFliterModel *model1 = [[LYProductListPopFliterModel alloc] init];
        model1.title = @"Price";
        model1.value = @"1";
        [tmpArray addObject:model1];
        LYProductListPopFliterModel *model2 = [[LYProductListPopFliterModel alloc] init];
       model2.title = @"Price";
       model2.value = @"1";
       [tmpArray addObject:model2];
        LYProductListPopFliterModel *model3 = [[LYProductListPopFliterModel alloc] init];
       model3.title = @"Price";
       model3.value = @"1";
       [tmpArray addObject:model3];
        
        self.sortArray = [tmpArray copy];
        
        
        NSMutableArray *tmpArray1 = [NSMutableArray array];
        LYProductListItemModel *item = [[LYProductListItemModel alloc] init];
        item.name = @"diagfsuagfiugasiduyfgdiagfsuagfiugasiduyfgdiagfsuagfiugasiduyfg";
        item.image = @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg";
        item.reviews = @"12 Reviews";
        item.depature = @"Depature :Las Vegas";
        item.duration = @"Duration :3 Days";
        item.price = @"US$8991.00";
        item.savePrice = @"US$900 saved";
        item.score = @"4.5";
        item.special = @"30%OFF";
        item.origanlPrice = @"US$900";
        [tmpArray1 addObject:item];
        
        LYProductListItemModel *item2 = [[LYProductListItemModel alloc] init];
        item2.name = @"diagfsuagfiugasiduyfg";
        item2.image = @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg";
        item2.reviews = @"12 Reviews";
        item2.depature = @"Depature :Las Vegas";
        item2.duration = @"Duration :3 Days";
        item2.price = @"US$8991.00";
        item2.savePrice = @"US$900 saved";
        item2.score = @"4";
        [tmpArray1 addObject:item2];
        
        self.dataArray = [tmpArray1 copy];
        
        NSMutableArray *section0 = [NSMutableArray array];
        LYProductListFliterSectionModel * sectionModel0 = [[LYProductListFliterSectionModel alloc] init];
        sectionModel0.title  = @"Attractions";
        sectionModel0.isShowMore = YES;
        sectionModel0.onlySelectedOne = NO;
        
        LYProductListFliterModel *item0 = [[LYProductListFliterModel alloc] init];
        item0.title = @"Grand Canyon";
        item0.value = @"23";
        [section0 addObject:item0];
        
        LYProductListFliterModel *item1 = [[LYProductListFliterModel alloc] init];
        item1.title = @"Grand Canyon1";
        item1.value = @"23";
        [section0 addObject:item1];
        
        LYProductListFliterModel *item7 = [[LYProductListFliterModel alloc] init];
        item7.title = @"Grand Canyon2";
        item7.value = @"23";
        [section0 addObject:item7];
        
        sectionModel0.dataArray = [section0 copy];
        
        NSMutableArray *section1 = [NSMutableArray array];
        LYProductListFliterSectionModel * sectionModel1 = [[LYProductListFliterSectionModel alloc] init];
        sectionModel1.title  = @"Attractions";
        sectionModel1.isShowMore = YES;
        sectionModel1.onlySelectedOne = YES;
        
        LYProductListFliterModel *item3 = [[LYProductListFliterModel alloc] init];
        item3.title = @"Grand Canyon";
        item3.value = @"23";
        [section1 addObject:item3];
        
        LYProductListFliterModel *item4 = [[LYProductListFliterModel alloc] init];
        item4.title = @"Grand Canyon1";
        item4.value = @"23";
        [section1 addObject:item4];
        
        LYProductListFliterModel *item5 = [[LYProductListFliterModel alloc] init];
        item5.title = @"Grand Canyon2";
        item5.value = @"23";
        [section1 addObject:item5];
        sectionModel1.dataArray = [section1 copy];
        
        self.fliterArray = @[sectionModel0,sectionModel1];
        
        
        
    }
    return self;
}

-(void)buildFliterParameter{
    //解析勾选的参数
}

- (RACCommand *)getDataCommand{
    if (!_getDataCommand) {
        
    }
    return _getDataCommand;
}

@end
