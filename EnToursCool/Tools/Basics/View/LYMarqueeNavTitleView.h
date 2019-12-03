//
//  LYMarqueeNavTitleView.h
//  ToursCool
//
//  Created by tourscool on 9/25/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMarqueeNavTitleView : UIView

- (void)setupMarqueeWithTitle:(NSString *)title;
- (void)stopAnimation;
- (void)startAnimation;


@end

NS_ASSUME_NONNULL_END
