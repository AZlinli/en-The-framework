//
//  LYHomeMenuModel.h
//  ToursCool
//
//  Created by tourscool on 12/7/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeIGListBaseModel.h"
@class LYHomeMenuItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface LYHomeMenuModel : LYHomeIGListBaseModel
@property (nonatomic, copy) NSArray<LYHomeMenuItemModel *> * nav;
@end
//
@interface LYHomeMenuItemModel : NSObject
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * jumpUrl;
@property (nonatomic , copy) NSString              * eventID;

@end

NS_ASSUME_NONNULL_END
