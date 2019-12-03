//
//  LYSearchViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYSearchViewController.h"
#import "LYSearchViewModel.h"
#import "LYSearchViewSectionHeaderView.h"
#import "LYSearchViewTableViewCell.h"
#import "NSString+LYTool.h"
#import "LYSearchVCNavigationTitleView.h"
#import "LYSearchViewResultTableViewCell.h"
#import <Masonry/Masonry.h>

@interface LYSearchViewController ()<UITableViewDelegate,UITableViewDataSource,LYSearchViewTableViewCellDelegate>
@property (nonatomic, strong) LYSearchViewModel * searchViewModel;
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) LYSearchVCNavigationTitleView * navigationSearchTitleView;
@end

@implementation LYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.searchViewModel = [[LYSearchViewModel alloc] initWithParameter:self.data];
    [self setupInterface];
}

- (void)setupInterface{
    self.view.backgroundColor = [LYTourscoolAPPStyleManager ly_F1F1F1Color];
     self.navigationSearchTitleView = [[LYSearchVCNavigationTitleView alloc] init];
    
    @weakify(self);
    [self.navigationSearchTitleView setNavigationTitleViewSearchTextFieldReturnBlock:^(NSString * _Nullable searchTitle) {
        @strongify(self);
        if (searchTitle.length) {
//            [self goListVCWithTitle:searchTitle refreshType:YES];
            //搜索结果页
        }
        
    }];
    
    RAC(self.searchViewModel, searchTitle) = self.navigationSearchTitleView.searchTextField.rac_textSignal;
    
    self.navigationItem.titleView = self.navigationSearchTitleView;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
       if (@available(iOS 11.0, *)) {
           
       }else{
           self.navigationSearchTitleView.frame = CGRectMake(0, 0, kScreenWidth - 100.f, 40.f);
           button.frame = CGRectMake(0, 0, 46, 18);
       }
       [button setTitle:[LYLanguageManager ly_localizedStringForKey:@"Search_Button"] forState:UIControlStateNormal];
       button.titleLabel.font = [UIFont fontWithName:@"Arial" size: 17];
       [button setTitleColor:[LYTourscoolAPPStyleManager ly_484848Color] forState:UIControlStateNormal];
       UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
       self.navigationItem.rightBarButtonItem = rightBarButtonItem;
       
       [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
           [self.navigationSearchTitleView.searchTextField endEditing:YES];
           if (self.searchViewModel.searchTitle.length) {
               //搜索结果页
           }
       }];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(1.0);
        } else {
            make.top.equalTo(self.view.mas_top).offset(kTopHeight).offset(1.0);
        }
        make.right.bottom.left.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYSearchViewSectionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:LYSearchViewSectionHeaderViewID];
    [self.tableView registerNib:[UINib nibWithNibName:@"LYSearchViewTableViewCell" bundle:nil] forCellReuseIdentifier:LYSearchViewTableViewCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYSearchViewResultTableViewCell" bundle:nil] forCellReuseIdentifier:LYSearchViewResultTableViewCellID];
    
    
    
//    @weakify(self);
//    [self.searchViewModel.didSelectItemCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//           @strongify(self);
//           if ([x[@"type"] integerValue] == 1) {
//               [self.navigationSearchTitleView setSearchTextPlaceholder:x[@"key"]];
//               [self goListVCWithTitle:x[@"key"] refreshType:NO];
//           }else if ([x[@"type"] integerValue] == 2) {
//               NSDictionary * dic = nil;
//               if (self.searchViewModel.searchTitle.length) {
//                   dic = @{@"item_type":x[@"itemType"],@"keyword":self.searchViewModel.searchTitle};
//               }else{
//                   dic = @{@"item_type":x[@"itemType"]};
//               }
//               [self goProductListViewControllerWith:dic];
//           }else if ([x[@"type"] integerValue] == 3) {
//               [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,@{@"product_id":x[@"productID"]}] urlKey:LineDetailsViewControllerKey];
//           }else if ([x[@"type"] integerValue] == 4) {
//               [self.navigationSearchTitleView setSearchTextPlaceholder:x[@"key"]];
//               [self goListVCWithTitle:x[@"parameter"][@"title"] refreshType:NO];
//           }else if ([x[@"type"] integerValue] == 10) {
//               [LYRouterManager openSomeOneVCWithParameters:@[self.navigationController,@{@"product_id":x[@"productID"]}] urlKey:LineDetailsViewControllerKey];
//           }
//       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.searchViewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LYSearchViewSectionHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYSearchViewSectionHeaderViewID];
    headerView.data = [self.searchViewModel.dataArray objectAtIndex:section];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LYSearchSectionTitleModel *sectionModel = [self.searchViewModel.dataArray objectAtIndex:section];
    return sectionModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYSearchViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYSearchViewTableViewCellID];
    LYSearchSectionTitleModel *sectionModel = [self.searchViewModel.dataArray objectAtIndex:indexPath.section];
    cell.data = [sectionModel.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     LYSearchSectionTitleModel *sectionModel = [self.searchViewModel.dataArray objectAtIndex:indexPath.section];
    LYSearchItemModel *model = [sectionModel.dataArray objectAtIndex:indexPath.row];
    // todo 到列表
//    [self.searchViewModel.didSelectItemCommand execute: indexPath];
}


- (void)deleteItem:(NSString *)name{
    if (![name isEmpty]) {
        [self.searchViewModel.deleteHistoryCommand execute:name];
    }
}

@end
