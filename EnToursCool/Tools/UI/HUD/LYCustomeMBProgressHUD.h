//
//  LYCustomeMBProgressHUD.h
//  ToursCool
//
//  Created by tourscool on 6/17/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

/**
 解决 updateBezelMotionEffects 不在主线程调用 areDefaultMotionEffectsEnabled NO
 */
@interface LYCustomeMBProgressHUD : MBProgressHUD

@end

NS_ASSUME_NONNULL_END
