//
//  LYHomeSendEmailModel.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYHomeIGListBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYHomeSendEmailModel : LYHomeIGListBaseModel

@property (nonatomic, copy) NSString *subTitle;

//自定义height
@property (nonatomic, assign)  CGFloat height;


@end

NS_ASSUME_NONNULL_END
