//
//  LYShareModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYShareModel : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * imageName;
/**
 1 facebook 2 twitter 3 what's app 4 copy link
 */
@property (nonatomic, assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
