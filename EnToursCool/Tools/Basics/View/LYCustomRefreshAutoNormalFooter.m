//
//  LYCustomRefreshAutoFooter.m
//  ToursCool
//
//  Created by tourscool on 4/26/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYCustomRefreshAutoNormalFooter.h"

@implementation LYCustomRefreshAutoNormalFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updateFooterRefreshTitleState
{
    [self setTitle:[LYLanguageManager ly_localizedStringForKey:@"LYRefreshAutoFooterIdleText"] forState:MJRefreshStateIdle];
    [self setTitle:[LYLanguageManager ly_localizedStringForKey:@"LYRefreshAutoFooterRefreshingText"] forState:MJRefreshStateRefreshing];
    [self setTitle:[LYLanguageManager ly_localizedStringForKey:@"LYRefreshAutoFooterNoMoreDataText"] forState:MJRefreshStateNoMoreData];
}

@end
