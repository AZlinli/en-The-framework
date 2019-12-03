//
//  LYGuideTourDownloadEditView.m
//  ToursCool
//
//  Created by 稀饭旅行 on 2019/9/27.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYWishListEditView.h"
#import <Masonry/Masonry.h>

@interface LYWishListEditView()
@property(nonatomic, strong) UILabel *infoLabel;
@property(nonatomic, strong) UIButton *selectAllButton;
@property(nonatomic, strong) UIButton *deleteButton;
@end

@implementation LYWishListEditView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectAllButton setImage:[UIImage imageNamed:@"list_fliter_unselected1"] forState:UIControlStateNormal];
        [self.selectAllButton setImage:[UIImage imageNamed:@"list_fliter_selected1"] forState:UIControlStateSelected];
        [self addSubview:self.selectAllButton];
        [self.selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(16.f);
        }];
        
        @weakify(self);
        self.selectAllButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.selectAllButton.selected = !self.selectAllButton.selected;
                NSString *name = [NSString stringWithFormat:@"Remove （%ld)",(long)self.count];
                if (!self.selectAllButton.selected) {
                    name = @"Remove";
                }
                [self.deleteButton setTitle:name forState:UIControlStateNormal];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(clickSelectedAllButton:)]) {
                    [self.delegate clickSelectedAllButton:self.selectAllButton.isSelected];
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.text = @"All";
        self.infoLabel.font = [UIFont fontWithName:@"Arial" size: 14];
        self.infoLabel.textColor = [UIColor colorWithHexString:@"7F7F7F"];
        [self addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.selectAllButton.mas_right).offset(12.f);
            make.width.offset(28.f);
        }];
        //Remove （4）
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setTitle:@"Remove" forState:UIControlStateNormal];
        self.deleteButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
        [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.deleteButton setBackgroundColor:[UIColor colorWithHexString:@"FEA735"]];
        self.deleteButton.layer.cornerRadius = 17.f;
        [self addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-16.f);;
            make.height.offset(34.f);
            make.width.offset(120.f);
        }];

        self.deleteButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(clickDeleteButton)]) {
                    [self.delegate clickDeleteButton];
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];

    }
    return self;
}

- (void)dataDidChange{
    NSNumber *count = self.data;
    self.selectAllButton.selected = (count.intValue == self.count);
    
    NSString *name = [NSString stringWithFormat:@"Remove （%@)",count.stringValue];
    if (count.intValue == 0) {
        name = @"Remove";
    }
    [self.deleteButton setTitle:name forState:UIControlStateNormal];
}

- (void)drawRect:(CGRect)rect{
//    [self addShadowToView:self withColor:[LYTourscoolAPPStyleManager ly_343434ColorAlpha:0.16f]];
}


- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    theView.layer.shadowColor = theColor.CGColor;
    theView.layer.shadowOffset = CGSizeMake(0,0);
    theView.layer.shadowOpacity = 1.f;
    theView.layer.shadowRadius = 1.f;
    // 单边阴影 顶边
    float shadowPathWidth = theView.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(0, 1.f, theView.bounds.size.width, shadowPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    theView.layer.shadowPath = path.CGPath;

}

- (void)modifySelectButtonState{
    self.selectAllButton.selected = NO;
}

- (void)modifySelectButtonNumber{
    
}
@end
