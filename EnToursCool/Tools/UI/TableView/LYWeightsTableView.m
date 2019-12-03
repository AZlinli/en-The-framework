//
//  LYWeightsTableView.m
//  LYBook
//
//  Created by luoyong on 2018/9/28.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import "LYWeightsTableView.h"
#import "LYTableViewManager.h"
#import "LYRACWeightsTableViewViewModel.h"

@interface LYWeightsTableView()
@property (nonatomic, readwrite, strong) LYTableViewManager * tableViewManager;
@property (nonatomic, readwrite, weak) LYRACWeightsTableViewViewModel * weightsTableViewViewModel;
@end

@implementation LYWeightsTableView

- (void)configurationTableViewWithViewModel:(LYRACWeightsTableViewViewModel *)viewModel
                                  cellNames:(NSArray *)cellNames
                            headerViewNames:(NSArray *)headerViewNames
                            footerViewNames:(NSArray *)footerViewNames
{
    self.tableFooterView = [[UIView alloc] init];
    self.weightsTableViewViewModel = viewModel;
    self.tableViewManager = [[LYTableViewManager alloc] initWithTableView:self cells:cellNames headerViews:headerViewNames footerViews:footerViewNames];
    
    @weakify(self);
//    [RACObserve(kAPPDelegate, netWorkStatus) subscribeNext:^(id  _Nullable x) {
//        NSLog(@"------x == %@", x);
//    }];
    
    [self.tableViewManager setTableFooterRefreshingBlock:^{
        @strongify(self);
        [self.weightsTableViewViewModel.requestDataCommand execute:@(0)];
    }];
    
    [self.tableViewManager setTableHeaderRefreshingBlock:^{
        @strongify(self);
        [self.weightsTableViewViewModel.requestDataCommand execute:@(1)];
    }];
    
    [self.tableViewManager beginRefreshing];
    
    
    [self.tableViewManager setTableViewDidSelectRowAtIndexPath:^(NSIndexPath *content) {
        @strongify(self);
        [self.weightsTableViewViewModel.didSelectRowCommand execute:content];
    }];
    
    [self.weightsTableViewViewModel.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //        [self.baseTableView.mj_footer setHidden:NO];
        [self.tableViewManager endRefreshing];
        if ([x integerValue] == 2) {
            [self.tableViewManager endRefreshingWithNoMoreData];
        }else if ([x integerValue] == 0) {
            [self.tableViewManager setEmptyData];
        }else{
            [self.tableViewManager resetNoMoreData];
        }
    }];
    
    [self.weightsTableViewViewModel.requestDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self.tableViewManager setEmptyData];
        [self.tableViewManager endRefreshing];
    }];
}

- (void)tableViewReloadData
{
    @weakify(self);
    [[RACObserve(self.weightsTableViewViewModel, dataArray) skip:1] subscribeNext:^(NSArray *  _Nullable x) {
        @strongify(self);
        [self.tableViewManager updateDatasWithArray:x];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
