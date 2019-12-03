//
//  LYTourOrderViewController.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LDLNewsViewController.h"

//订单状态（待支付，待出行，旅行中，全部）
typedef NS_ENUM(NSUInteger,OrderStatus)
{
    OrderStatus_waitPay = 0,
    OrderStatus_waitGo,
    OrderStatus_traveling,
    OrderStatus_All
};

NS_ASSUME_NONNULL_BEGIN

@interface LYTourOrderViewController : LDLNewsViewController
@end

NS_ASSUME_NONNULL_END
