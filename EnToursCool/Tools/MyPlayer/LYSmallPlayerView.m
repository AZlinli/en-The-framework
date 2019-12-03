//
//  LYSmallPlayerView.m
//  ToursCool
//
//  Created by tourscool on 11/12/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSmallPlayerView.h"
//#import "LYFullPlayVideoViewController.h"
#import "UIView+LYUtil.h"
#import "UIButton+LYTourscoolSetImage.h"
static CGFloat buttonWidth = 20.f;

@interface LYSmallPlayerView()
@property (nonatomic, weak) UIProgressView * progressBar;
@end

@implementation LYSmallPlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (LYSmallPlayerView *)creatSmallPlayer
{
    LYSmallPlayerView * smallPlayerView = [[LYSmallPlayerView alloc] initWithFrame:CGRectMake(16.f, [[UIApplication sharedApplication] statusBarFrame].size.height + 104.f, 180.f, 160.f)];
    return smallPlayerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doMoveAction:)];
        [self addGestureRecognizer:panGestureRecognizer];
        
        UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goFullScrrenPlayerVC:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(CGRectGetWidth(frame) - buttonWidth, 1, buttonWidth, buttonWidth);
        [closeButton setButtonImageName:@"player_close" forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(processPlayerColseButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        UIProgressView *progressBar = [[UIProgressView alloc] init];
        progressBar.progressTintColor = [LYTourscoolAPPStyleManager ly_FD9073Color];
        progressBar.tintColor = [LYTourscoolAPPStyleManager ly_BFBFBFColor];
        progressBar.frame = CGRectMake(0, CGRectGetHeight(frame) - 1.f, CGRectGetWidth(frame), 1.f);
        [self addSubview:progressBar];
        self.progressBar = progressBar;
    }
    return self;
}

- (void)setCanvas:(UIView *)canvas
{
    _canvas = canvas;
    [self bringSubviewToFront:self.progressBar];
    [_canvas.viewController.view addSubview:self];
}

- (void)processPlayerColseButton:(UIButton *)sender
{
    if (self.closeSmallPlayerViewBlock) {
        self.closeSmallPlayerViewBlock();
    }
}

- (void)goFullScrrenPlayerVC:(UITapGestureRecognizer *)recognizer
{
    if (self.canvas.viewController) {
        if (self.smallGoFullScrrenPlayerViewBlock) {
            self.smallGoFullScrrenPlayerViewBlock();
        }
    }
}

- (void)setProgressBarProgressWithProgress:(CGFloat)progress
{
    self.progressBar.progress = progress;
}

- (void)doMoveAction:(UIPanGestureRecognizer *)recognizer
{
    UIView * windowView = self.canvas.viewController.view;
    CGPoint translation = [recognizer translationInView:windowView];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);
    newCenter.y = MAX(recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(windowView.frame.size.height - recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(windowView.frame.size.width - recognizer.view.frame.size.width/2, newCenter.x);
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:windowView];
}

- (void)dealloc
{
    LYNSLog(@"dealloc%@", NSStringFromClass([self class]));
}

@end
