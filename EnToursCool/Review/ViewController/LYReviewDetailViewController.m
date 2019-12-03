//
//  LYReviewDetailViewController.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailViewController.h"
#import "LYReviewDetailHeaderView.h"
#import "LYReviewDetailTextTableViewCell.h"
#import "LYReviewDetailModel.h"
#import "LYReviewDetailViewModel.h"
#import "LYReviewDetailImageTableViewCell.h"
#import "LYReviewDetailTableFooterView.h"
#import "UIView+LYNib.h"

static  NSString *cellID = @"textCell";
static  NSString *imageCellID = @"imgaeCell";
static  NSString *headerID = @"headerView";
static  NSString *footerID = @"footerView";

@interface LYReviewDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**vm*/
@property(nonatomic, strong) LYReviewDetailViewModel *viewModel;
@end

@implementation LYReviewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Reviews"];
    [self creatUI];
    [self.viewModel.detailCommand execute:@"1"];
}

- (void)creatUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    self.tableView.tableFooterView.height = 163;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailTextTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageCellID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:headerID];
    
      [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailTableFooterView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:footerID];
}

#pragma mark UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYReviewDetailModel *model = self.viewModel.dataArray[indexPath.row];
    if (model.type == 1) {
    LYReviewDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellID forIndexPath:indexPath];
        cell.data = model;
     return cell;
    }else{
    LYReviewDetailTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.data = model;
      return cell;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   LYReviewDetailModel *model = self.viewModel.dataArray[indexPath.row];
    if (model.type == 1) {
        return 333/212 * kScreenWidth;
    }else{
       return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 114;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 173;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    LYReviewDetailTableFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerID];
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LYReviewDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    return headerView;
}

#pragma mark getter && setter

- (LYReviewDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LYReviewDetailViewModel alloc]init];
    }
    return _viewModel;
}
@end
