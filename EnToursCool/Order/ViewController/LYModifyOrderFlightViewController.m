//
//  LYModifyOrderFlightViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYModifyOrderFlightViewController.h"
#import "LYModifyOrderFlightViewModel.h"
#import "LYCancelOrderProductCellTableViewCell.h"
#import "LYModifyOrderFlightTableViewCell.h"
#import "LYOrderDetialViewController.h"
#import "LYTourOrderViewController.h"

@interface LYModifyOrderFlightViewController ()<UITableViewDelegate,UITableViewDataSource,LYModifyOrderFlightTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property(nonatomic,strong) LYModifyOrderFlightViewModel *viewModel;
@end

@implementation LYModifyOrderFlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.title = @"Cancel Booking";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCancelOrderProductCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYCancelOrderProductCellTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYModifyOrderFlightTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYModifyOrderFlightTableViewCellID];
}

- (void)bindViewModel{
    self.viewModel = [[LYModifyOrderFlightViewModel alloc] initWithParameter:self.data];
    @weakify(self);
    [self.viewModel.submitCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x[@"code"] integerValue] == 0) {
            UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
            if ([vc isKindOfClass:[LYOrderDetialViewController class]]) {
                LYOrderDetialViewController *vc0 = (LYOrderDetialViewController*)vc;
                vc0.popTips = @"Submitted successfully";
                [self.navigationController popToViewController:vc0 animated:YES];
            }
            if([vc isKindOfClass:[LYTourOrderViewController class]]){
                [[NSNotificationCenter defaultCenter] postNotificationName:kOrderSecondVCPopNotificationName object:nil userInfo:@{@"popTips":@"You have successfully canceled the order"}];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else{
            //发通知
            NSString *msg = @"Please complete the flight information";
//            if ([x[@"type"] integerValue] == 1) {
//                msg = @"Please complete the airline information";
//            }
//            else if ([x[@"type"] integerValue] == 2) {
//               msg = @"Please complete the flight information";
//            }else if ([x[@"type"] integerValue] == 3) {
//                msg = @"Please complete the landing airport information";
//            }else if ([x[@"type"] integerValue] == 4) {
//                msg = @"Please complete the arrival time information";
//            }else if ([x[@"type"] integerValue] == 5) {
//                msg = @"Please complete the airline information";
//            }else if ([x[@"type"] integerValue] == 6) {
//                msg = @"Please complete the flight information";
//            }else if ([x[@"type"] integerValue] == 7) {
//                msg = @"Please complete the departure airport information";
//            }else if ([x[@"type"] integerValue] == 8) {
//                msg = @"Please complete the departure time information";
//            }
            
            NSDictionary *dic = @{@"type":x[@"type"],@"msg":msg};
            [[NSNotificationCenter defaultCenter] postNotificationName:kOrderFlightInfoErrorNotificationName object:nil userInfo:dic];
        }
    }];

    self.submitButton.rac_command = self.viewModel.submitCommand;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 145.f;
    }
    return 540.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        LYCancelOrderProductCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYCancelOrderProductCellTableViewCellID];
        cell.data = @"";
        return cell;
    }
    LYModifyOrderFlightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYModifyOrderFlightTableViewCellID];
    cell.delegate = self;
    cell.data = @"";
    return cell;
}


- (IBAction)clickCancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -LYModifyOrderFlightTableViewCellDelegate
- (void)textViewReturnData:(NSString *)text type:(NSString *)type{
    NSInteger typeValue = type.integerValue;
    switch (typeValue) {
        case 1:
            self.viewModel.arrivalAirline = text;
        break;
        case 2:
             self.viewModel.arrivalFlightNumber = text;
            break;
        case 3:
             self.viewModel.arrivalLandingAirport = text;
            break;
        case 4:
             self.viewModel.arrivalTime = text;
            break;
        case 5:
            self.viewModel.departureAirline = text;
            break;
        case 6:
            self.viewModel.departureFlightNumber = text;
            break;
        case 7:
            self.viewModel.departureAirport = text;
            break;
        case 8:
            self.viewModel.departureTime = text;
            break;
        default:
            break;
    }
}

@end
