//
//  LYHTTPRequestManager.m
//  ToursCool
//
//  Created by tourscool on 10/23/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHTTPRequestManager.h"
#import "LYTourscoolHTTPSessionManager.h"
#import "LYUserInfoManager.h"
#import "NSError+LYError.h"


static LYHTTPRequestManager * HTTPRequestManager = nil;

@implementation LYHTTPRequestManager

+ (LYHTTPRequestManager *)sharedLYHTTPRequestManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTTPRequestManager = [[LYHTTPRequestManager alloc] init];
    });
    return HTTPRequestManager;
}

+ (void)initialize
{
    [LYTourscoolHTTPSessionManager setSessionManagerValue:@"iOS" forHTTPHeaderField:@"Phone-Type"];
    [LYTourscoolHTTPSessionManager setSessionManagerValue:@"APP" forHTTPHeaderField:@"Platform"];
    [LYTourscoolHTTPSessionManager setSessionManagerValue:@"iOSApp" forHTTPHeaderField:@"Channel"];
    [LYTourscoolHTTPSessionManager setSessionManagerValue:kAppVersion forHTTPHeaderField:@"App-Version"];
    [LYTourscoolHTTPSessionManager setSessionManagerValue:LYUserInfoManager.sharedUserInfoManager.userCurrency forHTTPHeaderField:@"Currency"];
    [LYTourscoolHTTPSessionManager setSessionManagerValue:[LYLanguageManager currentServerLanguage] forHTTPHeaderField:@"Language"];
}

+ (void)setSessionManagerValue:(NSString *)value forHTTPHeaderField:(NSString *)header
{
    [LYTourscoolHTTPSessionManager setSessionManagerValue:value forHTTPHeaderField:header];
}

+ (RACSignal *)HTTPPostRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodPOST cacheType:cacheType];
}

+ (RACSignal *)HTTPGetRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodGET cacheType:cacheType];
}

+ (RACSignal *)HTTPPUTRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodPUT cacheType:NO];
}

+ (RACSignal *)HTTPDeleteRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodDELETE cacheType:NO];
}


+ (RACSignal *)HTTPMinshukuPostRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainMinshukuUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodPOST cacheType:cacheType];
}

+ (RACSignal *)HTTPMinshukuGetRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainMinshukuUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodGET cacheType:cacheType];
}

+ (RACSignal *)HTTPMinshukuPUTRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainMinshukuUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodPUT cacheType:NO];
}

+ (RACSignal *)HTTPMinshukuDeleteRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainMinshukuUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodDELETE cacheType:NO];
}

+ (NSString *)obtainMinshukuUrlPathWithAction:(NSString *)action
{
    return [NSString stringWithFormat:@"%@%@", MinshukuBaseUrl, action];
}

+ (NSString *)obtainUrlPathWithAction:(NSString *)action
{
    return [NSString stringWithFormat:@"%@%@", BaseUrl, action];
}

+ (NSString *)obtainPayUrlPathWithAction:(NSString *)action
{
    return [NSString stringWithFormat:@"%@%@", PayBaseUrl, action];
}

