//
//  LYIntegralDetailsModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,IntegralDetailsStatus)
{
    IntegralDetailsStatus_Get = 0,
    IntegralDetailsStatus_Pay,
    IntegralDetailsStatus_Pending
};
@interface LYIntegralDetailsModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, assign) IntegralDetailsStatus status;
@end

NS_ASSUME_NONNULL_END
