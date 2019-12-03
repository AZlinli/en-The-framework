//
//  LYMyPlayer.m
//  ToursCool
//
//  Created by tourscool on 11/9/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYMyPlayer.h"
//#import "LYGuideTourDownloadDBManager.h"
//#import "LYGuideTourDownloadItemModel.h"

@interface LYMyPlayer()
/**
 时间监听
 */
@property (nonatomic, strong) id timeObserver;
@property (nonatomic, readwrite, strong) AVPlayer * myPlayer;
@property (nonatomic, readwrite, strong) AVAsset * asset;
@property (nonatomic, readwrite, strong) AVPlayerItem * playerItem;
@property (nonatomic, readwrite, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, readwrite, assign) CGFloat currentProgress;
@property (nonatomic, readwrite, assign) CGFloat totalTime;
@property (nonatomic, readwrite, assign) CGFloat currentTime;
@property (nonatomic, readwrite, assign) BOOL playStateVideo;

@property (nonatomic, readwrite, strong) RACCommand * playVideoCommand;
@property (nonatomic, readwrite, strong) RACCommand * muteVideoCommand;
@property (nonatomic, readwrite, strong) RACCommand * playPreviousTrackCommand;
@property (nonatomic, readwrite, strong) RACCommand * playNextTrackCommand;

@property (nonatomic, readwrite, copy) NSString * currentPlayURLPath;
@property (nonatomic, readwrite, assign) BOOL playerMuted;
@property (nonatomic, readwrite, assign) NSInteger currentPlayIndex;
@property (nonatomic, readwrite, assign) NSInteger playBeginningEnd;
@property (nonatomic, readwrite, assign) BOOL playToEndTime;
@property (nonatomic, readwrite, assign) BOOL buffering;

/**
 用于当显示SmallPlayerView 拖动slider 暂停而被删除
 */
@property (nonatomic, assign) BOOL ignorePlayStateVideo;

@property (nonatomic, readwrite, assign) BOOL showAVPlayerLayer;

@end
@implementation LYMyPlayer

+ (LYMyPlayer *)creatPlayerWithMediaURLs:(NSArray *)mediaURLs
{
    LYMyPlayer * player = [[LYMyPlayer alloc] init];
    player.showAVPlayerLayer = YES;
    [player creatPlayerWithMediaURLs:mediaURLs];
    return player;
}

+ (LYMyPlayer *)creatPlayerWithMediaURLs:(NSArray *)mediaURLs showPlayerLayer:(BOOL)showPlayerLayer
{
    LYMyPlayer * player = [[LYMyPlayer alloc] init];
    player.showAVPlayerLayer = showPlayerLayer;
    [player creatPlayerWithMediaURLs:mediaURLs];
    return player;
}

- (void)updateMediaURLs:(NSArray *)mediaURLs
{
    self.allMediaURLs = [mediaURLs copy];
    [self stopPlay];
}

