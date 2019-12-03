//
//  LYPlayerControllerView.m
//  ToursCool
//
//  Created by tourscool on 6/14/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYPlayerControllerView.h"
#import "LYCustomSlider.h"
#import "UIButton+LYTourscoolSetImage.h"
#import "NSString+LYTool.h"

@interface LYPlayerControllerView ()
@property (nonatomic, weak) IBOutlet UIButton * playButton;
@property (nonatomic, weak) IBOutlet UIButton * muteButton;
@property (nonatomic, weak) IBOutlet UIButton * fullScrenButton;
@property (nonatomic, weak) IBOutlet UILabel * playTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel * allTimeLabel;
@property (nonatomic, weak) IBOutlet LYCustomSlider * voicePlanSlider;
@property (nonatomic, assign) BOOL userChangeVoicePlanSliderValue;
@end

@implementation LYPlayerControllerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
    
//    UIProgressView
    self.playTimeLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_12];
    self.allTimeLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_12];
    [self.playButton setButtonImageName:@"player_controller_pause_btn" forState:UIControlStateSelected];
    [self.playButton setButtonImageName:@"player_controller_play_btn" forState:UIControlStateNormal];
    
    [self.muteButton setButtonImageName:@"player_controller_close_voice_btn" forState:UIControlStateSelected];
    [self.muteButton setButtonImageName:@"player_controller_open_voice_btn" forState:UIControlStateNormal];
    self.voicePlanSlider.maximumValue = 1.f;
    self.voicePlanSlider.minimumValue = 0.f;
//    self.voicePlanSlider.continuous = NO;
    self.voicePlanSlider.tintColor = [UIColor whiteColor];
    self.voicePlanSlider.minimumTrackTintColor = [LYTourscoolAPPStyleManager ly_FD9073Color];
//    [self.voicePlanSlider setMinimumTrackImage:[UIImage imageNamed:@"play_minimum_track_img"] forState:UIControlStateNormal];
//    [self.voicePlanSlider setMaximumTrackImage:[UIImage imageNamed:@"play_maximum_track_img"] forState:UIControlStateNormal];
    
    [self.voicePlanSlider setThumbImage:[UIImage imageNamed:@"player_controller_slider"] forState:UIControlStateNormal];
    [self.voicePlanSlider setThumbImage:[UIImage imageNamed:@"player_controller_slider"] forState:UIControlStateHighlighted];
    
    [self.fullScrenButton setButtonImageName:@"player_controller_small_screen_btn" forState:UIControlStateSelected];
    [self.fullScrenButton setButtonImageName:@"player_controller_full_screen_btn" forState:UIControlStateNormal];
    
    @weakify(self);
    
    [[self.voicePlanSlider rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.userChangeVoicePlanSliderValue = YES;
        if (self.userTapPlayerControlSliderValueChanged) {
            self.userTapPlayerControlSliderValueChanged(self.voicePlanSlider.value);
        }
    }];
    
    [[self.voicePlanSlider rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LYNSLog(@"UIControlEventTouchUpInside");
        @strongify(self);
        self.userChangeVoicePlanSliderValue = NO;
        if (self.userTapPlayerControlSliderValueEndChanged) {
            self.userTapPlayerControlSliderValueEndChanged(self.voicePlanSlider.value);
        }
    }];
    
    [[self.fullScrenButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LYNSLog(@"UIControlEventTouchUpInside");
        @strongify(self);
        if (self.userTapPlayerControlFullScreenButton) {
            self.userTapPlayerControlFullScreenButton();
        }
    }];
    
    [[self.playButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.userTapPlayerControllerPlayButton) {
            self.userTapPlayerControllerPlayButton();
        }
    }];
    
    [[self.muteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.userTapPlayerControllerMuteButton) {
            self.userTapPlayerControllerMuteButton();
        }
    }];
    
}

- (void)setPlayerControllerPlayButtonSelected:(BOOL)selected
{
    self.playButton.selected = selected;
}

- (void)setPlayerControllerMuteButtonSelected:(BOOL)selected
{
    self.muteButton.selected = selected;
}

- (void)setPlayerControllerFullScrenButtonSelected:(BOOL)selected
{
    self.fullScrenButton.selected = selected;
}

- (void)setAllTime:(CGFloat)allTime
{
    self.allTimeLabel.text = [NSString getMMSSFromSS:allTime];
}

- (void)setPlayTime:(CGFloat)currentTime
{
    self.playTimeLabel.text = [NSString getMMSSFromSS:currentTime];
}

- (void)setVoicePlanSliderValue:(CGFloat)value
{
    if (self.userChangeVoicePlanSliderValue) {
        return;
    }
    [self.voicePlanSlider setValue:value animated:YES];
}

@end
