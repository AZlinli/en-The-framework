//
//  LYDownTimer.m
//  ToursCool
//
//  Created by tourscool on 11/8/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYDownTimer.h"
#import "LYDateTools.h"
@interface LYDownTimer()
/**
 定时器
 */
@property (strong, nonatomic) dispatch_source_t timer;
/**
 总时间
 */
@property (assign, nonatomic) NSInteger allTime;
/**
 经过时间
 */
@property (assign, nonatomic) NSInteger passTime;
@property (nonatomic, strong) NSLock * lock;
@end
@implementation LYDownTimer

- (instancetype)init
{
    if (self = [super init]) {
        self.lock = [[NSLock alloc] init];
        self.lock.name = @"com.zmcs.toursCool.ToursCool.DownTimer.lock";
        @weakify(self);
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"DidEnterBackgroundTime"];
        }];
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            NSDate * enterForegroundTime = [NSDate date];
            NSDate * resignActiveTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"DidEnterBackgroundTime"];
            NSInteger resignActive = [LYDateTools timeIntervalSince1970WithDate:resignActiveTime];
            NSInteger enterForeground = [LYDateTools timeIntervalSince1970WithDate:enterForegroundTime];
            if (resignActive && enterForeground && self.allTime > 1) {
                NSInteger res = enterForeground - resignActive;
                if (self.allTime >= res) {
                    self.allTime = self.allTime - (enterForeground - resignActive);
                }else{
                    self.allTime = 0;
                }
            }
        }];
    }
    return self;
}

- (void)startTimerWithTime:(NSInteger)time countDownBlock:(void(^)(NSString * second))countDownBlock
{
    self.allTime = time;
    [self endDownTime];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    uint64_t interval = (uint64_t)(1.0* NSEC_PER_SEC);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    dispatch_source_set_timer(self.timer, start, interval, 0);
    @weakify(self);
    dispatch_source_set_event_handler(self.timer, ^{
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive || [UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
                LYNSLog(@"xxxxxx");
                self.allTime --;
            }
            if (self.allTime <= 0) {
                countDownBlock(nil);
                [self endDownTime];
            }else{
                countDownBlock([@(self.allTime) stringValue]);
            }
        });
    });
    dispatch_resume(self.timer);
}

- (void)endDownTime
{
    // 防止timer 为nil时 调用 dispatch_source_cancel
    [self.lock lock];
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    [self.lock unlock];
}

- (void)dealloc
{
    LYNSLog(@"%@", NSStringFromClass([self class]));
}

@end
