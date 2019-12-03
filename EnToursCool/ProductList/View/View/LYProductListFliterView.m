//
//  LYProductListFliterView.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListFliterView.h"
#import "LYProductListFliterTableViewCell.h"
#import "LYProductListFliterPriceTableViewCell.h"
#import "LYProductListFliterHeaderView.h"
#import "LYProductListFliterFooterView.h"
#import <Masonry/Masonry.h>
#import "LYProductListFliterModel.h"
#import "UIView+LYUtil.h"
#import "LYProductListMoreFilterView.h"

@interface LYProductListFliterView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) UIButton *closeButton;

@property(nonatomic, weak) UIButton *showResultButton;
//@property(nonatomic, weak) UILabel *resultLabel;
@property (nonatomic, weak) LYProductListMoreFilterView * filtrateView;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation LYProductListFliterView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [closeButton setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateNormal];
////        closeButton.frame = CGRectMake(kScreenWidth-30, 16, 14, 14);
//        [self addSubview:closeButton];
//        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-16.f);
//            make.top.equalTo(self.mas_top).offset(16.f);
//            make.width.offset(14.f);
//            make.height.offset(14.f);
//        }];
//        self.closeButton = closeButton;
//        self.closeButton.hidden = YES;
//        @weakify(self);
//        closeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                @strongify(self);
//                [self filtrateViewAnimateWithType:NO];
//                [subscriber sendCompleted];
//                return nil;
//            }];
//        }];
//
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 30];
//        titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
//        titleLabel.text = @"Filter";
//        [self addSubview:titleLabel];
//        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).offset(16.f);
//            make.top.equalTo(self.mas_top).offset(30.f);
//        }];
        

        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor redColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        tableView.allowsSelection = NO;
        tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:tableView];
        self.tableView = tableView;
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(10.f);
            make.bottom.equalTo(self.mas_bottom).offset(-54.f);
        }];
        
        
        [self.tableView registerNib:[UINib nibWithNibName:@"LYProductListFliterTableViewCell" bundle:nil] forCellReuseIdentifier:LYProductListFliterTableViewCellID];
        [self.tableView registerClass:[LYProductListFliterHeaderView class] forHeaderFooterViewReuseIdentifier:LYProductListFliterHeaderViewID];
        [self.tableView registerClass:[LYProductListFliterPriceTableViewCell class] forCellReuseIdentifier:LYProductListFliterPriceTableViewCellID];
        
        [self.tableView registerClass:[LYProductListFliterFooterView class] forHeaderFooterViewReuseIdentifier:LYProductListFliterFooterViewID];
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.offset(54.f);
        }];
        
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        [bottomView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(1.f);
            make.top.left.right.equalTo(bottomView);
        }];
        
        UIButton *showResultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        showResultButton.backgroundColor = [UIColor colorWithHexString:@"FEA735"];
        showResultButton.layer.cornerRadius = 17;
        [showResultButton setTitle:@"Show results" forState:UIControlStateNormal];
        [showResultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        showResultButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
        [showResultButton addTarget:self action:@selector(clickShowResultButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:showResultButton];
        self.showResultButton = showResultButton;
        [showResultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(34.f);
            make.width.offset(120.f);
//            make.right.equalTo(bottomView.mas_right).offset(-32.f);
            make.left.equalTo(bottomView.mas_centerX).offset(10.f);
            make.top.equalTo(bottomView.mas_top).offset(10.f);
        }];
        
        
        UIButton *clearAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clearAllButton.backgroundColor = [UIColor whiteColor];
        clearAllButton.layer.cornerRadius = 17;
        clearAllButton.layer.borderColor = [UIColor colorWithHexString:@"FEA735"].CGColor;
        clearAllButton.layer.borderWidth = 1.0f;
        [clearAllButton setTitle:@"Clear All" forState:UIControlStateNormal];
        [clearAllButton setTitleColor:[UIColor colorWithHexString:@"FEA735"] forState:UIControlStateNormal];
        clearAllButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
        [clearAllButton addTarget:self action:@selector(clickClearAllButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:clearAllButton];
        [clearAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(34.f);
            make.width.offset(120.f);
            make.right.equalTo(bottomView.mas_centerX).offset(-10.f);
            make.top.equalTo(bottomView.mas_top).offset(10.f);
        }];
     
    }
    
    return self;
}

