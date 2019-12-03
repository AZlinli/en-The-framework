//
//  LYSmallPlayerView.h
//  ToursCool
//
//  Created by tourscool on 11/12/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LYCloseSmallPlayerViewBlock)(void);
typedef void (^LYSmallGoFullScrrenPlayerViewBlock)(void);
NS_ASSUME_NONNULL_BEGIN
@interface LYSmallPlayerView : UIView
@property (nonatomic, weak) UIView * canvas;
@property (nonatomic, copy) LYCloseSmallPlayerViewBlock closeSmallPlayerViewBlock;
@property (nonatomic, copy) LYCloseSmallPlayerViewBlock smallGoFullScrrenPlayerViewBlock;
+ (LYSmallPlayerView *)creatSmallPlayer;
- (void)setProgressBarProgressWithProgress:(CGFloat)progress;
@end

NS_ASSUME_NONNULL_END
