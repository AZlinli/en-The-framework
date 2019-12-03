//
//  LYIntegralDetailsViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYIntegralDetailsViewController.h"
#import "LYIntegralDetailsViewModel.h"
#import "LYIntegralDetailsInfoTableViewCell.h"
#import "LYIntegralDetailsItemTableViewCell.h"
#import "LYIntergralDetailsHeaderView.h"

@interface LYIntegralDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) LYIntegralDetailsViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation LYIntegralDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.title = @"Reward Points";
   [self.tableView registerNib:[UINib nibWithNibName:@"LYIntegralDetailsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:LYIntegralDetailsInfoTableViewCellID];
   [self.tableView registerNib:[UINib nibWithNibName:@"LYIntegralDetailsItemTableViewCell" bundle:nil] forCellReuseIdentifier:LYIntegralDetailsItemTableViewCellID];
    [self.tableView registerClass:[LYIntergralDetailsHeaderView class] forHeaderFooterViewReuseIdentifier:LYIntergralDetailsHeaderViewID];
}

- (void)bindViewModel{
    self.viewModel = [[LYIntegralDetailsViewModel alloc] init];
    @weakify(self);
    [self.viewModel.getDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
    }];
    
//    [self.viewModel.getDataCommand execute:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 182.f;
    }
    return 73.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40.f;
    }
    return 0.1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        LYIntergralDetailsHeaderView *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:LYIntergralDetailsHeaderViewID];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]] && section == 1) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor whiteColor];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LYIntegralDetailsInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYIntegralDetailsInfoTableViewCellID];
        cell.data = self.viewModel.infoModel;
        return cell;
    }else{
        LYIntegralDetailsItemTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYIntegralDetailsItemTableViewCellID];
        cell.data = [self.viewModel.dataArray objectAtIndex:indexPath.row];
        if (indexPath.row == self.viewModel.dataArray.count -1) {
            cell.sepLine.hidden = YES;
        }else{
            cell.sepLine.hidden = NO;
        }
        return cell;
    }

}


@end
