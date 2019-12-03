//
//  LYSearchHistoryRecordModel.h
//  ToursCool
//
//  Created by tourscool on 12/5/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYTourscoolBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSearchHistoryRecordModel : LYTourscoolBaseCellModel
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * key;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) NSInteger searchHistoryRecordid;
@end

NS_ASSUME_NONNULL_END