- (void)creatPlayerWithMediaURLs:(NSArray *)mediaURLs
{
    self.changeCurrentTime = NO;
    self.allMediaURLs = [mediaURLs copy];
    self.currentPlayIndex = 0;
    self.playBeginningEnd = 1;
    self.playerMuted = NO;
    if (!self.showAVPlayerLayer) {
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
//        [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
    }
    if (self.allMediaURLs.count) {
        self.currentPlayURLPath = self.allMediaURLs[self.currentPlayIndex];
        [self updateAsset];
        self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
        
        [self createPlayer];
        if (self.showAVPlayerLayer) {
            self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
            //    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            //    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        }
        
        [self addTimeObservers];
    }
    
    
}

- (BOOL)playStateVideo
{
    if (self.myPlayer.rate == 0) {
        return YES;
    }
    return NO;
}

- (void)playVideo
{
    [self addTimeObservers];
    [self.myPlayer play];
}

- (void)pauseVideo
{
    [self.myPlayer pause];
}

- (void)muteVolumeWithType:(BOOL)type
{
    self.playerMuted = type;
    self.myPlayer.muted = type;
}

- (void)controlSoundWithVolume:(CGFloat)volume
{
    CGFloat absvolume = fabs(volume);
    self.myPlayer.volume = absvolume;
}

- (void)setCurrentTimeWihtValue:(CGFloat)value
{
    float time = value * CMTimeGetSeconds(self.myPlayer.currentItem.duration);
    if (self.totalTime) {
        self.currentProgress = time / self.totalTime;
        self.currentTime = time;
    }
}

- (void)setPlayerSeekToTime:(CGFloat)value
{
    self.ignorePlayStateVideo = YES;
    [self pauseVideo];
    float time = value * CMTimeGetSeconds(self.myPlayer.currentItem.duration);
    int32_t timeScale = self.myPlayer.currentItem.asset.duration.timescale;
    CMTime cmTime = CMTimeMakeWithSeconds(time, timeScale);
    @weakify(self);
    [self.myPlayer seekToTime:cmTime toleranceBefore:CMTimeMake(1, 1000) toleranceAfter:CMTimeMake(1, 1000) completionHandler:^(BOOL finished) {
        @strongify(self);
        [self playVideo];
    }];
    if (self.totalTime) {
        self.currentProgress = time / self.totalTime;
        self.currentTime = time;
    }
    
    self.changeCurrentTime = NO;
    self.ignorePlayStateVideo = NO;
}

- (void)playMediaWithUrl:(NSString *)url
{
//    self.allMediaURLs = @[];
    self.playBeginningEnd = -1;
    self.continuousPlaybackState = NO;
    self.currentPlayURLPath = url;
    [self removeObservers];
    [self.myPlayer pause];
    [self updateAsset];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    [self createPlayer];
    [self.myPlayer replaceCurrentItemWithPlayerItem:self.playerItem];
    
    [self addTimeObservers];
    [self.myPlayer play];
}

- (void)updateAsset
{
//    NSArray<LYGuideTourDownloadSubItemModel *> * items = [LYGuideTourDownloadDBManager queryDownloadItemWithServerAddress:self.currentPlayURLPath];
//    if (items.count) {
//        if (items.firstObject.status == 2) {
//            NSString * localAddress = [NSString stringWithFormat:@"%@/%@",FMFILE,items.firstObject.localAddress];
//            self.asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:localAddress]];
//            return ;
//        }
//    }
    self.asset = [AVAsset assetWithURL:[NSURL URLWithString:self.currentPlayURLPath]];
}

- (void)playMediaWithIndex:(NSInteger)index
{
//    if (self.currentPlayIndex == index) {
//        [self playVideo];
//        return;
//    }
    if (index >= self.allMediaURLs.count) {
        return;
    }
    if (index < 0) {
        return;
    }
    if (index == 0) {
        self.playBeginningEnd = 1;
    }else if (index == self.allMediaURLs.count - 1) {
        self.playBeginningEnd = 2;
    }else{
        self.playBeginningEnd = 3;
    }
    self.currentPlayURLPath = self.allMediaURLs[index];
    [self removeObservers];
    self.currentProgress = 0.f;
    self.currentTime = 0.f;
    [self.myPlayer pause];
    if (!self.currentPlayURLPath.length) {
        if (index == self.allMediaURLs.count - 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self playMediaWithIndex:index - 1];
            });
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self playMediaWithIndex:index + 1];
            });
        }
        return;
    }
    self.currentPlayIndex = index;
    [self updateAsset];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    [self createPlayer];
    [self.myPlayer replaceCurrentItemWithPlayerItem:self.playerItem];
    
    [self addTimeObservers];
    [self.myPlayer play];
}

- (void)playPreviousTrack
{
    NSInteger currentPlayIndex = self.currentPlayIndex - 1;
    currentPlayIndex = [self findPreviousPlayWithIndex:currentPlayIndex];
    self.currentPlayIndex = currentPlayIndex;
}

- (void)playNextTrack
{
    NSInteger currentPlayIndex = self.currentPlayIndex + 1;
    currentPlayIndex = [self findNextPlayWithIndex:currentPlayIndex];
    self.currentPlayIndex = currentPlayIndex;
}

- (NSInteger)findPreviousPlayWithIndex:(NSInteger)index
{
    if (index >= self.allMediaURLs.count) {
        if (self.allMediaURLs.count) {
            return self.allMediaURLs.count - 1;
        }
        return 0;
    }
    if (index < 0) {
        return 0;
    }
    NSString * path = self.allMediaURLs[index];
    if (path.length) {
        return index;
    }
    return [self findPreviousPlayWithIndex:index - 1];
}

- (NSInteger)findNextPlayWithIndex:(NSInteger)index
{
    if (index >= self.allMediaURLs.count) {
        if (self.allMediaURLs.count) {
            return self.allMediaURLs.count - 1;
        }
        return 0;
    }
    if (index < 0) {
        return 0;
    }
    NSString * path = self.allMediaURLs[index];
    if (path.length) {
        return index;
    }
    return [self findNextPlayWithIndex:index + 1];
}

