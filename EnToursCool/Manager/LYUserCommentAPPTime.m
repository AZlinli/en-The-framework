//
//  LYUserCommentAPPTime.m
//  ToursCool
//
//  Created by tourscool on 2/11/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYUserCommentAPPTime.h"
#import "LYDateTools.h"

@implementation LYUserCommentAPPTime

+ (void)createUserCommentAPPTimeWithUpdate:(BOOL)update
{
    if (update) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate new] forKey:kUserUseAPPTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        NSDate * creatTiem = [[NSUserDefaults standardUserDefaults] objectForKey:kUserUseAPPTimeKey];
        if (!creatTiem) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate new] forKey:kUserUseAPPTimeKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

+ (BOOL)compareUserCommentTime
{
    NSDate * creatTiem = [[NSUserDefaults standardUserDefaults] objectForKey:kUserUseAPPTimeKey];
    if (!creatTiem) {
        return NO;
    }
//    if ([[LYDateTools beApartMinutedateOne:creatTiem dateTwo:[NSDate new]] integerValue] >= 2 && [[[NSUserDefaults standardUserDefaults] objectForKey:kUserCommentApp] integerValue] != 1) {
//        return YES;
//    }
    if ([[LYDateTools beApartDaydateOne:creatTiem dateTwo:[NSDate new]] integerValue] >= 7 && [[[NSUserDefaults standardUserDefaults] objectForKey:kUserCommentApp] integerValue] != 1) {
        return YES;
    }
    return NO;
}

+ (BOOL)userCommentThisAPP
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:kUserCommentApp];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

@end
