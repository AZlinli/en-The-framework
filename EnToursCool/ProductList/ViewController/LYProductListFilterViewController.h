//
//  LYProductListFilterViewController.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTourscoolBasicsViewController.h"
#import "LYProductListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYProductListFilterViewController : LYTourscoolBasicsViewController
@property (nonatomic, weak) LYProductListViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
