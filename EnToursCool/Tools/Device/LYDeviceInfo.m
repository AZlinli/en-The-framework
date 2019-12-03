//
//  LYDeviceInfo.m
//  ToursCool
//
//  Created by 稀饭旅行 on 2019/9/27.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYDeviceInfo.h"

@implementation LYDeviceInfo


+ (CGFloat)getFreeDiskSizeWithUnitM{
    float freeSize;
    NSError * error;
    NSDictionary * infoDic = [[NSFileManager defaultManager] attributesOfFileSystemForPath: NSHomeDirectory() error: &error];
    if (infoDic) {
        NSNumber * fileSystemFreeSize = [infoDic objectForKey: NSFileSystemFreeSize];
        freeSize = [fileSystemFreeSize floatValue]/1024.0f/1024.0f;
        return freeSize;
    } else {
        return 0.f;
    }
}

+ (CGFloat)getFreeDiskSize{
    float freeSize;
    NSError * error;
    NSDictionary * infoDic = [[NSFileManager defaultManager] attributesOfFileSystemForPath: NSHomeDirectory() error: &error];
    if (infoDic) {
        NSNumber * fileSystemFreeSize = [infoDic objectForKey: NSFileSystemFreeSize];
        freeSize = [fileSystemFreeSize floatValue]/1024.0f/1024.0f/1024.0f;
        return freeSize;
    } else {
        return 0.f;
    }
}

+ (CGFloat)getTotalDiskSize{
    CGFloat totalSize;
    NSError * error;
    NSDictionary * infoDic = [[NSFileManager defaultManager] attributesOfFileSystemForPath: NSHomeDirectory() error: &error];
    if (infoDic) {
        NSNumber * fileSystemSizeInBytes = [infoDic objectForKey: NSFileSystemSize];
        totalSize = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        return totalSize;

    } else {
        return 0.f;
    }
}

@end
