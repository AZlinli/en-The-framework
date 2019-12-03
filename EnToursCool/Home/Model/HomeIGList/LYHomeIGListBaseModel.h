//
//  LYHomeIGListBaseModel.h
//  ToursCool
//
//  Created by tourscool on 12/21/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYBaseIGListDiffableModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYHomeIGListBaseModel : LYBaseIGListDiffableModel

@property (nonatomic, copy) NSString * moduleName;
/**
 1 Explore Destinations  2 交易 Deals
 */
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, copy) NSArray * collectionElementKindSectionArray;

@end

NS_ASSUME_NONNULL_END

