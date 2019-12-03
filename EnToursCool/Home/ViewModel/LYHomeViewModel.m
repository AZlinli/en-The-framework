//
//  LYHomeViewModel.m
//  ToursCool
//
//  Created by tourscool on 11/26/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeViewModel.h"

#import "LYHomeBannerModel.h"
#import "LYHomeMenuModel.h"
#import "LYHomeSectionTitleListSectionModel.h"
#import "LYHomeExploreModel.h"
#import "LYHomeDealsModel.h"
#import "LYHomeSendEmailModel.h"
#import "LYInspirationModel.h"
#import "LYHomeNoteModel.h"

//#import "LYUserInfoManager.h"
#import "LYHTTPRequestManager.h"

//static CGFloat SpaceHeight = 10.f;

static LYHomeViewModel * homeViewModel = nil;
@interface LYHomeViewModel ()
@property (nonatomic, readwrite, copy) NSArray * homeSectionArray;
/**
 数组添加数据完成
 */
@property (nonatomic, readwrite, strong) NSString *productLinkImage;
@property (nonatomic, readwrite, strong) NSArray *productLinkArray;
@property (nonatomic, readwrite, strong) NSMutableArray * homeTopsalesMutableArray;

@property (nonatomic, readwrite, strong) RACCommand * homeHTTPRequestCommand;

@end
@implementation LYHomeViewModel

/**
 防止切换语言而引起错误

 @return LYHomeViewModel
 */
+ (LYHomeViewModel *)sharedHomeViewModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeViewModel = [[LYHomeViewModel alloc] init];
    });
    return homeViewModel;
}


- (instancetype)init
{
    if (self = [super init])
    {
        [self.homeHTTPRequestCommand execute:nil];
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kCloseEmailViewNotificationIdentifier object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            NSMutableArray *homeArray = [NSMutableArray arrayWithArray:self.homeSectionArray];
            NSMutableArray *deletArray = [NSMutableArray array];
            for (int i = 0 ; i < self.homeSectionArray.count; i++)
            {
                LYHomeIGListBaseModel *model = self.homeSectionArray[i];
                if ([model isKindOfClass:[LYHomeSendEmailModel class]])
                {
                    [deletArray addObject:model];
                    break;
                }
            }
            [homeArray removeObjectsInArray:deletArray.copy];
            self.homeSectionArray = homeArray.copy;
        }];

    }
    return self;
}


