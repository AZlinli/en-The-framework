//
//  LYProductListFliterFooterView.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListFliterFooterView.h"
#import <Masonry/Masonry.h>

NSString * const LYProductListFliterFooterViewID = @"LYProductListFliterFooterViewID";

@interface LYProductListFliterFooterView ()

@property(nonatomic, assign)NSInteger index;
@end

@implementation LYProductListFliterFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithReuseIdentifier:reuseIdentifier];

    if (self) {
        self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;});
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor colorWithHexString:@"19A8C7"] forState:UIControlStateNormal];
        [button setTitle:@"see more" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
        
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(16.f);
        }];

    }
    return self;
}

-(void)dataDidChange{
    NSNumber *number = self.data;
    self.index = number.integerValue;
}

- (void)clickButton:(id)sender{
    if (self.selectedBlock) {
        self.selectedBlock();
    }
}

@end
