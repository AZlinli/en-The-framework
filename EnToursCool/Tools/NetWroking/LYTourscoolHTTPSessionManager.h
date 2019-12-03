//
//  LYHTTPSessionManager.h
//  LCSTools
//
//  Created by luoyong on 2018/5/16.
//  Copyright © 2018年 luoyong. All rights reserved.
//
/**
 * 目前支持GET POST网络请求 文件下载(暂不支持断点下载) 图片单张上传
 * veriosn 1.0.0
 * xcode   9.2
 */
#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
/**
 网络请求方式
 
 - LYHTTPRequestMethodGET: get 请求
 - LYHTTPRequestMethodPOST: post 请求
 */
typedef NS_ENUM (NSInteger, LCYHttpRequestMethod){
    LCYHTTPRequestMethodGET = 1,
    LCYHTTPRequestMethodPOST,
    LCYHTTPRequestMethodPUT,
    LCYHTTPRequestMethodDELETE
};

/**
 成功block
 
 @param success success
 */
typedef void(^CustomHttpRequestSuccessBlock)(NSURLSessionDataTask * sessionDataTask, id success);
/**
 失败block
 
 @param failure failure
 */
typedef void(^CustomHttpRequestFailureBlock)(NSURLSessionDataTask * task, NSError * failure);
/**
 上传进度
 
 @param uploadProgress uploadProgress
 */
typedef void(^HttpUploadProgress)(NSProgress * uploadProgress);
/**
 下载进度
 
 @param downProgress downProgress
 */
typedef void(^HttpDownProgress)(NSProgress * downProgress);
/**
 完成
 
 @param response response
 @param responseObject responseObject
 @param error error
 */
typedef void(^HttpCompletionHandler)(NSURLResponse * response, id responseObject, NSError * error);

@interface LYTourscoolHTTPSessionManager : AFHTTPSessionManager
/**
 单例

 @return LCYHTTPSessionManager
 */
+ (LYTourscoolHTTPSessionManager *)sharedLCYHTTPSessionManager;
/**
 网络请求

 @param path 请求地址
 @param parameter 参数
 @param httpRequestType 请求方法 get post
 @param successBlock 成功block
 @param failureBlock 失败block
 @param progress 进度
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)httpWithPath:(NSString *)path
                             parameter:(NSDictionary *)parameter
                       httpRequestType:(LCYHttpRequestMethod)httpRequestType
                          successBlock:(CustomHttpRequestSuccessBlock)successBlock
                          failureBlock:(CustomHttpRequestFailureBlock)failureBlock
                              progress:(HttpDownProgress)progress;

/**
 下载

 @param path 下载地址
 @param downProgress 进度
 @param successBlock 成功block
 @param failureBlock 失败block
 @param downPath 下载路径
 @return NSURLSessionDownloadTask
 */
+ (NSURLSessionDownloadTask *)downFileWithPath:(NSString *)path
                                  downProgress:(HttpDownProgress)downProgress
                                       success:(CustomHttpRequestSuccessBlock)successBlock
                                       failure:(CustomHttpRequestFailureBlock)failureBlock
                                      downPath:(NSString *)downPath;

/**
 上传图片
 @{@"path":@"travelGuides"}
name:@"Filedata" fileName:@"imageFileName.png" mimeType:@"image/jpeg"
 @param imageData image二进制
 @param urlStr 上传地址
 @param parameters 参数
 @param progress 进度
 @param successBlock 成功block
 @param failureBlock 失败block
 @param name 与指定数据关联的名称
 @param fileName 文件名字
 @param mimeType 文件类型
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)updateImagesData:(NSData *)imageData
                                    urlStr:(NSString *)urlStr
                                parameters:(NSDictionary *)parameters
                                  progress:(HttpDownProgress)progress
                                   success:(CustomHttpRequestSuccessBlock)successBlock
                                   failure:(CustomHttpRequestFailureBlock)failureBlock
                                      name:(NSString *)name
                                  fileName:(NSString *)fileName
                                  mimeType:(NSString *)mimeType;

/**
 取消单个网络请求
 
 @param sessionDataTask NSURLSessionDataTask
 */
+ (void)cancelSingleRequestWithSessionDataTask:(NSURLSessionDataTask *)sessionDataTask;
+ (void)setSessionManagerValue:(NSString *)value forHTTPHeaderField:(NSString *)header;
@end
