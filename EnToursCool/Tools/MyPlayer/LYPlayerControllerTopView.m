//
//  LYPlayerControllerTopView.m
//  ToursCool
//
//  Created by tourscool on 6/14/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYPlayerControllerTopView.h"
#import "UIImage+LYUtil.h"
#import "UIButton+LYTourscoolExtension.h"
#import <Masonry/Masonry.h>
@implementation LYPlayerControllerTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[[UIImage imageNamed:@"common_back_btn_normal"] imageTintedWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(16.f);
        }];
        [backButton setEnlargeEdgeWithTop:8.f right:36.f bottom:8.f left:24.f];
        @weakify(self);
        [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.userTapPlayerControllerTopViewBackButton) {
                self.userTapPlayerControllerTopViewBackButton();
            }
        }];
        
    }
    return self;
}

@end
