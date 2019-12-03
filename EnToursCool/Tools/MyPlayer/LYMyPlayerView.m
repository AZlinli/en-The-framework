//
//  LYMyPlayerView.m
//  ToursCool
//
//  Created by tourscool on 11/9/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYMyPlayerView.h"
#import "LYPlayerManager.h"
#import "LYMyPlayer.h"
#import "LYPlayerControllerView.h"
#import "LYPlayerControllerTopView.h"
//#import "LYFullPlayVideoViewController.h"
#import "UIView+LYNib.h"
#import "UIView+LYUtil.h"
#import "UIView+LYHUD.h"
#import "UIButton+LYTourscoolSetImage.h"
#import <ReactiveObjC/ReactiveObjC.h>
//UIGestureRecognizerDelegate
@interface LYMyPlayerView()
@property (nonatomic, readwrite, weak) LYPlayerControllerView * playerControllerView;
@property (nonatomic, readwrite, weak) LYPlayerControllerTopView * playerControllerTopView;
@property (nonatomic, weak) LYMyPlayer *myPlayer;
@property (nonatomic, strong) dispatch_block_t afterBlock;
@end

@implementation LYMyPlayerView


- (instancetype)initCanMove:(BOOL)canMove
{
    if (self = [super init]) {
        self.canMove = canMove;
        LYPlayerControllerView * playerControllerView = [LYPlayerControllerView loadFromNib];
        [self addSubview:playerControllerView];
        @weakify(self);
        [playerControllerView setUserTapPlayerControllerPlayButton:^{
            @strongify(self);
            [self.playerManager.myPlayer.playVideoCommand execute:nil];
        }];
        [playerControllerView setUserTapPlayerControllerMuteButton:^{
            @strongify(self);
            [self.playerManager.myPlayer.muteVideoCommand execute:nil];
        }];
        
        [playerControllerView setUserTapPlayerControlSliderValueChanged:^(CGFloat value) {
            @strongify(self);
            self.playerControllerView.hidden = NO;
            self.playerControllerTopView.hidden = NO;
            self.playerManager.myPlayer.changeCurrentTime = YES;
            [self.playerManager.myPlayer setCurrentTimeWihtValue:value];
        }];
        
        [playerControllerView setUserTapPlayerControlSliderValueEndChanged:^(CGFloat value) {
            @strongify(self);
            [self.playerManager.myPlayer setPlayerSeekToTime:value];
        }];
        
        [playerControllerView setUserTapPlayerControlFullScreenButton:^{
            @strongify(self);
            if (!self.playerManager.isFullScreen) {
                [self.playerManager goFullPlayVideoViewController];
            }else{
                [self.playerManager dismissFullPlayVideoViewController];
            }
        }];
        
        self.playerControllerView = playerControllerView;
        self.backgroundColor = [UIColor blackColor];
        [self autoFadeOutControlView];
        
        UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        tapGestureRecognizer.numberOfTapsRequired = 2;
        [[tapGestureRecognizer rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            [self.playerManager playOrPauseVideo];
        }];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        if (self.canMove) {
            UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
            //        panGestureRecognizer.delegate = self;
            [[panGestureRecognizer rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
                @strongify(self);
                
                CGPoint position = [x translationInView:self];
                LYNSLog(@"position == %f", position.x);
                if (self.playerManager.myPlayer.currentPlayIndex == 0 && position.x > 0) {
                    CGFloat tx = self.transform.tx;
                    self.transform = CGAffineTransformIdentity;
                    self.playerManager.panTx = -tx;
                    return ;
                }
                CGPoint speed = [x velocityInView:self];
                LYNSLog(@"speed == %f", speed.x);
                self.transform = CGAffineTransformTranslate(self.transform, position.x, 0);
                self.playerManager.panTx = position.x;
                [x setTranslation:CGPointZero inView:self];
                if (x.state == UIGestureRecognizerStateEnded) {
                    CGFloat tx = self.transform.tx;
                    if (speed.x < -1000.f) {
                        self.hidden = YES;
                        [self.playerManager.myPlayer stopPlay];
                        if (tx > 0) {
                            CGFloat positionX = kScreenWidth - tx;
                            self.playerManager.panTx = positionX;
                            self.transform = CGAffineTransformTranslate(self.transform, positionX, 0);
                        }else{
                            CGFloat positionX = -(kScreenWidth + tx);
                            self.playerManager.panTx = positionX;
                            self.transform = CGAffineTransformTranslate(self.transform, positionX, 0);
                        }
                        return;
                    }
                    
                    if (fabs(tx) < kScreenWidth/2.f) {
                        self.playerManager.panTx = -tx;
                        self.transform = CGAffineTransformIdentity;
                    }else{
                        self.hidden = YES;
                        [self.playerManager.myPlayer stopPlay];
                        if (tx > 0) {
                            CGFloat positionX = kScreenWidth - tx;
                            self.playerManager.panTx = positionX;
                            LYNSLog(@"+  %f", positionX);
                            self.transform = CGAffineTransformTranslate(self.transform, positionX, 0);
                        }else{
                            CGFloat positionX = -(kScreenWidth + tx);
                            LYNSLog(@"-  %f", positionX);
                            self.playerManager.panTx = positionX;
                            self.transform = CGAffineTransformTranslate(self.transform, positionX, 0);
                        }
                    }
                }
            }];
            [self addGestureRecognizer:panGestureRecognizer];
        }else{
            @weakify(self);
            LYPlayerControllerTopView * playerControllerTopView = [[LYPlayerControllerTopView alloc] init];
            [self addSubview:playerControllerTopView];
            [playerControllerTopView setUserTapPlayerControllerTopViewBackButton:^{
                @strongify(self);
                [self.playerManager dismissFullPlayVideoViewController];
            }];
            self.playerControllerTopView = playerControllerTopView;
        }
    }
    return self;
}

