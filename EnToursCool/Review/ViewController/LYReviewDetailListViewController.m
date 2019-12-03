//
//  LYReviewDetailListViewController.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailListViewController.h"
#import "LYReviewDetailListTableViewCell.h"
#import "LYReviewDetailListHeaderView.h"
#import "LYReviewDetailViewController.h"

static  NSString *imageCellID = @"imgaeCell";
static  NSString *headerID = @"headerView";

@interface LYReviewDetailListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LYReviewDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

- (void)creatUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    self.tableView.tableFooterView.height = 163;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailListTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageCellID];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYReviewDetailListHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:headerID];
    
}

#pragma mark UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   LYReviewDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellID forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 350;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 393;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LYReviewDetailViewController *vc = [[LYReviewDetailViewController alloc]initWithNibName:@"LYReviewDetailViewController" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
              ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LYReviewDetailListHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    return headerView;
}
@end
