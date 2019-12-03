//
//  LYUserCommentAPPTime.h
//  ToursCool
//
//  Created by tourscool on 2/11/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUserCommentAPPTime : NSObject
+ (void)createUserCommentAPPTimeWithUpdate:(BOOL)update;
+ (BOOL)compareUserCommentTime;
+ (BOOL)userCommentThisAPP;
@end

NS_ASSUME_NONNULL_END
