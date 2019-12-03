//
//  LYTourOrderListViewController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTourOrderListViewController.h"
#import "LYOderSectionHeadView.h"
#import "LYOrderMainCell.h"
#import "LYOrderSectionFootView.h"
#import "LYOrderMainListViewModel.h"
#import "LYAlertView.h"
#import "LYCancelOrderViewController.h"
#import "LYModifyOrderFlightViewController.h"
#import "LYCommitCommentViewController.h"


@interface LYTourOrderListViewController ()<LYAlertViewDelegate>

@property (nonatomic, strong) LYOrderMainListViewModel *mainListViewModel;

@property (nonatomic, strong) UILabel *tipLabel;

@property (strong, nonatomic) NSString *removeIDString;

@property (nonatomic, strong) NSString *popTips;
@end

@implementation LYTourOrderListViewController

#pragma mark - lazyLoading

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight + 44, kScreenWidth, 1)];
        _tipLabel.backgroundColor = [UIColor colorWithHexString:@"#090909" withAlpha:0.75];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.text = @"test";
        _tipLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}

#pragma mark - life
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self bindViewModel];
    [self addTipLabel];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.popTips.length > 0) {
        [self tipComeout:self.popTips];
        self.popTips = @"";
    }
}


- (void)dealloc
{
    [self.tipLabel removeFromSuperview];
}

#pragma mark - privite
- (void)setup
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaTopHeight - 10, 0);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYOrderMainCell class]) bundle:nil] forCellReuseIdentifier:LYOrderMainCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYOderSectionHeadView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:LYOderSectionHeadViewID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYOrderSectionFootView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:LYOrderSectionFootViewID];
}

- (void)addTipLabel
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.tipLabel];
}

- (void)bindViewModel
{
    self.mainListViewModel = [[LYOrderMainListViewModel alloc] initWithParameter:@{@"status":@(self.status)}];
    @weakify(self);
    //监听数据改变
    [[RACObserve(self.mainListViewModel, dataArray) skip:1] subscribeNext:^(NSArray  * _Nullable x) {
        @strongify(self);
        if (x.count)
        {
            [self removeNetErrorView];
            [self.tableView reloadData];
        }else
        {
            [self showNetErrorViewNoData];
        }
        [self.tableView.mj_header endRefreshing];
    }];
//    //请求数据
//    [self.mainListViewModel.mainOrderCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        if ([x[@"code"] integerValue] != 0)
//        {
//            [self showNetErrorView];
//        }
//        [self.tableView.mj_header endRefreshing];
//    }];
    //设置重刷
    [self setNetWorkErrorBlock:^{
        @strongify(self);
        [self.tableView.mj_header beginRefreshing];
    }];
    //返回网络错误回调
    [self.mainListViewModel.mainOrderCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self showNetErrorView];
    }];
    //监听信号的信号
    [self.mainListViewModel.removeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        LYNSLog(@"弹出提示框狂狂狂狂！！！！");
        [self tipComeout:@"Removed!!!"];
    }];
    //添加刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.mainListViewModel.mainOrderCommand execute:nil];
    }];
    
     [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:kOrderSecondVCPopNotificationName object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.popTips = x.userInfo[@"popTips"];
    }];
}

- (void)tipComeout:(NSString *)text
{
    self.tipLabel.hidden = NO;
    self.tipLabel.text = text;
    [UIView animateWithDuration:0.5 animations:^{
        self.tipLabel.height = 37;
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:1 delay:0.5 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            self.tipLabel.height = 1;
        } completion:^(BOOL finished) {
            self.tipLabel.hidden = YES;
        }];
    }];
}

- (void)showAlert
{
    LYAlertView *alert = [[LYAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alert.delegate = self;
    [alert alertViewControllerWithMessage:@"Are you sure you want to delete this Booking ？" title:@"Delete Booking" leftButtonTitle:@"Cancel" rightButtonTitle:@"OK"];
    alert.userInteractionEnabled = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alert];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mainListViewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYOrderMainCell *mainCell = [self.tableView dequeueReusableCellWithIdentifier:LYOrderMainCellID forIndexPath:indexPath];
    return mainCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LYOderSectionHeadView *head = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:LYOderSectionHeadViewID];
    head.data = self.mainListViewModel.dataArray[section];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    LYOrderSectionFootView *footView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:LYOrderSectionFootViewID];
    footView.data = self.mainListViewModel.dataArray[section];
    @weakify(self)
    footView.removeBlock = ^(NSString * _Nullable travelID) {
        @strongify(self)
        self.removeIDString = travelID;
        [self showAlert];
    };
    footView.cancelBlock = ^(NSString * _Nullable travelID){
        @strongify(self);
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYCancelOrderVCStoryboard" bundle:nil];
        LYCancelOrderViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYCancelOrderViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    };
    footView.payBlock = ^(NSString * _Nullable travelID) {
         @strongify(self);
    };
    footView.commentBlock = ^(NSString * _Nullable travelID) {
        @strongify(self);
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYCancelOrderVCStoryboard" bundle:nil];
        LYCommitCommentViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYCommitCommentViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    };
    footView.flightBlock = ^(NSString * _Nullable travelID) {
        @strongify(self);
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYCancelOrderVCStoryboard" bundle:nil];
        LYModifyOrderFlightViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYModifyOrderFlightViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    };
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 90;
}

#pragma mark - <LYAlertViewDelegate>

-(void)clickConfirmButton
{
    [self.mainListViewModel.removeCommand execute:self.removeIDString];
}



@end