+ (RACSignal *)updateImage:(UIImage *)image
{
//    UIImage * imageSmall = [UIImage image:image fillSize:CGSizeMake(210, 210)];
//    NSData * imageData = UIImagePNGRepresentation(imageSmall);
    LYNSLog(@"updateImage - %@", image);
    NSData * imageData = UIImageJPEGRepresentation(image, 0.75);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURLSessionDataTask * task = [LYTourscoolHTTPSessionManager updateImagesData:imageData urlStr:UpdateImagePath parameters:@{@"catalog":@"toursCoolsUserAvatar"}progress:^(NSProgress *downProgress) {
            
        } success:^(NSURLSessionDataTask * sessionDataTask,  id success) {
            LYNSLog(@"%@", success);
            [subscriber sendNext:success];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *failure) {
            LYNSLog(@"%@", failure);
            [subscriber sendError:failure];
        } name:@"uploadFile" fileName:@"imageFileName.png" mimeType:@"image/jpeg"];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

+ (RACSignal *)updateImages:(NSArray *)images
{
    RACSignal * updateImage = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSMutableArray * reuslt = [NSMutableArray array];
        dispatch_group_t group_t = dispatch_group_create();
        for (int i = 0; i < images.count; i++) {
            dispatch_group_enter(group_t);
            NSData * imageData = UIImageJPEGRepresentation(images[i], 0.75);
            [LYTourscoolHTTPSessionManager updateImagesData:imageData urlStr:UpdateImagePath parameters:@{@"catalog":@"toursCoolsComment"}progress:^(NSProgress *downProgress) {
                
            } success:^(NSURLSessionDataTask * sessionDataTask,  id success) {
                LYNSLog(@"%@", success);
                if ([success[@"code"] integerValue] == 0) {
                    // 加锁保障安全
                    @synchronized (reuslt) {
                        NSString * url = success[@"data"][@"url"];
                        NSString * idx = [NSString stringWithFormat:@"%d", i];
                        if (url.length) {
                            [reuslt addObject:@{@"idx":idx,@"url":url}];
                        }
                    }
                }
                dispatch_group_leave(group_t);
            } failure:^(NSURLSessionDataTask *task, NSError *failure) {
                dispatch_group_leave(group_t);
            } name:@"uploadFile" fileName:@"imageFileName.png" mimeType:@"image/jpeg"];
        }
        dispatch_group_notify(group_t, dispatch_get_main_queue(), ^{
            [subscriber sendNext:reuslt];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    return updateImage;
}

+ (RACSignal *)HTTPPayPostRequestWithAction:(NSString *)action parameter:(NSDictionary *)parameter cacheType:(BOOL)cacheType
{
    return [LYHTTPRequestManager httpWithPath:[LYHTTPRequestManager obtainPayUrlPathWithAction:action] parameter:parameter type:LCYHTTPRequestMethodPOST cacheType:NO];
}

+ (RACSignal *)httpWithPath:(NSString *)path parameter:(NSDictionary *)parameter type:(LCYHttpRequestMethod)type cacheType:(BOOL)cacheType
{
    RACSignal * httpRACSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURLSessionDataTask * task = [LYTourscoolHTTPSessionManager httpWithPath:path parameter:parameter httpRequestType:type successBlock:^(NSURLSessionDataTask * sessionDataTask, id success) {
            if ([success[@"code"] integerValue] == 401) {
                LYNSLog(@"token过期 = %@", success);
                NSString * token = success[@"data"][@"token"];
                if (token.length) {
                    [[NSUserDefaults standardUserDefaults] setObject:token forKey:LYUserToken];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    LYUserInfoManager.sharedUserInfoManager.userToken = token;
                    [LYHTTPRequestManager setSessionManagerValue:token forHTTPHeaderField:@"Authorization"];
                }
                NSError * error = [NSError errorWithTitle:@"token过期" reason:@"token过期" code:401];
                [subscriber sendError:error];
            }else if ([success[@"code"] integerValue] == 601 || [success[@"code"] integerValue] == 604 || [success[@"code"] integerValue] == 700) {
                LYNSLog(@"token or无效 = %@", success);
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LYUserToken];
                [LYTourscoolHTTPSessionManager setSessionManagerValue:@"" forHTTPHeaderField:@"Authorization"];
                [LYUserInfoManager sharedUserInfoManager].userToken = nil;
                [LYUserInfoManager deteleUserInfoModel];
                if (![path containsString:@"profile"] && ![path containsString:@"user/status"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginLoseEfficacydentifier object:nil];
                }
                
                [subscriber sendNext:success];
                [subscriber sendCompleted];
            }else{
                [subscriber sendNext:success];
                [subscriber sendCompleted];
            }
        } failureBlock:^(NSURLSessionDataTask *task, NSError *failure) {
            if (cacheType && [task.currentRequest.HTTPMethod isEqualToString:@"GET"]) {
                NSCachedURLResponse *responseObject = [[NSURLCache sharedURLCache] cachedResponseForRequest:task.currentRequest];
                if (responseObject.data) {
                    [subscriber sendNext:[NSJSONSerialization JSONObjectWithData:responseObject.data options:NSJSONReadingMutableLeaves error:nil]];
                    [subscriber sendCompleted];
                    return ;
                }
            }
            [subscriber sendError:failure];
        } progress:^(NSProgress *downProgress) {
            
        }];
        return [RACDisposable disposableWithBlock:^{
            LYNSLog(@"RACDisposable disposableWithBlock 网络请求取消");
            [task cancel];
        }];
    }];
    return [LYHTTPRequestManager doRequestAndRefreshTokenIfNecessary:httpRACSignal];
}

+ (RACSignal *)doRequestAndRefreshTokenIfNecessary:(RACSignal *)requestSignal
{
    return [requestSignal catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
        if (error.code == 401) {
            return requestSignal;
        }
        return [RACSignal error:error];
    }];
}

@end
