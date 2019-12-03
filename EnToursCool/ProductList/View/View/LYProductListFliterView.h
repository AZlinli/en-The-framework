//
//  LYProductListFliterView.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYProductListViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYProductListFliterView : UIView
- (void)filtrateViewAnimateWithType:(BOOL)type;
@property (nonatomic, weak) LYProductListViewModel *viewModel;

- (void)addFiltrateView;
@end

NS_ASSUME_NONNULL_END
