//
//  LYFullPageAdvertisementManager.h
//  LYIGListKitTest
//
//  Created by tourscool on 2/18/19.
//  Copyright © 2019 Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
FOUNDATION_EXPORT NSString * _Nullable const CachePathName;
NS_ASSUME_NONNULL_BEGIN

@interface LYFullPageAdvertisementManager : NSObject
+ (LYFullPageAdvertisementManager *)sharedFullPageAdvertisementManager;
+ (void)removeFullPageAdvertisementModel;
+ (void)showFullPageAdvertisementView:(UITabBarController *)navigationController;
- (void)downAdvertisement;
@end

NS_ASSUME_NONNULL_END
