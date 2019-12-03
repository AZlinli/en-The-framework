//
//  LYCancelOrderViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCancelOrderViewController.h"
#import "LYCancelOrderProductCellTableViewCell.h"
#import "LYCancelOrderReasonTableViewCell.h"
#import "LYCanOrderOtherTableViewCell.h"
#import "LYCancelOrderViewModel.h"
#import "LYCancelOrderReasonWithPayedTableViewCell.h"
#import "UIView+LYHUD.h"
#import "LYOrderDetialViewController.h"
#import "LYTourOrderViewController.h"

@interface LYCancelOrderViewController ()<UITableViewDelegate,UITableViewDataSource,LYCanOrderOtherTableViewCellDelegate,LYCancelOrderReasonTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) LYCancelOrderViewModel *viewModel;
@end

@implementation LYCancelOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.title = @"Cancel Booking";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCancelOrderProductCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYCancelOrderProductCellTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCancelOrderReasonTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYCancelOrderReasonTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCanOrderOtherTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYCanOrderOtherTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCancelOrderReasonWithPayedTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYCancelOrderReasonWithPayedTableViewCellID];

}

- (void)bindViewModel{
    self.viewModel = [[LYCancelOrderViewModel alloc] initWithParameter:self.data];
    self.viewModel.reason = @"1";
    @weakify(self);
    [self.viewModel.submitCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
            if ([vc isKindOfClass:[LYOrderDetialViewController class]]) {
                LYOrderDetialViewController *vc0 = (LYOrderDetialViewController*)vc;
                vc0.popTips = @"You have successfully canceled the order";
                [self.navigationController popToViewController:vc0 animated:YES];
            }
            if([vc isKindOfClass:[LYTourOrderViewController class]]){
                [[NSNotificationCenter defaultCenter] postNotificationName:kOrderSecondVCPopNotificationName object:nil userInfo:@{@"popTips":@"You have successfully canceled the order"}];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
    }];
    
    self.submitButton.rac_command = self.viewModel.submitCommand;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 145.f;
    }
//    //付款取消
//    else if(indexPath.row == 1){
//        return 380.f;
//    }
    
    //未付款取消
    else if(indexPath.row == 1){
        return 238.f;
    }
    
    if (self.viewModel.imageArray.count < 3) {
        return 260.f;
    }else{
        return 380.f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    //未付款取消 return 3;
    //付款取消 return 2;
//    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        LYCancelOrderProductCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYCancelOrderProductCellTableViewCellID];
        cell.data = @"";
        return cell;
    }
//    else if(indexPath.row ==1){
//        
//        LYCancelOrderReasonWithPayedTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYCancelOrderReasonWithPayedTableViewCellID];
//        return cell;
//    }
    
    else if(indexPath.row == 1){
        LYCancelOrderReasonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYCancelOrderReasonTableViewCellID];
        cell.data = @"";
        return cell;
    }
    LYCanOrderOtherTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYCanOrderOtherTableViewCellID];
    cell.delegate = self;
    cell.data = self.viewModel.imageArray;
    return cell;
}


- (IBAction)clickCancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - LYHUD

- (void)login_modulesDismissHUD
{
    [UIView dismissHUDWithView:self.navigationController.view];
}

- (void)login_modulesShowMSGCenterHUDWithMSG:(NSString *)msg
{
    [UIView showMSGCenterHUDWithView:self.navigationController.view msg:msg];
}

- (void)login_modulesShowLoadingHUDWithMSG:(NSString *)msg
{
    [UIView showLoadingHUDWithView:self.navigationController.view msg:msg];
}

#pragma mark -LYCanOrderOtherTableViewCellDelegate
- (void)modifyImage:(NSArray*)imageArray{
    self.viewModel.imageArray = imageArray;
    [self.tableView reloadData];
}

- (void)textViewReturnData:(NSString *)text{
    self.viewModel.otherText = text;
}

#pragma mark -LYCancelOrderReasonTableViewCellDelegate
- (void)clickReason:(NSString *)reason{
    self.viewModel.reason = reason;
}

@end
