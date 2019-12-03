//
//  LYReviewDetailViewModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYReviewDetailViewModel : NSObject
/**数据源*/
@property(nonatomic, strong,readonly) NSArray *dataArray;
/**请求*/
@property(nonatomic, strong) RACCommand *detailCommand;
@end

NS_ASSUME_NONNULL_END