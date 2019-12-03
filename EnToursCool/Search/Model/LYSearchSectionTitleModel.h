//
//  LYSearchSectionTitleModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTourscoolBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSearchItemModel : LYTourscoolBaseCellModel
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, assign) BOOL  showDeleteState;
@property (nonatomic, assign) BOOL showRightArrow;

@end

@interface LYSearchSectionTitleModel : LYTourscoolBaseCellModel
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) BOOL  isSearchMatch;
@property (nonatomic, copy) NSArray<LYSearchItemModel *> * dataArray;
@end

NS_ASSUME_NONNULL_END
