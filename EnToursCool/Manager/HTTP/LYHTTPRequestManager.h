//
//  LYHTTPRequestManager.h
//  ToursCool
//
//  Created by tourscool on 10/23/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYHTTPAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYHTTPRequestManager : NSObject
+ (LYHTTPRequestManager *)sharedLYHTTPRequestManager;
/**
 get网络请求

 @param action 链接
 @param parameter 参数
 @param cacheType 是否缓存 YES缓存
 @return RACSignal
 */
+ (RACSignal *)HTTPGetRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType;

/**
 post网络请求

 @param action 链接
 @param parameter 参数
 @param cacheType 是否缓存 YES缓存
 @return RACSignal
 */
+ (RACSignal *)HTTPPostRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType;

/**
 delete网络请求

 @param action 链接
 @param parameter 参数
 @return RACSignal
 */
+ (RACSignal *)HTTPDeleteRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter;

/**
 put网络请求

 @param action 链接
 @param parameter 参数
 @return RACSignal
 */
+ (RACSignal *)HTTPPUTRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter;

+ (RACSignal *)HTTPMinshukuGetRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType;
+ (RACSignal *)HTTPMinshukuPostRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType;
+ (RACSignal *)HTTPMinshukuDeleteRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter;
+ (RACSignal *)HTTPMinshukuPUTRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter;

/**
 头像上传

 @param image 图片
 @return RACSignal
 */
+ (RACSignal *)updateImage:(UIImage *)image;

/**
 评论图片上传

 @param images 图片数组
 @return RACSignal
 */
+ (RACSignal *)updateImages:(NSArray *)images;

+ (RACSignal *)HTTPPayPostRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType;
+ (void)setSessionManagerValue:(NSString *)value forHTTPHeaderField:(NSString *)header;

@end

NS_ASSUME_NONNULL_END
