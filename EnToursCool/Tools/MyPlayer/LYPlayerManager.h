//
//  LYPlayerManager.h
//  ToursCool
//
//  Created by tourscool on 11/12/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LYMyPlayer,LYSmallPlayerView, LYMyPlayerView;

NS_ASSUME_NONNULL_BEGIN

@interface LYPlayerManager : NSObject
@property (nonatomic, readonly, strong) LYMyPlayer * myPlayer;
@property (nonatomic, readonly, strong) LYSmallPlayerView * smallPlayerView;
@property (nonatomic, readonly, strong) LYMyPlayerView * myPlayerView;
/**
 YES 暂停 NO 播放
 */
@property (nonatomic, readonly, assign) BOOL playerState;
/**
 yes 全屏
 */
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) CGFloat panTx;
/**
 音频

 @param mediaURLs 地址
 @return LYPlayerManager
 */
- (instancetype)initMediaURLs:(NSArray *)mediaURLs;
/**
 视频

 @param canvas 画板
 @param mediaURLs 地址
 @return LYPlayerManager
 */
- (instancetype)initWithCanvas:(UIView *)canvas mediaURLs:(NSArray *)mediaURLs;
/**
 改变播放的View
 
 @param view 展示的View
 */
- (void)changePlayCanvasWithView:(UIView *)view;
/**
 迷你播放器 恢复播放
 */
- (void)recoverCanvas;
/**
 添加迷你播放器
 */
- (void)addMiniPlayer;
/**
 播放
 */
- (void)playVideo;
/**
 暂停
 */
- (void)pauseVideo;
/**
 停止播放
 */
- (void)playerManagerStopPlay;

/**
 展示small
 */
- (void)recoverCanvasToSmallPlayerView;
/**
 展示PlayerView
 */
- (void)recoverCanvasToMyPlayerView;
/**
 全屏
 */
- (void)dismissFullPlayVideoViewController;
/**
 关闭全屏
 */
- (void)goFullPlayVideoViewController;
- (void)playOrPauseVideo;
/**
 播放第几个

 @param index 序号
 */
- (void)playerManagerPlayMediaWithIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
