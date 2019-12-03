//
//  LYTourscoolBasicsTabBarController.m
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYTourscoolBasicsTabBarController.h"
#import "UIView+LYUtil.h"

@interface LYTourscoolBasicsTabBarController ()

@end

@implementation LYTourscoolBasicsTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 13, *)) {
        UITabBarAppearance * appearance = [self.tabBar.standardAppearance copy];
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.backgroundImage = [UIImage new];
        appearance.shadowImage = [UIImage new];
        appearance.shadowColor = [UIColor clearColor];
        self.tabBar.standardAppearance = appearance;
    } else {
        self.tabBar.backgroundImage = [UIImage new];
        self.tabBar.shadowImage = [UIImage new];
    }
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - UIViewControllerRotation

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.selectedViewController preferredStatusBarStyle];
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
