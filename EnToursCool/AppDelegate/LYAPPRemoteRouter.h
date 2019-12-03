//
//  LYAPPRemoteRouter.h
//  ToursCool
//
//  Created by tourscool on 5/31/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 APP 远程通知 | URLScheme 跳转
 */
@interface LYAPPRemoteRouter : NSObject
+ (void)openVCWithURL:(NSURL *)url windowRootVC:(UIViewController *)windowRootVC;
+ (void)openVCWithRemoteUserInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
