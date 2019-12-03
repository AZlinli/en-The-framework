//
//  LYProductListFilterViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListFilterViewController.h"
#import "LYProductListFliterView.h"
#import <Masonry/Masonry.h>

@interface LYProductListFilterViewController ()

@end

@implementation LYProductListFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Filter";
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1.0f);
        make.top.left.right.equalTo(self.view);
    }];
    
    LYProductListFliterView *filterView = [[LYProductListFliterView alloc] init];
    filterView.viewModel = self.viewModel;
    filterView.data = self.data;
    [self.view addSubview:filterView];
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(line.mas_bottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    [filterView addFiltrateView];
}



@end
