//
//  LYshareViewController.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTourscoolBasicsViewController.h"

typedef void(^LYUserSharedSuccessBlock)(NSDictionary * _Nullable otherValue);

NS_ASSUME_NONNULL_BEGIN

@interface LYShareViewController : LYTourscoolBasicsViewController
@property (nonatomic, copy) LYUserSharedSuccessBlock userSharedSuccessBlock;
+ (void)showSharedViewControllerWithParameter:(NSDictionary *)parameter showVC:(UIViewController *)showVC;
@end

NS_ASSUME_NONNULL_END
