//
//  LYReviewDetailModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYReviewDetailModel : NSObject
/***/
@property(nonatomic, copy) NSString *text;

@property(nonatomic, copy) NSString *url;

/**<##>*/
@property(nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
