//
//  LYAccountViewModel.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYAccountViewModel.h"
#import "LYAccountItemModel.h"

@interface LYAccountViewModel()
@property(nonatomic, readwrite, copy) NSArray *dataArray;
@property(nonatomic, readwrite, copy) NSString *headImage;
@property(nonatomic, readwrite, copy) NSString *name;
@property(nonatomic, readwrite, copy) NSString *point;
@end

@implementation LYAccountViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        NSMutableArray *sectionArray1 = [NSMutableArray array];
        LYAccountItemModel *bookingModel = [[LYAccountItemModel alloc] init];
        bookingModel.image = @"account_book_icon";
        bookingModel.title = @"Bookings";
        [sectionArray1 addObject:bookingModel];
        
        LYAccountItemModel *wishlistModel = [[LYAccountItemModel alloc] init];
        wishlistModel.image = @"account_wishlist_icon";
        wishlistModel.title = @"Wishlist";
        [sectionArray1 addObject:wishlistModel];
        
        LYAccountItemModel *travelInformationModel = [[LYAccountItemModel alloc] init];
        travelInformationModel.image = @"account_traveler_information_icon";
        travelInformationModel.title = @"Traveler information";
        [sectionArray1 addObject:travelInformationModel];
        
        LYAccountItemModel *accountModel = [[LYAccountItemModel alloc] init];
        accountModel.image = @"account_account_icon";
        accountModel.title = @"Account";
        [sectionArray1 addObject:accountModel];
        
        NSMutableArray *sectionArray2 = [NSMutableArray array];
        LYAccountItemModel *settingModel = [[LYAccountItemModel alloc] init];
        settingModel.image = @"account_setting_icon";
        settingModel.title = @"Setting";
        [sectionArray2 addObject:settingModel];
        
        LYAccountItemModel *helpCenterModel = [[LYAccountItemModel alloc] init];
        helpCenterModel.image = @"account_help_icon";
        helpCenterModel.title = @"Help Center";
        [sectionArray2 addObject:helpCenterModel];
        
        LYAccountItemModel *aboutTripsoolModel = [[LYAccountItemModel alloc] init];
        aboutTripsoolModel.image = @"account_account_icon";
        aboutTripsoolModel.title = @"About Tripscool";
        [sectionArray2 addObject:aboutTripsoolModel];
        
        self.dataArray = @[sectionArray1,sectionArray2];
    }
    return self;
}

@end
