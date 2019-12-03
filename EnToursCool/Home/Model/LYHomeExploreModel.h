//
//  LYHomeExploreModel.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYHomeIGListBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class LYExploreAdressModel;

@interface LYHomeExploreModel : LYHomeIGListBaseModel

@property (nonatomic, copy) NSArray *countries;

@property (nonatomic, copy) NSArray <LYExploreAdressModel *>*adresses;

@end

@interface LYExploreAdressModel : NSObject
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * jumpUrl;
@property (nonatomic , copy) NSString              * eventID;

@end

NS_ASSUME_NONNULL_END
