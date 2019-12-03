//
//  LYPlayerControllerView.h
//  ToursCool
//
//  Created by tourscool on 6/14/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 播放
 */
typedef void(^LYUserTapPlayerControllerPlayButton)(void);
/**
 静音
 */
typedef void(^LYUserTapPlayerControllerMuteButton)(void);
/**
 改变
 */
typedef void(^LYUserTapPlayerControlSliderValueChanged)(CGFloat value);
typedef void(^LYUserTapPlayerControlFullScreenButton)(void);

typedef void(^LYUserTapPlayerControlSliderValueEndChanged)(CGFloat value);


NS_ASSUME_NONNULL_BEGIN

@interface LYPlayerControllerView : UIView

@property (nonatomic, copy) LYUserTapPlayerControllerPlayButton userTapPlayerControllerPlayButton;
@property (nonatomic, copy) LYUserTapPlayerControllerMuteButton userTapPlayerControllerMuteButton;
@property (nonatomic, copy) LYUserTapPlayerControlSliderValueChanged userTapPlayerControlSliderValueChanged;
@property (nonatomic, copy) LYUserTapPlayerControlSliderValueEndChanged userTapPlayerControlSliderValueEndChanged;
@property (nonatomic, copy) LYUserTapPlayerControlFullScreenButton userTapPlayerControlFullScreenButton;

- (void)setPlayerControllerPlayButtonSelected:(BOOL)selected;
- (void)setPlayerControllerMuteButtonSelected:(BOOL)selected;
- (void)setPlayerControllerFullScrenButtonSelected:(BOOL)selected;
- (void)setAllTime:(CGFloat)allTime;
- (void)setPlayTime:(CGFloat)currentTime;
- (void)setVoicePlanSliderValue:(CGFloat)value;
@end

NS_ASSUME_NONNULL_END
