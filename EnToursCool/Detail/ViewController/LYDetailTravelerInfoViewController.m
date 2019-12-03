//
//  LYDetailTravelerInfoViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailTravelerInfoViewController.h"
#import "LYDetailTravelerInfoViewModel.h"
#import "LYEditTravelerInfoViewController.h"
#import "LYDetailTravelerInfoViewTableViewCell.h"

@interface LYDetailTravelerInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) LYDetailTravelerInfoViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;//You need to choose 3 travelers //Apply
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;

@end

@implementation LYDetailTravelerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.navigationItem.title = @"Traveler information";
    [self.applyButton setTitle:@"You need to choose 3 travelers" forState:UIControlStateDisabled];
    self.applyButton.enabled = NO;
    self.applyButton.alpha = 0.3f;
    [self.tableView registerClass:[LYDetailTravelerInfoViewTableViewCell class] forCellReuseIdentifier:LYDetailTravelerInfoViewTableViewCellID];
}

- (void)bindViewModel{
    self.viewModel = [[LYDetailTravelerInfoViewModel alloc] initWithParameter:self.data];
    
//    @weakify(self);
//    [self.viewModel.getDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        [self.tableView reloadData];
//    }];
//    [self.viewModel.getDataCommand execute:nil];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.viewModel.dataArray.count;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYDetailTravelerInfoViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYDetailTravelerInfoViewTableViewCellID];
//    cell.data = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    @weakify(self);
    [cell setEditBlock:^(NSString * _Nullable IDString) {
        @strongify(self);
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
        LYEditTravelerInfoViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYEditTravelerInfoViewController"];
        vc.data = @"";//todo
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [cell setSelectedBlock:^(NSString * _Nullable IDString) {
        @strongify(self);
        //todo
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
//    LYEditTravelerInfoViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYEditTravelerInfoViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickAddButton:(id)sender {
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
    LYEditTravelerInfoViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYEditTravelerInfoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
