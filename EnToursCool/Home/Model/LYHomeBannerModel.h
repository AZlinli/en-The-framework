//
//  LYHomeBannerModel.h
//  ToursCool
//
//  Created by tourscool on 12/7/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeIGListBaseModel.h"
@class LYHomeBannerItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface LYHomeBannerModel : LYHomeIGListBaseModel
@property (nonatomic, copy) NSArray<LYHomeBannerItemModel *> * banner;
@end

@interface LYHomeBannerItemModel : NSObject
@property (nonatomic , copy) NSString              * linkUrl;
@property (nonatomic , copy) NSString              * imageUrl;
@end

NS_ASSUME_NONNULL_END
