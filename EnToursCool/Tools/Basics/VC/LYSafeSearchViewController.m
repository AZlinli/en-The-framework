//
//  LYSafeViewController.m
//  ToursCool
//
//  Created by tourscool on 3/1/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYSafeSearchViewController.h"

@interface LYSafeSearchViewController ()

@end

@implementation LYSafeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)willDealloc
{
    return YES;
}

- (void)dealloc
{
    LYNSLog(@"%@", NSStringFromClass([self class]));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
