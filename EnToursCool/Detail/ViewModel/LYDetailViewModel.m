//
//  LYDetailViewModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailViewModel.h"
#import "LYRouteListModel.h"
#import "LYDetailTopHeaderModel.h"
#import "LYDetailCommonSectionModel.h"
#import "LYDetailTableHeaderModel.h"
#import "LYDetailExpenseModel.h"
#import "LYDetailSpecialnotesModel.h"
#import "LYDetailSelectDateModel.h"
#import "LYDetailHighlightsModel.h"
#import "LYPickupDetailsModel.h"

@interface LYDetailViewModel()
@property(nonatomic, strong, readwrite) NSArray *detailSectionArray;
@property (nonatomic, readwrite, strong) RACCommand * showMoreRouteCommand;
@property (nonatomic, readwrite, strong) RACCommand * showMoreSpecialNotesCommand;
@property (nonatomic, readwrite, strong) RACCommand * showMoreHighlightsCommand;
@property (nonatomic, readwrite, strong) RACCommand * footerShowMoreCommand;
@property (nonatomic, readwrite, strong) RACCommand * showMoreExpenseCommand;

@property (nonatomic, readwrite, strong) RACCommand * selectTypeButtonCommand;
@property (nonatomic, readwrite, strong) NSNumber * selectTypeButton;

@end


@implementation LYDetailViewModel


