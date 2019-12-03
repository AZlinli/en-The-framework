//
//  LYWishListItemModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * _Nullable const kSelectedWishNotificationName;
NS_ASSUME_NONNULL_BEGIN

@interface LYWishListItemModel : NSObject

@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *reviews;
@property(nonatomic, copy) NSString *depature;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *savePrice;
@property(nonatomic, copy) NSString *score;
@property(nonatomic, assign) BOOL isEnable;
@property(nonatomic, assign) BOOL isEdit;
@property(nonatomic, assign) BOOL isSelected;

@property (nonatomic, readonly, strong) RACCommand * selectedCommand;
@end

NS_ASSUME_NONNULL_END
