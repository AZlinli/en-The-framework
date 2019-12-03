//
//  LYCustomRefreshNormalHeader.h
//  ToursCool
//
//  Created by tourscool on 4/26/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCustomRefreshNormalHeader : MJRefreshNormalHeader
- (void)updateRefreshTitleState;
- (void)updateRefreshTitleStateTextColor;


@end

NS_ASSUME_NONNULL_END
