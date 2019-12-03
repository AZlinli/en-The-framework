//
//  LYPickupDetailsModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYDetailBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYPickupDetailsModel : LYDetailBaseModel
/**数组*/
@property(nonatomic, strong) NSArray *itemArray;
/**名字*/
@property(nonatomic, copy) NSString *title;
/**数量是否大于3*/
@property(nonatomic, assign) BOOL isShowFooter;
/**seeMore*/
@property(nonatomic, assign) BOOL isSeeMore;
@end

@interface LYPickupDetailsModelItem : LYDetailBaseModel
/**时间*/
@property(nonatomic, copy) NSString *time;
/**内容*/
@property(nonatomic, copy) NSString *text;
@end

NS_ASSUME_NONNULL_END
