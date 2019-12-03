//
//  LYDeviceInfo.h
//  ToursCool
//
//  Created by 稀饭旅行 on 2019/9/27.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDeviceInfo : NSObject


/**
*  获取设备可用容量
*
*  @return 可用容量(G)
*/

+(CGFloat)getFreeDiskSize;

/**
*  获取设备可用容量
*
*  @return 可用容量(M)
*/

+(CGFloat)getFreeDiskSizeWithUnitM;

/**
*  获取设备总容量
*
*  @return 总容量(G)
*/
+(CGFloat)getTotalDiskSize;
@end

NS_ASSUME_NONNULL_END