- (NSArray *)detailSectionArray {
    if (!_detailSectionArray) {
        LYRouteListContentTextModel *textModel = [LYRouteListContentTextModel new];
        textModel.text = @"Take a pleasant flight to Denver, the State Capital of Colorado! Please meet our friendly tour guide at Baggage Claim #6 located inside the East Terminal by 1:30PM. Drive to the State House of Colorado";
        
    
        LYRouteListScenicSpotModel *soptModel = [LYRouteListScenicSpotModel new];
        soptModel.text = @"The Crazy Horse Memorial is a mountain monument under construction on privately held land in the Black Hills. The memorial was commissioned by Henry Standing Bear, a Lakota elder, to be sculpted by See more";
        soptModel.imageArray = @[@"http://pic44.nipic.com/20140723/18505720_094503373000_2.jpg",
        @"http://img.52z.com/upload/news/image/20180621/20180621055734_59936.jpg",
        @"http://b-ssl.duitang.com/uploads/blog/201312/04/20131204184148_hhXUT.jpeg",
        @"http://b-ssl.duitang.com/uploads/item/201208/30/20120830173930_PBfJE.jpeg"];
        soptModel.title = @"Denver";
        
        LYRouteListhHotelModel *hotelModel = [LYRouteListhHotelModel new];
        hotelModel.title = @"Accommodation";
        hotelModel.text = @"Ramada Inn Gillette La Quinta Midvale or similar ";
        
        LYRouteListhMealsModel *mealsModel = [LYRouteListhMealsModel new];
        mealsModel.title = @"Meals";
        mealsModel.text = @"Ramada Inn Gillette  La Quinta Midvale or similar";
        
        LYRouteListModel *model = [[LYRouteListModel alloc]init];
        model.title = @"Day1 Hometown – Denver – Cheyenne";
        model.showMore = @1;
        model.listArray = @[textModel,soptModel,hotelModel,mealsModel];
        
        LYRouteListModel *model1 = [[LYRouteListModel alloc]init];
        model1.title = @"Day2 Hometown – Denver – Cheyenne";
        model1.showMore = @1;
        model1.listArray = @[textModel,soptModel,soptModel,soptModel,soptModel,hotelModel,mealsModel];

        LYRouteListModel *model2 = [[LYRouteListModel alloc]init];
        model2.title = @"Day3 Hometown – Denver – Cheyenne";
        model2.showMore = @1;
        model2.listArray = @[textModel,soptModel,hotelModel,mealsModel];
        //吸顶的模型
        LYDetailTopHeaderModel *headerModel = [[LYDetailTopHeaderModel alloc]init];
        //前面reviews、Highlights、View的模型
        LYDetailCommonSectionModel *commonScetionModel = [[LYDetailCommonSectionModel alloc]init];
        
        LYDetailReviewsModel *reviewsModel = [[LYDetailReviewsModel alloc]init];
        LYDetailViewsModel *viewsModel = [[LYDetailViewsModel alloc]init];
        //选择日期
        LYDetailSelectDateModel *selectDateModel = [LYDetailSelectDateModel new];
        LYDetailSelectDateModelItem *selectDateModelitem = [LYDetailSelectDateModelItem new];
        selectDateModelitem.time = @"Jul11";
        selectDateModelitem.price = @"$368";
        selectDateModelitem.isSale = NO;
        
        LYDetailSelectDateModelItem *selectDateModelitem1 = [LYDetailSelectDateModelItem new];
        selectDateModelitem1.time = @"Jul12";
        selectDateModelitem1.price = @"$368";
        selectDateModelitem1.isSale = YES;
        
        LYDetailSelectDateModelItem *selectDateModelitem2 = [LYDetailSelectDateModelItem new];
        selectDateModelitem2.time = @"Jul13";
        selectDateModelitem2.price = @"$368";
        selectDateModelitem2.isSale = YES;
        
        LYDetailSelectDateModelItem *selectDateModelitem3 = [LYDetailSelectDateModelItem new];
        selectDateModelitem3.time = @"Jul13";
        selectDateModelitem3.price = @"$368";
        selectDateModelitem3.isSale = YES;
        selectDateModelitem3.isSeeMore = YES;

        selectDateModel.dateArray = @[selectDateModelitem,selectDateModelitem1,selectDateModelitem2,selectDateModelitem3];
        
        //Highlights
        LYDetailHighlightsModel *highlightsModel = [LYDetailHighlightsModel  new];
        highlightsModel.text = @"15+ Classic  15+ Classic attractions in Yellowstone, Stay two  nights in Yellowstone National Park. 15+ Classic attractions in Yellowstone, Stay two  nights in Yellowstone National Park. 15+ Classic attractions in Yellowstone, Stay two  nights in Yellowstone National Park. 15+ Classic attractions in Yellowstone, Stay two  nights in Yellowstone National Park. 15+ Classic attractions in Yellowstone, Stay two  nights in Yellowstone National Park. 15+ Classic attractions in Yellowstone, Stay two  nights in Yellowstone National Park.";
        highlightsModel.isShowMore = NO;
        commonScetionModel.commonSectionArray = @[selectDateModel,viewsModel,highlightsModel,reviewsModel];
        //头部section
        LYDetailTableHeaderModel *tableHeaderModel = [LYDetailTableHeaderModel new];
        tableHeaderModel.tagArray = @[@"Lowest Price Guarantee",@"Buy 2 Get 2 for Free",@"Small Group",@"Small Group"];
        tableHeaderModel.title = @"6 Days Yellowstone, Mt. Rushmore,Great Salt Lake Tour From Denver with TwoNights in Yellowstone NP";
        tableHeaderModel.bannerArray = @[  @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg",
        @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/Cm4-XysDY-A_T7IBuRSL8HUJmlU.jpg",
        @"http://assets.tourscool.com/uploads/inn/2019/11/13/952/nhIVKAceeb9VObnX0JPbAnNw2yA.jpg",
        ];
        //PickupDetails
        LYPickupDetailsModel *pickupDetailsModel = [[LYPickupDetailsModel alloc]init];
        LYPickupDetailsModelItem *pickupDetailsModelItem = [[LYPickupDetailsModelItem alloc]init];
        pickupDetailsModelItem.time = @"7:00AM";
        pickupDetailsModelItem.text = @"Hotel Irvine— Eats Restaurant Entrance 17900 Jamboree Rd, Irvine, CA 92614";
        
        LYPickupDetailsModelItem *pickupDetailsModelItem1 = [[LYPickupDetailsModelItem alloc]init];
        pickupDetailsModelItem1.time = @"7:00AM";
        pickupDetailsModelItem1.text = @"(Hotel Guest Only)Holiday Inn La Mirada 14299 Firestone Blvd, La Mirada, CA 90638";
        
        LYPickupDetailsModelItem *pickupDetailsModelItem2 = [[LYPickupDetailsModelItem alloc]init];
        pickupDetailsModelItem2.time = @"7:00AM";
        pickupDetailsModelItem2.text = @"(Hotel Guest Only)Holiday Inn La Mirada 14299 Firestone Blvd, La Mirada, CA 90638";
        
        LYPickupDetailsModelItem *pickupDetailsModelItem3 = [[LYPickupDetailsModelItem alloc]init];
        pickupDetailsModelItem3.time = @"7:00AM";
        pickupDetailsModelItem3.text = @"(Hotel Guest Only)Holiday Inn La Mirada 14299 Firestone Blvd, La Mirada, CA 90638";
        
        
        pickupDetailsModel.itemArray = @[pickupDetailsModelItem,pickupDetailsModelItem1,pickupDetailsModelItem2,pickupDetailsModelItem3];
        pickupDetailsModel.title = @"Pick-up Details";
        //Expense
        LYDetailExpenseModel *expenseModel = [LYDetailExpenseModel new];
        
        LYDetailExpenseModelItem *expenseModelItem = [LYDetailExpenseModelItem new];
        expenseModelItem.title = @"Price Special Note";
        expenseModelItem.text = @"The third guest joins the tour at a discounted rate (except applicable admission fees, mandatory tips, optional activities, and own expense items) on shared room basis.\r\n Departs from Denver and ends in SLC, visit Capitol Hill,Temple Square in SLC. ";
        expenseModelItem.isShowMore = NO;
        expenseModelItem.type = LYDetailExpenseModelItemPriceSpecialNote;

        
        LYDetailExpenseModelItem *expenseModelItem1 = [LYDetailExpenseModelItem new];
        expenseModelItem1.title = @"Inclusions";
        expenseModelItem1.text = @"Night Hotel (Standard Room)\r\nTour Guide Service \r\n Ground Transportation";
        expenseModelItem1.isShowMore = NO;
        expenseModelItem1.type = LYDetailExpenseModelItemInclusions;
        
        LYDetailExpenseModelItem *expenseModelItem2 = [LYDetailExpenseModelItem new];
        expenseModelItem2.title = @"Exclusions";
        expenseModelItem2.text = @"Meals, Personal expenses and so on.\r\nOptional Tour Items\r\nMandatory Fee: $140 \r\n Tips \r\n Own Expense \r\nTips $10 \r\n per day ";
        expenseModelItem2.isShowMore = NO;
        expenseModelItem2.type = LYDetailExpenseModelItemExclusions;

        expenseModel.dataArray = @[expenseModelItem,expenseModelItem1,expenseModelItem2];
        
        //Specialnotes
        LYDetailSpecialnotesModel *specialnotesModel = [LYDetailSpecialnotesModel new];
        specialnotesModel.sectionTitle = @"Cancellation and Change Notice";
        specialnotesModel.showMore = @1;
        specialnotesModel.text = @"★【佛州暢玩】賞迷人自然之景、遊特色人文景觀、享多樣遊園之樂<br />★【佛州風光】大沼澤公園的紅樹林綿延數百裡，根部交錯盤生，一個個小島因此而成；<br />★【度假勝地】冬日避寒度假勝地西棕櫚灘，領略大西洋的美景；<br />★【絕美風景】當天空、雲彩變成大海的陪襯，西礁島的美你絕不能錯過；<br />";
        
        LYDetailSpecialnotesModel *specialnotesModel1 = [LYDetailSpecialnotesModel new];
        specialnotesModel1.sectionTitle = @"Special Notes";
        specialnotesModel1.showMore = @0;
        specialnotesModel1.text = @"★【家庭出遊】國家公園、經典打卡、主題樂園、折扣血拼，一次出遊滿足全家需求；<br />★【優選酒店】三晚入住Holiday Inn假日酒店；可升級三晚Resort度假村海灘酒店。<br />★【親子樂園】奧蘭多13大主題園區或（太空奇妙之旅肯尼迪航空航天中心、心曠神怡的墨西哥灣、傳奇古鎮聖奧古斯丁）3大特色一日遊任選其2.<br />★【血拼到底】低稅率，大折扣奧特萊斯自由購物<br />";
        
        LYDetailSpecialnotesModel *specialnotesModel2 = [LYDetailSpecialnotesModel new];
        specialnotesModel2.sectionTitle = @"Reservation";
        specialnotesModel2.showMore = @0;
        specialnotesModel2.text = @"★ 【絕美景色】：白色雪峰，茂密森林，湛藍湖水，皇後鎮是南半球四季皆宜的旅遊度假區；<br />★ 【親近自然】：靜靜地聽著瀑布的聲音，享受片刻的寧靜，神奇峽灣給你一整天的好心情；<br />★ 【壯麗冰川】：千年的消融和凍結形成的冰川美景，福克斯冰川的巍峨壯觀一定會震撼你；<br />";
        
        LYDetailSpecialnotesModel *specialnotesModel3 = [LYDetailSpecialnotesModel new];
        specialnotesModel3.sectionTitle = @"Terms and Conditions";
        specialnotesModel3.showMore = @0;
        specialnotesModel3.text = @"★ 絕美景色：白色雪峰，茂密森林，湛藍湖水，皇後鎮是南半球四季皆宜的旅遊度假區；<br />★ 親近自然：靜靜地聽著瀑布的聲音，享受片刻的寧靜，神奇峽灣給你一整天的好心情；<br />★ 壯麗冰川：千年的消融和凍結形成的冰川美景，福克斯冰川的巍峨壯觀一定會震撼你；<br />";
        
        
        _detailSectionArray = @[tableHeaderModel,commonScetionModel,headerModel,model,model1,model2,pickupDetailsModel,expenseModel,specialnotesModel,specialnotesModel1,specialnotesModel2,specialnotesModel3];
    }
    return _detailSectionArray;
}

