//
//  LYDetailCommonSectionModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYDetailCommonSectionModel : LYDetailBaseModel
/**装有评价、View、Highlights模型的数组*/
@property(nonatomic, strong) NSArray *commonSectionArray;

@end

@interface LYDetailReviewsModel : LYDetailBaseModel

@end

@interface LYDetailViewsModel : LYDetailBaseModel

@end
NS_ASSUME_NONNULL_END