- (void)createPlayer
{
    if (!self.myPlayer) {
        self.myPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
        [self.myPlayer setAutomaticallyWaitsToMinimizeStalling:NO];
        @weakify(self);
        [RACObserve(self.myPlayer, rate) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            LYNSLog(@"self.ignorePlayStateVideo -- %d", self.ignorePlayStateVideo);
            if (!self.ignorePlayStateVideo) {
                self.playStateVideo = ![x boolValue];
            }
        }];
    }
}

- (void)addTimeObservers
{
    if (self.timeObserver) {
        return;
    }
    self.playToEndTime = NO;
    @weakify(self);
    
    [RACObserve(self.playerItem, playbackBufferEmpty) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        LYNSLog(@"playbackBufferEmpty == %@", x);
        if ([x boolValue]) {
            self.buffering = YES;
        }
    }];
    
    [RACObserve(self.playerItem, status) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger itemStatus = [x integerValue];
        if (itemStatus == 2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kAVPlayerItemStatusPlayerItemStatusFailed object:nil];
            [self stopPlay];
            if (self.continuousPlaybackState) {
                [self playNextTrack];
            }
        }
        LYNSLog(@"status == %@", x);
    }];
    
    [RACObserve(self.playerItem, playbackLikelyToKeepUp) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        LYNSLog(@"playbackLikelyToKeepUp == %@", x);
        if ([x boolValue]) {
            self.buffering = NO;
        }
    }];
    
    [RACObserve(self.playerItem, loadedTimeRanges) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSArray *loadedTimeRanges = [self.playerItem loadedTimeRanges];
        if (loadedTimeRanges.count) {
            CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
            float startSeconds = CMTimeGetSeconds(timeRange.start);
            float durationSeconds = CMTimeGetSeconds(timeRange.duration);
            NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
            CMTime duration = self.playerItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            CGFloat downProgress = timeInterval / totalDuration;
            if (downProgress == 1.f) {
                self.buffering = NO;
            }
//            LYNSLog(@"下载进度:%.2f", downProgress);
        }
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self stopPlay];
        self.playToEndTime = YES;
        if (self.continuousPlaybackState) {
            [self playNextTrack];
        }
        LYNSLog(@"播放完成");
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:AVPlayerItemFailedToPlayToEndTimeErrorKey object:self.playerItem] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if (self.continuousPlaybackState) {
            [self playNextTrack];
        }
        LYNSLog(@"播放播放失败");
    }];
    
    self.timeObserver = [self.myPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 10.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        @strongify(self);
        //当前播放的时间
        float current = CMTimeGetSeconds(time);
        //总时间
        float total = CMTimeGetSeconds(self.myPlayer.currentItem.duration);
        self.totalTime = total;
        if (!self.changeCurrentTime) {
            self.currentProgress = current / total;
            self.currentTime = current;
        }
    }];
}

/**
 停止播放
 */
- (void)stopPlay
{
    self.playStateVideo = YES;
    [self.myPlayer pause];
    [self.myPlayer seekToTime:CMTimeMake(0, 1)];
    self.currentTime = 0.f;
    self.currentProgress = 0.f;
    [self removeObservers];
}

- (void)clearAll
{
    self.myPlayer = nil;
    self.playerItem = nil;
    self.asset = nil;
    self.playerLayer = nil;
}

- (void)removeObservers
{
    if (self.timeObserver) {
        [self.myPlayer removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:self.playerItem];
}

- (RACCommand *)playVideoCommand
{
    if (!_playVideoCommand) {
        @weakify(self);
        _playVideoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                if (!self.playStateVideo) {
                    [self pauseVideo];
                }else{
                    [self playVideo];
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _playVideoCommand;
}

- (RACCommand *)muteVideoCommand
{
    if (!_muteVideoCommand) {
        @weakify(self);
        _muteVideoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                [self muteVolumeWithType:!self.playerMuted];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _muteVideoCommand;
}

- (RACCommand *)playNextTrackCommand
{
    if (!_playNextTrackCommand) {
        @weakify(self);
        _playNextTrackCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                [self playNextTrack];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _playNextTrackCommand;
}

- (RACCommand *)playPreviousTrackCommand
{
    if (!_playPreviousTrackCommand) {
        @weakify(self);
        _playPreviousTrackCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                [self playPreviousTrack];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _playPreviousTrackCommand;
}

- (void)dealloc
{
    [self removeObservers];
    LYNSLog(@"dealloc -- %@", NSStringFromClass([self class]));
}

@end