- (RACCommand *)homeHTTPRequestCommand
{
    if (!_homeHTTPRequestCommand) {
//        @weakify(self);
        _homeHTTPRequestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableArray * homeSectionMutableArray = [NSMutableArray array];
            // FIXME: LDL的banner数据测试
            NSArray * bannerArray = @[@{@"image":@"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg" , @"link" : @"https://m.tourscool.com/act/new_year_1028.html" , @"title": @"haha"},@{@"image":@"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg" , @"link" : @"https://m.tourscool.com/act/new_year_1028.html" , @"title": @"ohMyGod"},@{@"image":@"http://assets.tourscool.com/uploads/inn/2019/11/13/952/nhIVKAceeb9VObnX0JPbAnNw2yA.jpg" , @"link" : @"https://m.tourscool.com/act/thanksgiving_1021.html" , @"title": @"dflgjso;bj;f;"},@{@"image":@"http://assets.tourscool.com/uploads/inn/2019/11/13/952/tVAWQJy7A93YPGdVpjMlH2saFfU.jpg" , @"link" : @"tourscool://xf.qa.tourscool.net/product/list?item_type=0&category=90" , @"title": @"cvkxbv;lsdbj;"}];
            NSMutableDictionary *allDict = @{@"banner" : bannerArray}.mutableCopy;
           if (bannerArray.count) {
               LYHomeBannerModel * banner = [LYHomeBannerModel mj_objectWithKeyValues:allDict.copy];
               [homeSectionMutableArray addObject:banner];
           }
             // FIXME: LDL的menu菜单数据测试
            NSArray *menus = @[@{@"nav_image" : @"http://assets.tourscool.com/uploads/inn/2019/11/14/952/b2qekUkzyAjpQJoo7PyAJjG-6Pw.png" , @"nav_link" : @"https://m.tourscool.com/act/new_year_1028.html" , @"nav_title" : @"Travel Package"} , @{@"nav_image" : @"http://assets.tourscool.com/uploads/inn/2019/11/14/952/dnYk4r6GkEU1oYVKMawS069scTs.png" , @"nav_link" : @"https://m.tourscool.com/act/new_year_1028.html" , @"nav_title" : @"Travel Package"},@{@"nav_image" : @"http://assets.tourscool.com/uploads/inn/2019/11/14/952/TN0yJYfMl82317P5pEdShiDg0pM.png" , @"nav_link" : @"https://m.tourscool.com/act/new_year_1028.html" , @"nav_title" : @"Travel Package"},@{@"nav_image" : @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/6XXPRtrK9CYQjAGrj5cKKmpmQRQ.png" , @"nav_link" : @"https://m.tourscool.com/act/new_year_1028.html" , @"nav_title" : @"Travel Package"},@{@"nav_image" : @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/rKu3a5cNO-o10zC7c1pFA-M_zfc.png" , @"nav_link" : @"https://m.tourscool.com/act/new_year_1028.html" , @"nav_title" : @"Travel Package"},@{@"nav_image" : @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/SRD6oHW0fObYli9d8a6kUdCgv8U.png" , @"nav_link" : @"https://m.tourscool.com/act/new_year_1028.html" , @"nav_title" : @"Travel Package"}];
            [allDict setObject:menus forKey:@"nav"];
            if (menus.count)
            {
                LYHomeMenuModel *menu = [LYHomeMenuModel mj_objectWithKeyValues:allDict.copy];
                menu.footerHeight = 10;
                [homeSectionMutableArray addObject:menu];
            }
            // FIXME: LDL的推荐目的地数据测试
       /*       NSArray * destinationArray = allDataDic[@"rec_dest"];
              if ([destinationArray isKindOfClass:[NSArray class]] && destinationArray.count > 0) {
                  
                  LYHomeSectionTitleListSectionModel * homeSectionTitleListSectionModel = [[LYHomeSectionTitleListSectionModel alloc] init];
                  homeSectionTitleListSectionModel.showMore = YES;
                  homeSectionTitleListSectionModel.type = 1;
                  homeSectionTitleListSectionModel.headerHeight = 14.f;
                  homeSectionTitleListSectionModel.moduleName = [LYLanguageManager ly_localizedStringForKey:@"Home_Recommand_Destionation_Title"];
                  homeSectionTitleListSectionModel.headerHeight = SpaceHeight;
                  [homeSectionMutableArray addObject:homeSectionTitleListSectionModel];
                  
                  LYRecommendDestinationModel *homeDestinationModel = [[LYRecommendDestinationModel alloc] init];
                  
                  NSArray * destnationItems = [[LYRecommendDestinationItemModel mj_objectArrayWithKeyValuesArray:destinationArray] copy];
                  homeDestinationModel.itemArray = destnationItems;
                  
                  [homeSectionMutableArray addObject:homeDestinationModel];
                  self.homeDestinationModel = homeDestinationModel;
                  
              }*/
            
            LYHomeSectionTitleListSectionModel *homeSection = [[LYHomeSectionTitleListSectionModel alloc] init];
            homeSection.showMore = YES;
            homeSection.type = 1;
            homeSection.moduleName = @"Explore Destinations";
            [homeSectionMutableArray addObject:homeSection];
            
            // FIXME: LDL的推荐目的地/国家/地址数据测试
            LYHomeExploreModel *explore = [[LYHomeExploreModel alloc] init];
            explore.footerHeight = 10;
            [homeSectionMutableArray addObject:explore];
            
            // FIXME: LDL的Deals地数据测试
            LYHomeSectionTitleListSectionModel *homeSection2 = [[LYHomeSectionTitleListSectionModel alloc] init];
           homeSection2.showMore = YES;
           homeSection2.type = 2;
           homeSection2.moduleName = @"Deals";
           [homeSectionMutableArray addObject:homeSection2];
            
             // FIXME: LDL的Deals地数据测试contentView
            
            LYHomeDealsModel *dealsModel = [[LYHomeDealsModel alloc] init];
            dealsModel.footerHeight = 10;
            [homeSectionMutableArray addObject:dealsModel];
            
             // FIXME: LDL的sendEmail地数据测试
            LYHomeSendEmailModel *emailM = [[LYHomeSendEmailModel alloc] init];
            
            emailM.footerHeight = 10;
            emailM.subTitle = @"Just enter your email below to keep  emo keep up with all the latest deals and discountsur emp up with all the latest deals and discouneals and discounts！";
            [homeSectionMutableArray addObject:emailM];
            
            // FIXME: LDL的Inspiration组头的数据测试
               LYHomeSectionTitleListSectionModel *homeSection3 = [[LYHomeSectionTitleListSectionModel alloc] init];
              homeSection3.showMore = NO;
              homeSection3.type = 1;
              homeSection3.moduleName = @"Inspiration";
              [homeSectionMutableArray addObject:homeSection3];
            
             // FIXME: LDL的Inspiration列表的数据测试
            LYInspirationModel *inspirationM = [[LYInspirationModel alloc] init];
            inspirationM.headerHeight = 7;
            inspirationM.footerHeight = 14;
            [homeSectionMutableArray addObject:inspirationM];
                       
            // FIXME: LDL的note设置数据测试
            LYHomeNoteModel *homeNoteM = [[LYHomeNoteModel alloc] init];
            homeNoteM.headerHeight = 10;
            homeNoteM.footerHeight = 10;
            [homeSectionMutableArray addObject:homeNoteM];
            
           self.homeSectionArray = [homeSectionMutableArray copy];
           return [RACSignal empty];
        }];
    }
    return _homeHTTPRequestCommand;
}

@end
