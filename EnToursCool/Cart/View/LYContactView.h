//
//  LYContactView.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TelephoneBlock)();
typedef void(^OnlineBlock)();
typedef void(^EmailBlock)();
typedef void(^CancleBlock)();


@interface LYContactView : UIView

- (instancetype)initWithContactViewWithTelephone:(TelephoneBlock)teleblock online:(OnlineBlock)onlineBlock email:(EmailBlock)emailBlock cancle:(CancleBlock)cancleBlock;

@end

NS_ASSUME_NONNULL_END