- (void)ly_viewTransformIdentity
{
    self.transform = CGAffineTransformIdentity;
    [self autoFadeOutControlView];
    self.playerControllerView.hidden = NO;
    self.playerControllerTopView.hidden = NO;
}

- (void)autoFadeOutControlView
{
    [self cancelAutoFadeOutControlView];
    @weakify(self)
    self.afterBlock = dispatch_block_create(0, ^{
        @strongify(self)
        [UIView animateWithDuration:0.25 animations:^{
            self.playerControllerView.hidden = YES;
            self.playerControllerTopView.hidden = YES;
        }];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),self.afterBlock);
}

- (void)cancelAutoFadeOutControlView
{
    if (self.afterBlock) {
        dispatch_block_cancel(self.afterBlock);
        self.afterBlock = nil;
    }
}

- (void)setPlayerManager:(LYPlayerManager *)playerManager
{
    _playerManager = playerManager;
    self.myPlayer = playerManager.myPlayer;
    @weakify(self);
    
    [RACObserve(self.playerManager, isFullScreen) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.playerControllerView setPlayerControllerFullScrenButtonSelected:[x boolValue]];
    }];
    
    [RACObserve(self.myPlayer, currentProgress) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x floatValue] == 1.0) {
            if (!self.playerManager.isFullScreen) {
                self.hidden = YES;
            }
            [self.playerManager dismissFullPlayVideoViewController];
        }
        [self.playerControllerView setVoicePlanSliderValue:[x floatValue]];
    }];
    
    [RACObserve(self.myPlayer, playerMuted) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.playerControllerView setPlayerControllerMuteButtonSelected:[x boolValue]];
    }];
    
    [RACObserve(self.myPlayer, currentTime) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.playerControllerView setPlayTime:[x floatValue]];
    }];
    [RACObserve(self.myPlayer, totalTime) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.playerControllerView setAllTime:[x floatValue]];
    }];
    
    [RACObserve(self.myPlayer, buffering) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        LYNSLog(@"buffering == %@", x);
        if ([x boolValue]) {
            LYNSLog(@"YES = %@", self);
            [UIView showLoadingHUDWithView:self msg:nil];
        }else{
            LYNSLog(@"NO = %@", self);
            [UIView dismissHUDWithView:self];
        }
    }];
    
    [RACObserve(self.myPlayer.myPlayer, rate) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.playerControllerView setPlayerControllerPlayButtonSelected:[x boolValue]];
    }];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.myPlayer.playerLayer.frame = self.bounds;
    self.playerControllerTopView.frame = CGRectMake(0, 0.f, CGRectGetWidth(rect), kTopHeight);
    [self.layer addSublayer:self.myPlayer.playerLayer];
    [self.layer insertSublayer:self.myPlayer.playerLayer atIndex:0];
    self.playerControllerView.frame = CGRectMake(0, CGRectGetHeight(rect) - 40.f, CGRectGetWidth(rect), 40.f);
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    LYNSLog(@"gestureRecognizer %@", gestureRecognizer);
//    LYNSLog(@"otherGestureRecognizer %@", otherGestureRecognizer);
//    return YES;
//}

#pragma mark - Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ([[[[event allTouches] anyObject] view] isKindOfClass:[UIButton class]]) {
        return;
    }
    [self autoFadeOutControlView];
    LYNSLog(@"touchesBeganLYMyPlayerView");
    self.playerControllerView.hidden = NO;
    self.playerControllerTopView.hidden = NO;
}

- (void)dealloc
{
    [self cancelAutoFadeOutControlView];
    LYNSLog(@"dealloc - %@", NSStringFromClass([self class]));
}

@end
