//
//  LCYCache.h
//  lcyTools
//
//  Created by luoyong on 2018/5/16.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import <Foundation/Foundation.h>
FOUNDATION_EXPORT NSString * const LYNetworkingResponseCache;

/**
 缓存类
 */
@interface LYTourscoolCache : NSObject
/**
 初始化cache
 
 @param name cacheName
 */
+ (void)setUpCacheWithName:(NSString *)name;
/**
 初始化cache
 
 @param path cachePath
 */
+ (void)setUpCacheWithPath:(NSString *)path;
/**
 存储
 
 @param object 存储内容
 @param cacheKey 存储key
 */
+ (void)lcyCacheWithObejct:(id)object cacheKey:(NSString *)cacheKey;
/**
 获取存储内容
 
 @param cacheKey 存储key
 @return 存储内容
 */
+ (id)lcyGetCacheWithCacheKey:(NSString *)cacheKey;
/**
 清除存储
 
 @param progress 进度
 @param end 是否成功
 */
+ (void)lcyRemAllObjectsWithProgressBlock:(void(^)(int removedCount, int totalCount))progress
                                 endBlock:(void(^)(BOOL error))end;
/**
 根据网络请求保存数据

 @param path 请求路径
 @param parameter 参数
 @param object 保存对象
 */
+ (void)saveRequestWithPath:(NSString *)path parameter:(NSDictionary *)parameter obejct:(id)object;
/**
 获取网络请求存储对象

 @param path 请求路径
 @param parameter 参数
 @return 被保存对象
 */
+ (id)lcyGetCacheWithPath:(NSString *)path parameter:(NSDictionary *)parameter;
/**
 获取缓存大小

 @return 缓存 K
 */
+ (NSInteger)obtainYYDiskCache;
+ (void)lcyremoveObjectsWithPath:(NSString *)path parameter:(NSDictionary *)parameter;
@end
