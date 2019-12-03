//
//  LYOrderDetialViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYOrderDetialViewController.h"
#import "LYOrderDetialViewModel.h"
#import "LYOrderDetailInfoTableViewCell.h"
#import "LYOrderDetailTravelPackageTableViewCell.h"
#import "LYAlertView.h"
#import "LYCancelOrderViewController.h"
#import "LYModifyOrderFlightViewController.h"
#import "LYCommitCommentViewController.h"

@interface LYOrderDetialViewController ()<UITableViewDelegate,UITableViewDataSource,LYAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) LYOrderDetialViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomCons;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation LYOrderDetialViewController

- (UILabel *)tipLabel{
    if (!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _tipLabel.backgroundColor = [UIColor colorWithHexString:@"#090909" withAlpha:0.75];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.text = @"test";
        _tipLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.popTips.length > 0) {
        [self tipComeout:self.popTips];
        self.popTips = @"";
    }
}

- (void)tipComeout:(NSString *)text{
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

- (void)setupInterface{
    self.title = @"Booking Information";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYOrderDetailInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYOrderDetailInfoTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYOrderDetailTravelPackageTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYOrderDetailTravelPackageTableViewCellID];
    [self.view addSubview:self.tipLabel];
}

- (void)bindViewModel{
    self.viewModel = [[LYOrderDetialViewModel alloc] initWithParameter:self.data];
    @weakify(self);
    [self.viewModel.getDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
    }];
    
    [self.viewModel.removeOrderCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            [self tipComeout:@"Removed"];
        }
    }];
    
    [self.tableView reloadData];
//    [self.viewModel.getDataCommand execute:nil];
    
    if (self.viewModel.leftButtonType == 0 && self.viewModel.rightButtonType == 0) {
        self.bottomView.hidden = YES;
        self.tableViewBottomCons.constant = -54.f;
    }else{
        //buttonType 0 无按钮 1 cancel 2 Proceed to payment 3 Edit Flight Info 4 Write a Review 5 Remove
        switch (self.viewModel.leftButtonType) {
            case 0:
//                [self.leftButton removeFromSuperview];
                self.leftButton.hidden = YES;
                break;
            case 1:
                [self.leftButton setTitle:@"Cancel" forState:UIControlStateNormal];
                self.leftButton.tag = 1001;
                break;
            case 2:
                [self.leftButton setTitle:@"Proceed to payment" forState:UIControlStateNormal];
                self.leftButton.tag = 1002;
                break;
            case 3:
                [self.leftButton setTitle:@"Edit Flight Info" forState:UIControlStateNormal];
                self.leftButton.tag = 1003;
                break;
            case 4:
                [self.leftButton setTitle:@"Write a Review" forState:UIControlStateNormal];
                self.leftButton.tag = 1004;
                break;
            case 5:
                [self.leftButton setTitle:@"Remove" forState:UIControlStateNormal];
                self.leftButton.tag = 1005;
                break;
            default:
                break;
        }
        
        switch (self.viewModel.rightButtonType) {
            case 0:
                self.rightButton.hidden = YES;
                break;
            case 1:
                [self.rightButton setTitle:@"Cancel" forState:UIControlStateNormal];
                self.rightButton.tag = 1001;
                break;
            case 2:
                [self.rightButton setTitle:@"Proceed to payment" forState:UIControlStateNormal];
                self.rightButton.tag = 1002;
                break;
            case 3:
                [self.rightButton setTitle:@"Edit Flight Info" forState:UIControlStateNormal];
                self.rightButton.tag = 1003;
                break;
            case 4:
                [self.rightButton setTitle:@"Write a Review" forState:UIControlStateNormal];
                self.rightButton.tag = 1004;
                break;
            case 5:
                [self.rightButton setTitle:@"Remove" forState:UIControlStateNormal];
                self.rightButton.tag = 1005;
                break;
            default:
                break;
        }
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 170.f;
    }
    return self.viewModel.travelPackageModel.cellHeight;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        LYOrderDetailInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYOrderDetailInfoTableViewCellID];
        cell.data = self.viewModel.infoModel;
        return cell;
    }
    LYOrderDetailTravelPackageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYOrderDetailTravelPackageTableViewCellID];
    cell.data = self.viewModel.travelPackageModel;
    return cell;
}

- (IBAction)clickLeftButton:(id)sender {
    UIButton *button = (UIButton*)sender;
    [self clickButtonWithType:button.tag];
}

- (IBAction)clickRightButton:(id)sender {
    UIButton *button = (UIButton*)sender;
    [self clickButtonWithType:button.tag];
}

- (void)clickButtonWithType:(NSInteger)tag{
    switch (tag) {
        case 1001:
            //Cancel
        {
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYCancelOrderVCStoryboard" bundle:nil];
            LYCancelOrderViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYCancelOrderViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        break;
        case 1002:
            //Proceed to payment
        break;
        case 1003:
            //Edit Flight Info
            {
               UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYCancelOrderVCStoryboard" bundle:nil];
               LYModifyOrderFlightViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYModifyOrderFlightViewController"];
               [self.navigationController pushViewController:vc animated:YES];
            }
        break;
        case 1004:
            //Write a Review
            {
               UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYCancelOrderVCStoryboard" bundle:nil];
               LYCommitCommentViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYCommitCommentViewController"];
               [self.navigationController pushViewController:vc animated:YES];
            }
        break;
        case 1005:
            [self showAlert];
        break;
            
        default:
            break;
    }
}

- (void)showAlert{
    LYAlertView *alert = [[LYAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alert.delegate = self;
    [alert alertViewControllerWithMessage:@"Are you sure you want to delete this Booking ？" title:@"Delete Booking" leftButtonTitle:@"Cancel" rightButtonTitle:@"OK"];
    alert.userInteractionEnabled = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alert];
}

#pragma mark -LYAlertViewDelegate
- (void)clickConfirmButton{
    [self.viewModel.removeOrderCommand execute:nil];
}


@end
