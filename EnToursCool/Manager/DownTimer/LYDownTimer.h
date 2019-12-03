//
//  LYDownTimer.h
//  ToursCool
//
//  Created by tourscool on 11/8/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDownTimer : NSObject
- (void)startTimerWithTime:(NSInteger)time countDownBlock:(void(^)(NSString * second))countDownBlock;
- (void)endDownTime;
@end

NS_ASSUME_NONNULL_END
