//
//  LYDetailTableHeaderModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYDetailBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYDetailTableHeaderModel : LYDetailBaseModel
/**标题*/
@property(nonatomic, copy) NSString *title;

/**tag数组*/
@property(nonatomic, strong) NSArray *tagArray;

/**header高度*/
@property(nonatomic, assign) CGFloat tableHeaderH;

/**banner数据源*/
@property(nonatomic, strong) NSArray *bannerArray;
@end

NS_ASSUME_NONNULL_END
