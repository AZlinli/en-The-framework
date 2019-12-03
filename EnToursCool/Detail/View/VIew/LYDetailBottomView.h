//
//  LYDetailBottomView.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDetailBottomView : UIView

@property (nonatomic, copy) void(^bookingBtnClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
