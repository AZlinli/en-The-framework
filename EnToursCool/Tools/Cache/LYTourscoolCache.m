//
//  LCYCache.m
//  lcyTools
//
//  Created by luoyong on 2018/5/16.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import "LYTourscoolCache.h"
#import <CommonCrypto/CommonDigest.h>
#import <YYCache/YYCache.h>
static YYCache * lcyCache;
NSString * const LYNetworkingResponseCache = @"LYNetworkingResponseCache";
@implementation LYTourscoolCache
+ (void)setUpCacheWithName:(NSString *)name
{
    lcyCache = [YYCache cacheWithName:name];
}

+ (void)setUpCacheWithPath:(NSString *)path
{
    lcyCache = [YYCache cacheWithPath:path];
}

+ (void)lcyCacheWithObejct:(id)object cacheKey:(NSString *)cacheKey
{
    if (object && cacheKey) {
        [lcyCache setObject:object forKey:cacheKey withBlock:nil];
    }
}

+ (id)lcyGetCacheWithCacheKey:(NSString *)cacheKey
{
    if (cacheKey) {
        return [lcyCache objectForKey:cacheKey];
    }
    return nil;
}

+ (void)lcyRemAllObjectsWithProgressBlock:(void(^)(int removedCount, int totalCount))progress
                                 endBlock:(void(^)(BOOL error))end
{
    [lcyCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        progress(removedCount,totalCount);
    } endBlock:^(BOOL error) {
        end(error);
    }];
}

+ (void)lcyremoveObjectsWithPath:(NSString *)path parameter:(NSDictionary *)parameter
{
    NSString * saveMD5Key = [LYTourscoolCache setupSaveKeyWithPath:path parameter:parameter];
    [lcyCache removeObjectForKey:saveMD5Key];
}

+ (void)saveRequestWithPath:(NSString *)path parameter:(NSDictionary *)parameter obejct:(id)object
{
    NSString * saveMD5Key = [LYTourscoolCache setupSaveKeyWithPath:path parameter:parameter];
    [LYTourscoolCache lcyCacheWithObejct:object cacheKey:saveMD5Key];
}

+ (id)lcyGetCacheWithPath:(NSString *)path parameter:(NSDictionary *)parameter
{
    NSString * saveMD5Key = [LYTourscoolCache setupSaveKeyWithPath:path parameter:parameter];
    return [LYTourscoolCache lcyGetCacheWithCacheKey:saveMD5Key];
}

+ (NSInteger)obtainYYDiskCache
{
    return [lcyCache.diskCache totalCost];
}

/**
 获取存储的key

 @param path 路径
 @param parameter 参数
 @return 存储的key
 */
+ (NSString *)setupSaveKeyWithPath:(NSString *)path parameter:(NSDictionary *)parameter
{
    NSString * saveKey = [NSString stringWithFormat:@"%@%@", path,[LYTourscoolCache dictionaryToSting:parameter]];
    NSString * saveMD5Key = [LYTourscoolCache md5StrWithPath:saveKey];
    return saveMD5Key;
}

/**
 字典转换字符串

 @param dic 字典
 @return 字符串
 */
+ (NSString *)dictionaryToSting:(NSDictionary *)dic
{
    if (dic.count == 0) {
        return @"";
    }
    NSError * error = nil;
    NSData * strData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return @"";
    }
    NSString * str = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    if (str.length > 0) {
        return str;
    }
    return @"";
}

/**
 md5加密

 @param path 请求参数和路径
 @return 加密后字符串
 */
+ (NSString *)md5StrWithPath:(NSString *)path
{
    const char *cStr = [path UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
