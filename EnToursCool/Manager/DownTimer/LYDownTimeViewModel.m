//
//  LYDownTimeViewModel.m
//  ToursCool
//
//  Created by tourscool on 12/21/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYDownTimeViewModel.h"
#import "LYDateTools.h"
static LYDownTimeViewModel * downTimeViewModel = nil;
@interface LYDownTimeViewModel()
@property (strong, readwrite, nonatomic) RACSignal * downTimeSignal;
@property (assign, readwrite, nonatomic) NSInteger downTime;
@end

@implementation LYDownTimeViewModel

+ (LYDownTimeViewModel *)sharedDownTimeViewModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downTimeViewModel = [[LYDownTimeViewModel alloc] init];
    });
    return downTimeViewModel;
}

- (instancetype)init
{
    if (self = [super init]) {
        _downTime = 1;
        @weakify(self);
        _downTimeSignal = [[[RACSignal interval:1 onScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground] withLeeway:0] takeUntil:self.rac_willDeallocSignal] doNext:^(NSDate * _Nullable x) {
            @strongify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
                    self.downTime ++;
                }
            });
        }];
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillResignActiveNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"ResignActiveTime"];
        }];
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            NSDate * enterForegroundTime = [NSDate date];
            NSDate * resignActiveTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"ResignActiveTime"];
            NSInteger resignActive = [LYDateTools timeIntervalSince1970WithDate:resignActiveTime];
            NSInteger enterForeground = [LYDateTools timeIntervalSince1970WithDate:enterForegroundTime];
            if (resignActive && enterForeground && self.downTime > 1) {
                self.downTime = self.downTime + (enterForeground - resignActive);
            }
        }];
    }
    return self;
}

- (void)resetDownTime
{
    self.downTime = 1;
}

@end
