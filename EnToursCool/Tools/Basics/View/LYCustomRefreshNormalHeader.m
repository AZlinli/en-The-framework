//
//  LYCustomRefreshNormalHeader.m
//  ToursCool
//
//  Created by tourscool on 4/26/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYCustomRefreshNormalHeader.h"

@implementation LYCustomRefreshNormalHeader

- (void)prepare
{
    [super prepare];
    [self updateRefreshTitleState];
}

- (void)updateRefreshTitleState
{
    self.lastUpdatedTimeLabel.hidden = YES;
    [self setTitle:[LYLanguageManager ly_localizedStringForKey:@"LYRefreshHeaderIdleText"] forState:MJRefreshStateIdle];
    [self setTitle:[LYLanguageManager ly_localizedStringForKey:@"LYRefreshHeaderPullingText"] forState:MJRefreshStatePulling];
    [self setTitle:[LYLanguageManager ly_localizedStringForKey:@"LYRefreshHeaderRefreshingText"] forState:MJRefreshStateRefreshing];
}

- (void)updateRefreshTitleStateTextColor
{
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.stateLabel.textColor = [UIColor whiteColor];
}

@end
