//
//  LYCommitCommentViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCommitCommentViewController.h"
#import "LYCommitCommentViewModel.h"
#import "LYCanOrderOtherTableViewCell.h"
#import "LYCommitCommentTableViewCell.h"
#import "UIView+LYHUD.h"
#import "LYOrderDetialViewController.h"
#import "LYTourOrderViewController.h"

@interface LYCommitCommentViewController ()<UITableViewDelegate,UITableViewDataSource,LYCommitCommentTableViewCellDelegate,LYCanOrderOtherTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) LYCommitCommentViewModel *viewModel;
@end

@implementation LYCommitCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self bindViewModel];
}

- (void)setupInterface{
    self.title = @"Review";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCanOrderOtherTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYCanOrderOtherTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCommitCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:LYCommitCommentTableViewCellID];
}

- (void)bindViewModel{
    self.viewModel = [[LYCommitCommentViewModel alloc] initWithParameter:self.data];
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
            if ([x[@"type"] integerValue] == 1) {
                [self login_modulesShowMSGCenterHUDWithMSG:@"Please enter 2 to 1800 characters"];
            }
        }
    }];

    self.submitButton.rac_command = self.viewModel.submitCommand;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 280.f;//要区分一日游 178 和 多日游 280
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        LYCommitCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYCommitCommentTableViewCellID];
        cell.delegate = self;
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

#pragma mark - LYCommitCommentTableViewCellDelegate

- (void)clickStarView:(NSDictionary *)dic{
    if (dic) {
        
    }
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

@end
