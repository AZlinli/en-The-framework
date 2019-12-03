//
//  LYTableViewManager.h
//  LYBook
//
//  Created by luoyong on 2018/9/28.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UITableView;
typedef void(^UserRefreshing)(void);
typedef void(^EmptyDataSetDidTapButton)(void);
typedef void(^EmptyDataSetDidTapView)(void);
typedef void(^TableViewDidSelectRowAtIndexPath)(NSIndexPath * content);
/**
 UITableViewHeaderFooterView UITableViewCell 需使用xib
 model 必须继承 LYBaseModel
 只能在外部返回 sectionfooter 和 sectionheader
 */
@interface LYTableViewManager : NSObject
@property (nonatomic, readonly, strong) NSArray* datas;
@property (nonatomic, assign) BOOL closeEmptyData;
@property (nonatomic, copy) NSString * emptyDataImageName;
@property (nonatomic, copy) NSAttributedString * emptyDataAttributedString;
@property (nonatomic, weak) id<UITableViewDelegate> tableViewDelegate;
@property (nonatomic, weak) id<UITableViewDataSource> tableViewDataSource;
@property (nonatomic, copy) EmptyDataSetDidTapButton emptyDataSetDidTapButton;
@property (nonatomic, copy) EmptyDataSetDidTapView emptyDataSetDidTapView;
@property (nonatomic, copy) TableViewDidSelectRowAtIndexPath tableViewDidSelectRowAtIndexPath;

- (void)setupTableViewDelegate:(id)delegate;

- (instancetype)initWithTableView:(UITableView *)tableView cells:(NSArray<NSString *> *)cells headerViews:(NSArray<NSString *> *)headerViews footerViews:(NSArray<NSString *> *)footerViews;

- (instancetype)initWithTableView:(UITableView *)tableView cells:(NSArray<NSString *> *)cells footerViews:(NSArray<NSString *> *)footerViews;

- (instancetype)initWithTableView:(UITableView *)tableView cells:(NSArray<NSString *> *)cells headerViews:(NSArray<NSString *> *)headerViews;

- (instancetype)initWithTableView:(UITableView *)tableView cells:(NSArray<NSString *> *)cells;

- (void)updateDatasWithArray:(NSArray *)array;
- (void)beginRefreshing;
- (void)resetNoMoreData;
- (void)endRefreshingWithNoMoreData;
- (void)endRefreshing;
- (void)setTableHeaderRefreshingBlock:(UserRefreshing)refreshingBlock;
- (void)setTableFooterRefreshingBlock:(UserRefreshing)refreshingBlock;
- (void)setEmptyData;
- (void)setEmptyDataNil;

- (void)beginRefreshingWithBlock:(void(^)(void))block;
@end
