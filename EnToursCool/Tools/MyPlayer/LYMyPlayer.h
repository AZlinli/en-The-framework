//
//  LYMyPlayer.h
//  ToursCool
//
//  Created by tourscool on 11/9/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/**
 登录成功通知 限获取token
 */
#define kAVPlayerItemStatusPlayerItemStatusFailed @"LYAVPlayerItemStatusPlayerItemStatusFailed"

NS_ASSUME_NONNULL_BEGIN

@interface LYMyPlayer : NSObject
@property (nonatomic, readonly, strong) AVPlayer * myPlayer;
@property (nonatomic, readonly, strong) AVAsset * asset;
@property (nonatomic, readonly, strong) AVPlayerItem * playerItem;
@property (nonatomic, readonly, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, copy) NSArray * allMediaURLs;
@property (nonatomic, assign) BOOL continuousPlaybackState;

/**
 是否在缓冲 YES 缓冲
 */
@property (nonatomic, readonly, assign) BOOL buffering;
/**
 播放进度
 */
@property (nonatomic, readonly, assign) CGFloat currentProgress;
/**
 当前播放时间
 */
@property (nonatomic, readonly, assign) CGFloat currentTime;
/**
 总时间
 */
@property (nonatomic, readonly, assign) CGFloat totalTime;
/**
 YES 暂停 NO 播放
 */
@property (nonatomic, readonly, assign) BOOL playStateVideo;

@property (nonatomic, readonly, assign) BOOL playToEndTime;

@property (nonatomic, readonly, strong) RACCommand * playVideoCommand;
@property (nonatomic, readonly, strong) RACCommand * muteVideoCommand;
@property (nonatomic, readonly, strong) RACCommand * playPreviousTrackCommand;
@property (nonatomic, readonly, strong) RACCommand * playNextTrackCommand;
/**
 是否用户在拖拽slider改变当前时间
 */
@property (nonatomic, assign) BOOL changeCurrentTime;
/**
 静音
 */
@property (nonatomic, readonly, assign) BOOL playerMuted;
/**
 当前地址
 */
@property (nonatomic, readonly, copy) NSString * currentPlayURLPath;
/**
 播放第几个
 */
@property (nonatomic, readonly, assign) NSInteger currentPlayIndex;

/**
 1 第0首 2 最后一首 -1 不能下一曲，上一曲播放
 */
@property (nonatomic, readonly, assign) NSInteger playBeginningEnd;

/**
 初始化播放器

 @param mediaURLs 播放地址String
 @return LYMyPlayer
 */
+ (LYMyPlayer *)creatPlayerWithMediaURLs:(NSArray *)mediaURLs;

/**
 初始化播放器

 @param mediaURLs 播放地址String
 @param showPlayerLayer YES 显示
 @return LYMyPlayer
 */
+ (LYMyPlayer *)creatPlayerWithMediaURLs:(NSArray *)mediaURLs showPlayerLayer:(BOOL)showPlayerLayer;

- (void)updateMediaURLs:(NSArray *)mediaURLs;

/**
 上一首
 */
- (void)playPreviousTrack;

/**
 下一首
 */
- (void)playNextTrack;

/**
 播放
 */
- (void)playVideo;
/**
 暂停
 */
- (void)pauseVideo;
/**
 播放第几个item

 @param index 第几个
 */
- (void)playMediaWithIndex:(NSInteger)index;

- (void)playMediaWithUrl:(NSString *)url;

/**
 设置播放是否静音

 @param type YES 静音
 */
- (void)muteVolumeWithType:(BOOL)type;
/**
 控制声音大小

 @param volume 音量 0.0 ～ 1.0
 */
- (void)controlSoundWithVolume:(CGFloat)volume;
/**
 设置播放进度

 @param value 0~1
 */
- (void)setPlayerSeekToTime:(CGFloat)value;
- (void)setCurrentTimeWihtValue:(CGFloat)value;
/**
 停止播放
 */
- (void)stopPlay;
- (void)clearAll;
@end

NS_ASSUME_NONNULL_END
