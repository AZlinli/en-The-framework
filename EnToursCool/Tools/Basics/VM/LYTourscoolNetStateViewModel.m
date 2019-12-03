//
//  LYTourscoolViewModel.m
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYTourscoolNetStateViewModel.h"
#import "LYNetWorkingService.h"
#import "LYComponentAppDelegate.h"

@interface LYTourscoolNetStateViewModel ()
@property (nonatomic, readwrite, assign) NSInteger netWorkingState;
@end

@implementation LYTourscoolNetStateViewModel

- (instancetype)init
{
    if (self = [super init]) {
        LYNetWorkingService * netWorkingService = [LYComponentAppDelegate findDelegateServiceWithServiceName:@"LYNetWorkingService"];
        RAC(self, netWorkingState) = RACObserve(netWorkingService, netWorkStatus);
    }
    return self;
}

- (void)dealloc
{
    LYNSLog(@"%@", NSStringFromClass([self class]));
}

@end
