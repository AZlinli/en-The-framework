//
//  LYPlayerManager.m
//  ToursCool
//
//  Created by tourscool on 11/12/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYPlayerManager.h"
#import "LYMyPlayer.h"
#import "LYMyPlayerView.h"
#import "LYSmallPlayerView.h"
//#import "LYFullPlayVideoViewController.h"
#import "UIView+LYUtil.h"
#import <Masonry/Masonry.h>
@interface LYPlayerManager ()
@property (nonatomic, readwrite, strong) LYMyPlayer * myPlayer;
@property (nonatomic, readwrite, strong) LYSmallPlayerView * smallPlayerView;
@property (nonatomic, readwrite, strong) LYMyPlayerView * myPlayerView;
@property (nonatomic, readwrite, weak) UIView * currentCanvas;
@property (nonatomic, readwrite, assign) BOOL playerState;

@end
@implementation LYPlayerManager

- (instancetype)initWithCanvas:(UIView *)canvas mediaURLs:(NSArray *)mediaURLs
{
    if (self = [super init]) {
        _myPlayer = [LYMyPlayer creatPlayerWithMediaURLs:mediaURLs];
        _myPlayerView = [[LYMyPlayerView alloc] initCanMove:YES];
        _myPlayerView.playerManager = self;
        _currentCanvas = canvas;
        [canvas addSubview:_myPlayerView];
        [_myPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(canvas);
        }];
        [self changePlayCanvasWithView:_currentCanvas];
        @weakify(self);
        
        [RACObserve(self.myPlayer, currentProgress) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (self.smallPlayerView) {
                [self.smallPlayerView setProgressBarProgressWithProgress:[x floatValue]];
            }
        }];
        
        
        [[[RACObserve(self.myPlayer, playStateVideo) skip:1] distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.playerState = [x boolValue];
        }];
        
        [[[RACObserve(self.myPlayer, playToEndTime) skip:1] distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if ([x boolValue]) {
                [self recoverCanvasToMyPlayerView];
                LYNSLog(@"small播放完成");
            }
            LYNSLog(@"subscribeNext -- 播放status");
        }];
    }
    return self;
}

- (instancetype)initMediaURLs:(NSArray *)mediaURLs
{
    if (self = [super init]) {
        _myPlayer = [LYMyPlayer creatPlayerWithMediaURLs:mediaURLs];
        @weakify(self);
        [RACObserve(self.myPlayer, playStateVideo) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.playerState = [x boolValue];
            if ([x boolValue]) {
                LYNSLog(@"small播放完成");
            }
            LYNSLog(@"subscribeNext -- 播放status");
        }];
    }
    return self;
}


- (void)playVideo
{
    [self.myPlayer playVideo];
}

- (void)pauseVideo
{
    [self.myPlayer pauseVideo];
}

- (void)playerManagerStopPlay
{
    self.myPlayerView.hidden = YES;
    [self.myPlayer stopPlay];
}

- (void)playOrPauseVideo
{
    if (self.playerState) {
        [self playVideo];
    }else{
        [self pauseVideo];
    }
}

- (void)playerManagerPlayMediaWithIndex:(NSInteger)index
{
    [self.myPlayer playMediaWithIndex:index];
}

- (BOOL)playerState
{
    return [self.myPlayer playStateVideo];
}

- (void)changePlayCanvasWithView:(UIView *)view
{
    if (!view) {
        return;
    }
    self.myPlayer.playerLayer.frame = view.bounds;
    [view.layer addSublayer:self.myPlayer.playerLayer];
    [view.layer insertSublayer:self.myPlayer.playerLayer atIndex:0];
    self.currentCanvas = view;
}

- (void)restoreMyPlayerView
{
    self.myPlayer.playerLayer.frame = self.myPlayerView.bounds;
    [self.myPlayerView.layer addSublayer:self.myPlayer.playerLayer];
    [self.myPlayerView.layer insertSublayer:self.myPlayer.playerLayer atIndex:0];
}

- (void)addMiniPlayer
{
    if (!self.smallPlayerView) {
        self.smallPlayerView = [LYSmallPlayerView creatSmallPlayer];
        @weakify(self);
        [self.smallPlayerView setCloseSmallPlayerViewBlock:^{
            @strongify(self);
            [self.myPlayer pauseVideo];
            [self recoverCanvasToMyPlayerView];
        }];
        
        [self.smallPlayerView setSmallGoFullScrrenPlayerViewBlock:^{
            @strongify(self);
            [self goFullPlayVideoViewController];
        }];
        self.myPlayer.playerLayer.frame = self.smallPlayerView.bounds;
        [self.smallPlayerView.layer addSublayer:self.myPlayer.playerLayer];
        [self.smallPlayerView.layer insertSublayer:self.myPlayer.playerLayer atIndex:0];
        self.smallPlayerView.canvas = self.myPlayerView;
    }
}

- (void)goFullPlayVideoViewController
{
    self.isFullScreen = YES;
//    LYFullPlayVideoViewController * fullPlayVideoViewController = [[LYFullPlayVideoViewController alloc] init];
//    fullPlayVideoViewController.data = self;
//    [self.myPlayerView.viewController presentViewController:fullPlayVideoViewController animated:YES completion:nil];
}

- (void)dismissFullPlayVideoViewController
{
    if (self.myPlayerView.viewController.presentedViewController) {
        self.isFullScreen = NO;
        @weakify(self);
        [self.myPlayerView.viewController dismissViewControllerAnimated:YES completion:^{
            @strongify(self);
            if (self.playerState && (self.myPlayer.currentProgress == 1.f || self.myPlayer.currentProgress == 0.f)) {
                self.myPlayerView.hidden = YES;
            }
            [self recoverCanvas];
        }];
    }
}

- (void)recoverCanvas
{
    if (self.smallPlayerView) {
        [self recoverCanvasToSmallPlayerView];
    }else{
        [self recoverCanvasToMyPlayerView];
    }
}

- (void)recoverCanvasToSmallPlayerView
{
    self.myPlayer.playerLayer.frame = self.smallPlayerView.bounds;
    [self.smallPlayerView.layer addSublayer:self.myPlayer.playerLayer];
    [self.smallPlayerView.layer insertSublayer:self.myPlayer.playerLayer atIndex:0];
}

- (void)recoverCanvasToMyPlayerView
{
    self.myPlayer.playerLayer.frame = CGRectMake(0, 0, kScreenWidth, 260.f);
    [self.myPlayerView.layer addSublayer:self.myPlayer.playerLayer];
    [self.myPlayerView.layer insertSublayer:self.myPlayer.playerLayer atIndex:0];
    [self removeSmallPlayer];
}

- (void)removeSmallPlayer
{
    [self.smallPlayerView removeFromSuperview];
    self.smallPlayerView = nil;
}

- (void)dealloc
{
    LYNSLog(@"dealloc%@", NSStringFromClass([self class]));
}

@end