- (RACCommand *)showMoreRouteCommand
{
    if (!_showMoreRouteCommand) {
        _showMoreRouteCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                LYRouteListModel * mode = input[@"model"];
                mode.showMore = @(![mode.showMore boolValue]);
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _showMoreRouteCommand;
}

- (RACCommand *)showMoreSpecialNotesCommand
{
    if (!_showMoreSpecialNotesCommand) {
        _showMoreSpecialNotesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                LYDetailSpecialnotesModel * mode = input[@"model"];
                mode.showMore = @(![mode.showMore boolValue]);
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _showMoreSpecialNotesCommand;
}

- (RACCommand *)showMoreHighlightsCommand
{
    if (!_showMoreHighlightsCommand) {
        _showMoreHighlightsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                LYDetailHighlightsModel * mode = input[@"model"];
                mode.isShowMore = !mode.isShowMore;
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _showMoreHighlightsCommand;
}

- (RACCommand *)showMoreExpenseCommand
{
    if (!_showMoreExpenseCommand) {
        _showMoreExpenseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                LYDetailExpenseModelItem * mode = input[@"model"];
                mode.isShowMore = !mode.isShowMore;
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _showMoreExpenseCommand;
}

- (RACCommand *)footerShowMoreCommand
{
    if (!_footerShowMoreCommand) {
        _footerShowMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                LYPickupDetailsModel * mode = input[@"model"];
                mode.isSeeMore = !mode.isSeeMore;
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _footerShowMoreCommand;
}

- (RACCommand *)selectTypeButtonCommand
{
    if (!_selectTypeButtonCommand) {
        @weakify(self);
        _selectTypeButtonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *  _Nullable input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.selectTypeButton = input;
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _selectTypeButtonCommand;
}

- (void)updateSelectTypeButtonWithTag:(NSInteger)tag
{
    if (self.selectTypeButton.integerValue == tag) {
        return;
    }
    self.selectTypeButton = @(tag);
}

- (NSInteger)obtainSectionArrayWithModel:(Class)model
{
    __block NSInteger index = 0;
    [self.detailSectionArray enumerateObjectsUsingBlock:^(LYDetailBaseModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:model]) {
            index = idx;
            * stop = YES;
        }
    }];
    return index;
}
@end