- (void)dataDidChange{
    self.dataArray = self.data;
    [self.tableView reloadData];
}

- (void)clickClearAllButton:(id)sender{
    
}

- (void)clickShowResultButton:(id)sender{
    [self.viewModel.getDataCommand execute:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.f;
    }else{
        LYProductListFliterSectionModel *model = [self.dataArray objectAtIndex:section - 1];
        if(model.isShowMore){
            return 40.f;
        }else{
            return 0.f;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section != 0) {
        LYProductListFliterSectionModel *model = [self.dataArray objectAtIndex:section - 1];
        if (model.isShowMore) {
            LYProductListFliterFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYProductListFliterFooterViewID];
            @weakify(self);
            [headerView setSelectedBlock:^{
                @strongify(self);
                self.filtrateView.hidden = NO;
                self.filtrateView.data = @"";
            }];
            
            return headerView;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LYProductListFliterHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYProductListFliterHeaderViewID];
    if (section == 0) {
        headerView.data = @"Price";
    }else{
        LYProductListFliterSectionModel *model = [self.dataArray objectAtIndex:section - 1];
        headerView.data = model.title;
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80.f;
    }
    return 45.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        LYProductListFliterSectionModel *model = [self.dataArray objectAtIndex:section - 1];
        return model.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        LYProductListFliterPriceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYProductListFliterPriceTableViewCellID];
        //    cell.data = [self.viewModel.dataArray objectAtIndex:indexPath.row];
        return cell;
    }else{
        
        LYProductListFliterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYProductListFliterTableViewCellID];
        LYProductListFliterSectionModel *model = [self.dataArray objectAtIndex:indexPath.section - 1];
        cell.isOnlySelectOne = model.onlySelectedOne;
        cell.data = [model.dataArray objectAtIndex:indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LYProductListFliterSectionModel *model = [self.dataArray objectAtIndex:indexPath.section - 1];
    LYProductListFliterModel *item = [model.dataArray objectAtIndex:indexPath.row];
    item.isSelected = !item.isSelected;
    if(model.onlySelectedOne){
        LYProductListFliterModel *item = [model.dataArray objectAtIndex:indexPath.row];
        if (item.isSelected) {
            for (LYProductListFliterModel *subModel in model.dataArray) {
                if (subModel != item) {
                    subModel.isSelected = NO;
                }
            }
        }
        
    }
}


- (void)filtrateViewAnimateWithType:(BOOL)type{

    if (type) {
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.superview.mas_left);
        }];
        
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:15 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.alpha = 1.f;
            [self layoutIfNeeded];
//            self.hidden = NO;
            
        } completion:^(BOOL finished) {
            self.closeButton.hidden = NO;
        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.superview.mas_left).offset(kScreenWidth);
        }];
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.alpha = 0.0;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
//            self.hidden = YES;
            self.closeButton.hidden = YES;
        }];
    }
}

- (void)addFiltrateView
{
    LYProductListMoreFilterView * filtrateView = [[LYProductListMoreFilterView alloc] init];
    [kWindowRootViewController.view addSubview:filtrateView];
    [filtrateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(kWindowRootViewController.view);
    }];
    self.filtrateView = filtrateView;
    self.filtrateView.hidden = YES;
//    @weakify(self);
//    [self.filtrateView setTouchesBeganFiltrateViewBlock:^(NSDictionary *parameterDic) {
//        LYNSLog(@"LYProductListFiltrateLevelTwoView -- %@", parameterDic);
//        @strongify(self);
//        if (![parameterDic isEqualToDictionary:self.productListViewModel.leftFiltrateDic]) {
//            LYNSLog(@"filtrateDic != parameterDic");
//            self.productListViewModel.leftFiltrateDic = [parameterDic copy];
//        }
//
//    }];
}


@end
