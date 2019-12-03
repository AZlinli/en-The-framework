//
//  LYProductListFliterHeaderVIew.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListFliterHeaderView.h"
#import <Masonry/Masonry.h>

NSString * const LYProductListFliterHeaderViewID = @"LYProductListFliterHeaderViewID";

@interface LYProductListFliterHeaderView()
@property(nonatomic, weak) UILabel *titleLabel;
@end

@implementation LYProductListFliterHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithReuseIdentifier:reuseIdentifier];

    if (self) {
        self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;});
        UILabel *titleLabel  = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16];
        titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(16.f);
        }];

        self.titleLabel = titleLabel;
    }
    return self;
}



- (void)dataDidChange{
    self.titleLabel.text = self.data;
}


@end
