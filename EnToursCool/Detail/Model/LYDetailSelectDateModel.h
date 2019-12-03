//
//  LYDetailSelectDateModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYDetailBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYDetailSelectDateModel : LYDetailBaseModel
/**日期数组*/
@property(nonatomic, strong) NSArray *dateArray;
@end


@interface LYDetailSelectDateModelItem : LYDetailBaseModel
/**time*/
@property(nonatomic, copy) NSString *time;
/**价格*/
@property(nonatomic, copy) NSString *price;
/**特价*/
@property(nonatomic, assign) BOOL isSale;
/**是否是更多按钮*/
@property(nonatomic, assign) BOOL isSeeMore;

@end
NS_ASSUME_NONNULL_END
