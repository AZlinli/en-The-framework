//
//  LYDownTimeViewModel.h
//  ToursCool
//
//  Created by tourscool on 12/21/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDownTimeViewModel : NSObject

@property (nonatomic, readonly, class) LYDownTimeViewModel * sharedDownTimeViewModel;

/**
 倒计时
 */
@property (strong, readonly, nonatomic) RACSignal * downTimeSignal;
/**
 倒计时
 */
@property (assign, readonly, nonatomic) NSInteger downTime;
/**
 重置定时器
 */
- (void)resetDownTime;
@end

NS_ASSUME_NONNULL_END
