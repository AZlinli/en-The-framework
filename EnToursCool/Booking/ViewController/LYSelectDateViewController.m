//
//  LYSelectDateViewController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/28.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYSelectDateViewController.h"

#import "UIView+LYNib.h"

#import "LYSelectDateTableViewHeaderView.h"
#import "LYSelectDateViewModel.h"

#import "LYPickupCell.h"




@interface LYSelectDateViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *bookBtn;
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *coverBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) LYSelectDateTableViewHeaderView * selectDateTableViewHeaderView;
@property (nonatomic, strong) LYSelectDateViewModel * selectDateViewModel;

@end

@implementation LYSelectDateViewController

#pragma mark - life

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self bindViewModel];
    [self setupInterface];
}

#pragma mark - privite

- (void)bindViewModel
{
    // FIXME: LDL数据测试：
    self.data = @{@"dateString":@"2020-1-18",@"durationDays":@"6",@"id":@"1443",@"isKids":@"1",@"isSinglePu":@"0",@"maxChildAge":@"12",@"maxNumGuest":@"3",@"minNumGuest":@"1",@"productEntityType":@"1",@"productName":@"（6天）【中线美食】新西兰基督城+皇后镇+但尼丁+箭镇跟团游·饕餮之旅+纯净之旅+奥马鲁观企鹅（每周六发团）",@"selfSupport":@"0"};
     if (self.data) {
            self.selectDateViewModel = [[LYSelectDateViewModel alloc] initWithParameter:self.data];
        }
      @weakify(self);
         
         [self.selectDateViewModel.calculateTotalPriceCommand.errors subscribeNext:^(NSError * _Nullable x) {
             @strongify(self);
             [UIView dismissHUDWithView:self.view];
         }];
         
         [[self.selectDateViewModel.calculateTotalPriceCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
             @strongify(self);
             if ([x boolValue]) {
                 if (![UIView viewHasHUDWithView:self.view]) {
                     [UIView showLoadingHUDWithView:self.view msg:nil];
                 }
             }
         }];
         
         [self.selectDateViewModel.calculateTotalPriceCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
             @strongify(self);
             [UIView dismissHUDWithView:self.view];
             if ([x[@"code"] integerValue] != 0) {
                 if (x[@"msg"]) {
                     [UIView showMSGCenterHUDWithView:self.view msg:[NSString stringWithFormat:@"%@", x[@"msg"]]];
                 }
             }
         }];
         
         self.selectDateTableViewHeaderView = [LYSelectDateTableViewHeaderView loadFromNib];
         self.selectDateTableViewHeaderView.data = self.selectDateViewModel;
         self.selectDateTableViewHeaderView.autoresizingMask = UIViewAutoresizingNone;
         
         
         
         [self.selectDateViewModel.httpRequestDateCommand.executing subscribeNext:^(NSNumber * _Nullable x) {
             @strongify(self);
             if ([x boolValue]) {
                 if (![UIView viewHasHUDWithView:self.view]) {
                     [UIView showLoadingHUDWithView:self.view msg:nil];
                 }
             }
         }];
         
         [self.selectDateViewModel.httpRequestDateCommand.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
             @strongify(self);
             [UIView dismissHUDWithView:self.view];
             if ([x[@"code"] integerValue] != 0) {
                 [UIView showMSGBottomHUDWithView:self.view msg:[NSString stringWithFormat:@"%@", x[@"msg"]]];
             }
         }];
         
         [self setNetWorkErrorBlock:^{
             @strongify(self);
             [self.selectDateViewModel.httpRequestDateCommand execute:nil];
         }];
         
         [self.selectDateViewModel.httpRequestDateCommand.errors subscribeNext:^(NSError * _Nullable x) {
             @strongify(self);
             [UIView dismissHUDWithView:self.view];
             [self showNetErrorView];
         }];
         
         [self.selectDateViewModel.httpRequestDateCommand execute:nil];
}

- (void)setupInterface
{
    self.title = @"Departure date";
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.bookBtn.layer.cornerRadius = self.bookBtn.height * 0.5;
    self.bookBtn.layer.masksToBounds = YES;
    self.selectDateTableViewHeaderView = [LYSelectDateTableViewHeaderView loadFromNib];
    self.selectDateTableViewHeaderView.data = self.selectDateViewModel;
    self.selectDateTableViewHeaderView.autoresizingMask = UIViewAutoresizingNone;
    self.myTableView.tableHeaderView = self.selectDateTableViewHeaderView;
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYPickupCell class]) bundle:nil] forCellReuseIdentifier:LYPickupCellID];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        LYPickupCell *pickCell = [self.myTableView dequeueReusableCellWithIdentifier:LYPickupCellID];
        return pickCell;
    }else
    {
        return [UITableViewCell new];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 103;
    }else
    {
        return 353;
    }
}

#pragma mark - action

- (IBAction)priceBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.arrowBtn.selected = sender.selected;
}

- (IBAction)msgBtnClick:(UIButton *)sender
{
}

- (IBAction)bookBtnClick:(UIButton *)sender
{
}

@end
