//
//  LYTravelerInformationViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTravelerInformationViewController.h"
#import "LYTravelerInformationViewModel.h"
#import "LYTravelerInformationTableViewCell.h"
#import "LYAlertView.h"
#import "LYEditTravelerInfoViewController.h"

@interface LYTravelerInformationViewController ()<UITableViewDelegate,UITableViewDataSource,LYAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) LYTravelerInformationViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *removeTips;
@property (strong, nonatomic) NSString *removeIDString;
@end

@implementation LYTravelerInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.navigationItem.title = @"Traveler information";
    [self.tableView registerClass:[LYTravelerInformationTableViewCell class] forCellReuseIdentifier:LYTravelerInformationTableViewCellID];
    self.removeTips.hidden = YES;
}

- (void)bindViewModel{
    self.viewModel = [[LYTravelerInformationViewModel alloc] init];
    @weakify(self);
    [[RACObserve(self.viewModel, dataArray) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    [self.viewModel.getDataCommand execute:nil];
    
    [self.viewModel.removeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
       //删除成功出现提示。
        [self showRemoveTips];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   LYTravelerInformationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYTravelerInformationTableViewCellID];
    
    @weakify(self);
    [cell setRemoveBlock:^(NSString * _Nullable IDString) {
        @strongify(self);
        self.removeIDString = IDString;
        [self showAlert];
    }];
    [cell setEditBlock:^(NSString * _Nullable IDString) {
        @strongify(self);
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
        LYEditTravelerInfoViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYEditTravelerInfoViewController"];
        vc.data = @"";//todo
        [self.navigationController pushViewController:vc animated:YES];
    }];
    cell.data = [self.viewModel.dataArray objectAtIndex:indexPath.row];
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
//    LYEditTravelerInfoViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYEditTravelerInfoViewController"];
//    vc.data = @"";//todo
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showAlert{
    LYAlertView *alert = [[LYAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alert.delegate = self;
    [alert alertViewControllerWithMessage:@"Are you sure you want to delete this traveler？" title:@"Delete Traveler" leftButtonTitle:@"Cancel" rightButtonTitle:@"OK"];
    alert.userInteractionEnabled = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alert];
}


- (IBAction)clickAddButton:(id)sender {
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
      LYEditTravelerInfoViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYEditTravelerInfoViewController"];
      [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)showRemoveTips{
    self.removeTips.hidden = NO;
    [self performSelector:@selector(hideDelayed) withObject:[NSNumber numberWithBool:YES] afterDelay:2.0];
}


- (void)hideDelayed {
    self.removeTips.hidden = YES;
}


- (void)clickConfirmButton{
    [self.viewModel.removeCommand execute:self.removeIDString];
}

@end
