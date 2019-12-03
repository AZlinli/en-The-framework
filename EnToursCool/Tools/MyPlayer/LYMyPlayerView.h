//
//  LYMyPlayerView.h
//  ToursCool
//
//  Created by tourscool on 11/9/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYPlayerManager;
NS_ASSUME_NONNULL_BEGIN

@interface LYMyPlayerView : UIView
@property (nonatomic, weak) LYPlayerManager *playerManager;
/**
 YES 不可以 NO 可以
 */
@property (nonatomic, assign) BOOL canMove;
- (instancetype)initCanMove:(BOOL)canMove;
- (void)ly_viewTransformIdentity;
@end

NS_ASSUME_NONNULL_END
