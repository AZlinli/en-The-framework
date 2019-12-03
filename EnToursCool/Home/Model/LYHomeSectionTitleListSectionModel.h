//
//  LYHomeSectionTitleListSectionModel.h
//  ToursCool
//
//  Created by tourscool on 2/13/19.
//  Copyright © 2019 tourscool. All rights reserved.


#import "LYHomeIGListBaseModel.h"

@class LYHomeSpecialOfferAndStrategyModel,LYDestinationCityInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface LYHomeSectionTitleListSectionModel : LYHomeIGListBaseModel
@property (nonatomic, assign) BOOL showMore;
/**
 1 Explore Destinations  2 .Deals
 */
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString * subTitle;

@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, copy) NSString *keyword;
//限时特价的数据
@property (nonatomic, strong) LYHomeSpecialOfferAndStrategyModel *specialOfferModel;
//我的附近 热门景点数据
@property (nonatomic, strong) LYDestinationCityInfoModel *cityInfoModel;
@end

NS_ASSUME_NONNULL_END
