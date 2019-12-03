//
//  LYSettingViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYResetPWDViewController.h"
#import "LYSettingViewController.h"
#import "LYSettingVCTableViewCell.h"
#import <Masonry/Masonry.h>
#import "LYAlertView.h"
#import "LYSettingVCLogOutTableViewCell.h"

@interface LYSettingViewController ()<UITableViewDelegate,UITableViewDataSource,LYAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *tipsView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation LYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Tripscool";
    [self.tableView registerClass:[LYSettingVCTableViewCell class] forCellReuseIdentifier:LYSettingVCTableViewCellID];
    [self.tableView registerClass:[LYSettingVCLogOutTableViewCell class] forCellReuseIdentifier:LYSettingVCLogOutTableViewCellID];
    
    
    self.tipsView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isReset) {
        self.tipsView.hidden = NO;
        [self performSelector:@selector(hideDelayed) withObject:[NSNumber numberWithBool:YES] afterDelay:2.0];
        self.isReset = NO;
    }
}
- (void)hideDelayed {
    self.tipsView.hidden = YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10.f;
    }
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LYSettingVCTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYSettingVCTableViewCellID];
        return cell;
    }else{
        LYSettingVCLogOutTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LYSettingVCLogOutTableViewCellID];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYAccountStoryboard" bundle:nil];
        LYResetPWDViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYResetPWDViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self showAlert];
    }
}

- (void)showAlert{
    LYAlertView *alert = [[LYAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alert.delegate = self;
    [alert alertViewControllerWithMessage:@"Are you sure you want to sign out？" title:@"Sign Out" leftButtonTitle:@"Cancel" rightButtonTitle:@"OK"];
    alert.userInteractionEnabled = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alert];
}

#pragma mark -LYAlertViewDelegate
- (void)clickConfirmButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    
}

@end
