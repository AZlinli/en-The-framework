//
//  LYProductPopViewController.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTourscoolBasicsViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol LYProductPopViewControllerDelegate <NSObject>

@required
-(void)selectedItem:(id)model index:(NSInteger)index;

@end

@interface LYProductPopViewController : LYTourscoolBasicsViewController
@property (nonatomic, weak) id<LYProductPopViewControllerDelegate> delegate;
@property(nonatomic, assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
