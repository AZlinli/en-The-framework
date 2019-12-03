//
//  LYHTTPSessionManager.m
//  LCSTools
//
//  Created by luoyong on 2018/5/16.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import "LYTourscoolHTTPSessionManager.h"

#import "LYUserInfoManager.h"

static LYTourscoolHTTPSessionManager * sessionManager = nil;
@implementation LYTourscoolHTTPSessionManager

+ (LYTourscoolHTTPSessionManager *)sharedLCYHTTPSessionManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [LYTourscoolHTTPSessionManager manager];
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        sessionManager.requestSerializer.timeoutInterval = 30.f;
        sessionManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",@"multipart/form-data", nil];
    });
    return sessionManager;
}

+ (void)setSessionManagerValue:(NSString *)value forHTTPHeaderField:(NSString *)header
{
    [[LYTourscoolHTTPSessionManager sharedLCYHTTPSessionManager].requestSerializer setValue:value forHTTPHeaderField:header];
}

+ (NSURLSessionDataTask *)httpWithPath:(NSString *)path
                             parameter:(NSDictionary *)parameter
                       httpRequestType:(LCYHttpRequestMethod)httpRequestType
                          successBlock:(CustomHttpRequestSuccessBlock)successBlock
                          failureBlock:(CustomHttpRequestFailureBlock)failureBlock
                              progress:(HttpDownProgress)progress
{
    switch (httpRequestType) {
            case LCYHTTPRequestMethodGET:
        {
            return [[LYTourscoolHTTPSessionManager sharedLCYHTTPSessionManager] GET:path parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) {
                    progress(downloadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(task, responseObject);
                }
                LYNSLog(@"GET%@", task.currentRequest);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(task, error);
                }
                LYNSLog(@"GET%@ %@", task.currentRequest, error);
            }];
        }
            break;
            case LCYHTTPRequestMethodPOST:
        {
            return [[LYTourscoolHTTPSessionManager sharedLCYHTTPSessionManager] POST:path parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) {
                    progress(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(task, responseObject);
                }
                LYNSLog(@"POST %@", task.currentRequest);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(task, error);
                }
                LYNSLog(@"POST %@ %@", task.currentRequest, error);
            }];
        }
            break;
            case LCYHTTPRequestMethodPUT:
        {
            return [[LYTourscoolHTTPSessionManager sharedLCYHTTPSessionManager] PUT:path parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(task, responseObject);
                }
                LYNSLog(@"PUT %@", task.currentRequest);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(task, error);
                }
                LYNSLog(@"PUT %@ %@", task.currentRequest, error);
            }];
        }
            break;
            case LCYHTTPRequestMethodDELETE:
        {
            return [[LYTourscoolHTTPSessionManager sharedLCYHTTPSessionManager] DELETE:path parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(task, responseObject);
                }
                LYNSLog(@"DELETE %@", task.currentRequest);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(task, error);
                }
                LYNSLog(@"DELETE %@ %@", task.currentRequest, error);
            }];
        }
            break;
    }
}

+ (NSURLSessionDownloadTask *)downFileWithPath:(NSString *)path
                                  downProgress:(HttpDownProgress)downProgress
                                       success:(CustomHttpRequestSuccessBlock)successBlock
                                       failure:(CustomHttpRequestFailureBlock)failureBlock
                                      downPath:(NSString *)downPath
{
    AFHTTPSessionManager * manager = [LYTourscoolHTTPSessionManager sharedLCYHTTPSessionManager];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    NSURLSessionDownloadTask * downloadTask = nil;
    downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        downProgress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:[downPath stringByAppendingPathComponent:response.suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failureBlock(nil, error);
        }else{
            successBlock(nil, [filePath path]);
        }
    }];
    [downloadTask resume];
    return downloadTask;
}

+ (NSURLSessionDataTask *)updateImagesData:(NSData *)imageData
                  urlStr:(NSString *)urlStr
              parameters:(NSDictionary *)parameters
                progress:(HttpDownProgress)progress
                 success:(CustomHttpRequestSuccessBlock)successBlock
                 failure:(CustomHttpRequestFailureBlock)failureBlock
                                      name:(NSString *)name
                                  fileName:(NSString *)fileName
                                  mimeType:(NSString *)mimeType
{
    AFHTTPSessionManager * manager = [LYTourscoolHTTPSessionManager sharedLCYHTTPSessionManager];
    return [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // [formData appendPartWithFileData:imageData name:@"Filedata" fileName:@"imageFileName.png" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progress){
            progress(uploadProgress);
        }
        LYNSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(successBlock){
            successBlock(task, responseObject);
        }
        LYNSLog(@"%@ %@", task.currentRequest, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failureBlock){
            failureBlock(task, error);
        }
        LYNSLog(@"%@ %@", task.currentRequest, error);
    }];
}

+ (void)cancelSingleRequestWithSessionDataTask:(NSURLSessionDataTask *)sessionDataTask
{
    if (sessionDataTask) {
        [sessionDataTask cancel];
    }
}

@end
