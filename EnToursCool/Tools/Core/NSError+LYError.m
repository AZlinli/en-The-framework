//
//  NSError+LYError.m
//  ToursCool
//
//  Created by tourscool on 12/4/18.
//  Copyright © 2018 tourscool. All rights reserved.
//
static NSString * CustomErrorDomain = @"com.zmcs.toursCool.ToursCool";
#import "NSError+LYError.h"

@implementation NSError (LYError)

+ (NSError *)errorWithTitle:(NSString *)title reason:(NSString *)reason {
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : title ?: @"",
                                NSLocalizedFailureReasonErrorKey : reason ?: @"" };
    return [NSError errorWithDomain:CustomErrorDomain code:100000 userInfo:userInfo];
}

+ (NSError *)errorWithTitle:(NSString *)title reason:(NSString *)reason code:(NSInteger)code
{
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : title ?: @"",
                                NSLocalizedFailureReasonErrorKey : reason ?: @"" };
    return [NSError errorWithDomain:CustomErrorDomain code:code userInfo:userInfo];
}

@end
