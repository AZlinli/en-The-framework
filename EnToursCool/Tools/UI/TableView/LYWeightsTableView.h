//
//  LYWeightsTableView.h
//  LYBook
//
//  Created by luoyong on 2018/9/28.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYRACWeightsTableViewViewModel, LYTableViewManager;
@interface LYWeightsTableView : UITableView
@property (nonatomic, readonly, weak) LYRACWeightsTableViewViewModel * weightsTableViewViewModel;
@property (nonatomic, readonly, strong) LYTableViewManager * tableViewManager;

- (void)configurationTableViewWithViewModel:(LYRACWeightsTableViewViewModel *)viewModel
                                  cellNames:(NSArray *)cellNames
                            headerViewNames:(NSArray *)headerViewNames
                            footerViewNames:(NSArray *)footerViewNames;
- (void)tableViewReloadData;
@end
