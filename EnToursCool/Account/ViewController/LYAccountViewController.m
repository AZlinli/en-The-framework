//
//  LYAccountViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYAccountViewController.h"
#import "LYLoginViewController.h"
#import "LYAccountViewModel.h"
#import "UIView+LYCorner.h"
#import "LYAccountTableViewCell.h"
#import "LYWishListViewController.h"
#import "LYSettingViewController.h"
#import "LYTravelerInformationViewController.h"
#import "LYTourOrderViewController.h"
#import "LYIntegralDetailsViewController.h"
#import "LYMemberProfileViewController.h"

@interface LYAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pointImageView;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) LYAccountViewModel *viewModel;
@end

@implementation LYAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHexString:@"19A8C7"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (void)setupInterface{
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont fontWithName:@"Arial" size: 16];;
    self.pointLabel.textColor = [UIColor whiteColor];
    self.pointLabel.font = [UIFont fontWithName:@"Arial" size: 12];
    
    self.pointLabel.userInteractionEnabled = YES;
    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
       [[tap rac_gestureSignal] subscribeNext:^(id x) {
           @strongify(self);
           UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
           LYIntegralDetailsViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYIntegralDetailsViewController"];
           [self.navigationController pushViewController:vc animated:YES];
       }];
       [self.pointLabel addGestureRecognizer:tap];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYAccountTableViewCell" bundle:nil] forCellReuseIdentifier:LYAccountTableViewCellID];
}

- (void)bindViewModel{
    self.viewModel = [[LYAccountViewModel alloc] init];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tableView circularBeadWithRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20.f, 20.f)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView * headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10.f;
    }
    return 0.f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *itemArray = [self.viewModel.dataArray objectAtIndex:section];
    return itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYAccountTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYAccountTableViewCellID];
    NSArray *itemArray = [self.viewModel.dataArray objectAtIndex:indexPath.section];
    cell.data = [itemArray objectAtIndex:indexPath.row];
    if (indexPath.row == itemArray.count -1) {
        cell.sepLine.hidden = YES;
    }else{
        cell.sepLine.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.row == 0 && indexPath.section == 0)
     {
         LYTourOrderViewController *listVc = [[LYTourOrderViewController alloc] init];
         listVc.needCancleUnderLine = YES;
         [self.navigationController pushViewController:listVc animated:YES];
    }
    if (indexPath.row == 1 && indexPath.section == 0)
    {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
        LYWishListViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYWishListViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 3 && indexPath.section == 0)
    {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
        LYMemberProfileViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYMemberProfileViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.row == 0 && indexPath.section == 1)
    {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
        LYSettingViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYSettingViewController"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (indexPath.row == 2 && indexPath.section == 0)
    {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
        LYTravelerInformationViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYTravelerInformationViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


- (IBAction)clickHeaderButton:(id)sender {
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
    LYMemberProfileViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYMemberProfileViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
