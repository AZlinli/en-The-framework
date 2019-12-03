//
//  LYSearchHistoryModel.h
//  ToursCool
//
//  Created by tourscool on 11/28/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSearchHistoryModel : LYBaseModel
@property (nonatomic, copy) NSString * searchName;
@property (nonatomic, copy) NSString * searchKey;
@property (nonatomic, assign) NSInteger searchID;
@end

NS_ASSUME_NONNULL_END
