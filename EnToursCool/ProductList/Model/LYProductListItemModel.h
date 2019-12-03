//
//  LYProductListItemModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYProductListItemModel : NSObject
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *reviews;
@property(nonatomic, copy) NSString *depature;
@property(nonatomic, copy) NSString *duration;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *origanlPrice;
@property(nonatomic, copy) NSString *savePrice;
@property(nonatomic, copy) NSString *score;
@property(nonatomic, copy) NSString *special;
@end

NS_ASSUME_NONNULL_END
