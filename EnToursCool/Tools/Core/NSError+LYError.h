//
//  NSError+LYError.h
//  ToursCool
//
//  Created by tourscool on 12/4/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (LYError)

+ (NSError *)errorWithTitle:(NSString *)title reason:(NSString *)reason;
+ (NSError *)errorWithTitle:(NSString *)title reason:(NSString *)reason code:(NSInteger)code;

@end

NS_ASSUME_NONNULL_END
