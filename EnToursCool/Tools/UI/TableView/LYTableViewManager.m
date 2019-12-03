//
//  LYTableViewManager.m
//  LYBook
//
//  Created by luoyong on 2018/9/28.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTableViewManager.h"
#import "LYBaseModel.h"
#import "LYCustomRefreshNormalHeader.h"
#import "LYCustomRefreshAutoStateFooter.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface LYTableViewManager()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, readwrite, strong) NSArray<NSArray *> * datas;
@property (nonatomic, readwrite, weak) UITableView * currentTableView;
@end

@implementation LYTableViewManager
#pragma mark - init
- (instancetype)initWithTableView:(UITableView *)tableView cells:(NSArray<NSString *> *)cells headerViews:(NSArray<NSString *> *)headerViews footerViews:(NSArray<NSString *> *)footerViews
{
    if (self = [super init]) {
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        _currentTableView = tableView;
        
        [cells enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerNib:[UINib nibWithNibName:obj bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%@ID", obj]];
        }];
        
        [headerViews enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerNib:[UINib nibWithNibName:obj bundle:nil] forHeaderFooterViewReuseIdentifier:[NSString stringWithFormat:@"%@ID", obj]];
        }];
        
        [footerViews enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerNib:[UINib nibWithNibName:obj bundle:nil] forHeaderFooterViewReuseIdentifier:[NSString stringWithFormat:@"%@ID", obj]];
        }];
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView cells:(NSArray<NSString *> *)cells footerViews:(NSArray<NSString *> *)footerViews
{
    return [self initWithTableView:tableView cells:cells headerViews:nil footerViews:footerViews];
}

- (instancetype)initWithTableView:(UITableView *)tableView cells:(NSArray<NSString *> *)cells headerViews:(NSArray<NSString *> *)headerViews
{
    return [self initWithTableView:tableView cells:cells headerViews:headerViews footerViews:nil];
}

- (instancetype)initWithTableView:(UITableView *)tableView cells:(NSArray<NSString *> *)cells
{
    return [self initWithTableView:tableView cells:cells headerViews:nil footerViews:nil];
}
#pragma mark - public

- (void)setupTableViewDelegate:(id)delegate
{
    self.tableViewDelegate = delegate;
    self.tableViewDataSource = delegate;
}

- (void)updateDatasWithArray:(NSArray *)array
{
    if (array.count) {
        self.datas = array;
        [self.currentTableView reloadData];
    }
}

- (void)beginRefreshingWithBlock:(void(^)(void))block
{
    if (block) {
        block();
    }
    [self setEmptyDataNil];
    [self.currentTableView.mj_header beginRefreshing];
}


- (void)beginRefreshing
{
    [self setEmptyDataNil];
    [self.currentTableView.mj_header beginRefreshing];
}

- (void)resetNoMoreData
{
    [self.currentTableView.mj_footer resetNoMoreData];
}

- (void)endRefreshingWithNoMoreData
{
    [self.currentTableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)endRefreshing
{
    if (self.currentTableView.mj_header.refreshing) {
        [self.currentTableView.mj_header endRefreshing];
    }
    if (self.currentTableView.mj_footer.refreshing) {
        [self.currentTableView.mj_footer endRefreshing];
    }
}

- (void)setEmptyDataNil
{
    if (self.closeEmptyData) {
        return;
    }
    self.currentTableView.emptyDataSetSource = nil;
    self.currentTableView.emptyDataSetDelegate = nil;
    [self.currentTableView reloadEmptyDataSet];
}

- (void)setEmptyData
{
    if (self.closeEmptyData) {
        return;
    }
    if (!self.datas.count) {
        if (!self.currentTableView.emptyDataSetSource) {
            self.currentTableView.emptyDataSetSource = self;
        }
        if (!self.currentTableView.emptyDataSetDelegate) {
            self.currentTableView.emptyDataSetDelegate = self;
        }
    }else{
        self.currentTableView.emptyDataSetSource = nil;
        self.currentTableView.emptyDataSetDelegate = nil;
    }
    [self.currentTableView reloadEmptyDataSet];
}

- (void)setTableHeaderRefreshingBlock:(UserRefreshing)refreshingBlock
{
    self.currentTableView.mj_header = [LYCustomRefreshNormalHeader headerWithRefreshingBlock:^{
        refreshingBlock();
    }];
}

- (void)setTableFooterRefreshingBlock:(UserRefreshing)refreshingBlock
{
    self.currentTableView.mj_footer = [LYCustomRefreshAutoStateFooter footerWithRefreshingBlock:^{
        refreshingBlock();
    }];
    self.currentTableView.mj_footer.automaticallyChangeAlpha = YES;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.tableViewDataSource && [self.tableViewDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.tableViewDataSource numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableViewDataSource && [self.tableViewDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.tableViewDataSource tableView:tableView numberOfRowsInSection:section];
    }
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewDataSource && [self.tableViewDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.tableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    LYBaseModel * model = self.datas[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:model.cellReuseIdentifier];
    cell.data = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.tableViewDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.tableViewDelegate tableView:tableView heightForHeaderInSection:section];
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.tableViewDelegate tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        return [self.tableViewDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    if (self.tableViewDidSelectRowAtIndexPath) {
        self.tableViewDidSelectRowAtIndexPath(indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.tableViewDelegate tableView:tableView heightForFooterInSection:section];
    }
    return 0.01f;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self.tableViewDelegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    return @[];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.tableViewDelegate scrollViewDidScroll:scrollView];
    }
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (self.emptyDataAttributedString) {
        return self.emptyDataAttributedString;
    }
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f], NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:@"暂无数据!" attributes:attribute];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emptyDataImageName) {
        return [UIImage imageNamed:self.emptyDataImageName];
    }
    return [UIImage imageNamed:@"common_image_large_default"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if (self.emptyDataSetDidTapButton) {
        self.emptyDataSetDidTapButton();
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.emptyDataSetDidTapView) {
        self.emptyDataSetDidTapView();
    }
}

- (void)dealloc
{
    LYNSLog(@"dealloc -- %@", [self class]);
}

@end
