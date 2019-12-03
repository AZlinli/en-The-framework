//
//  LYCartViewController.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCartViewController.h"
#import "LYContactSheet.h"
#import "LYProductListViewController.h"
#import "TourStepper.h"
#import "LYCancelOrderViewController.h"
#import "LYModifyOrderFlightViewController.h"
#import "LYCommitCommentViewController.h"
#import "LYDetailTravelerInfoViewController.h"
#import "LYOrderDetialViewController.h"
#import "LYRouterManager.h"
@interface LYCartViewController ()
//需要显示步进器的占位view
@property (weak, nonatomic) IBOutlet UIView *stepPlaceView;
@property (nonatomic, strong) TourStepper *stepper;


@end

@implementation LYCartViewController

#pragma mark - lazyLoading
- (TourStepper *)stepper
{
    if (!_stepper)
    {
        _stepper = [TourStepper stepperWithValueChanged:^(double value) {
            //步进器发生值改变的时候回调此处
            
        }];
        _stepper.minimumValue = 0;
        _stepper.maximumValue = 100;
        _stepper.stepValue = 1;
//        _stepper.tintColor = [UIColor colorWithHexString:@"#EFEF4"];
    }
    return _stepper;
}

#pragma mark - life
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTestBtn];
    [self addStepperView];
}

#pragma mark - action

- (void)addTestBtn
{
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.center = self.view.center;
    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testBtn setBackgroundColor:[UIColor orangeColor]];
    testBtn.bounds = CGRectMake(0, 0, 100, 50);
    [testBtn setTitle:@"点我to sheet" forState:UIControlStateNormal];
    [[testBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LYProductListStoryboard" bundle:nil];
//        LYProductListViewController * vc = [sb instantiateViewControllerWithIdentifier:@"LYProductListViewController"];
//
//        [self.navigationController pushViewController:vc animated:YES];
        [LYRouterManager openReconstructionLoginTypeViewControllerWithCurrentVC:self parameter:nil];
//
//        LYContactSheet *sheet = [[LYContactSheet alloc] initWithContactViewWithTelephone:^{
//            LYNSLog(@"点击了telephone");
//        } online:^{
//            LYNSLog(@"点击了ONLINE");
//        } email:^{
//            LYNSLog(@"点击了EMAIL");
//        }];
//        [sheet show];
    }];
    [self.view addSubview:testBtn];
}

//添加自定义步进器
- (void)addStepperView
{
    self.stepper.frame = self.stepPlaceView.frame;
    [self.view addSubview:self.stepper];
}


@end
