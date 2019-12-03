//
//  LYTourOrderViewController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTourOrderViewController.h"
#import "LYTourOrderListViewController.h"

@interface LYTourOrderViewController ()

@end

@implementation LYTourOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addChildVcs];
}

#pragma mark - priviteMethod

- (void)addChildVcs
{
    self.title = @"My Booking";
    [self addChildsWithStatus:OrderStatus_All title:@"All"];
    [self addChildsWithStatus:OrderStatus_waitPay title:@"Payment Pending"];
    [self addChildsWithStatus:OrderStatus_waitGo title:@"Confirmed"];
    [self addChildsWithStatus:OrderStatus_traveling title:@"Traveling"];
}

- (void)addChildsWithStatus:(OrderStatus)status title:(NSString *)title
{
    LYTourOrderListViewController *allVc = [[LYTourOrderListViewController alloc] initWithStyle:UITableViewStyleGrouped];
    allVc.status = status;
    allVc.title = title;
    [self addChildViewController:allVc];
}


@end
