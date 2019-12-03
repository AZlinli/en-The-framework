//
//  LYShareViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYShareViewModel : NSObject
@property (nonatomic, readonly, copy) NSArray * sharedTypeArray;

/**
 分享标题
 */
@property (nonatomic, readonly, copy) NSString * title;
/**
 分享内容
 */
@property (nonatomic, readonly, copy) NSString * content;
/**
 分享地址
 */
@property (nonatomic, readonly, copy) NSString * url;

/**
小程序原始ID
*/
@property (nonatomic, readonly, copy) NSString * userName;
/**
 分享图片或者图片地址
 */
@property (nonatomic, strong) id _Nullable image;

@property (nonatomic, strong) id _Nullable imageHD;


@property (nonatomic, readonly, copy) NSString * type;

- (instancetype)initWithParameter:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
