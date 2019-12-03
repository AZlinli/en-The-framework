//
//  LYTourscoolBasicsNavigationViewController.m
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYTourscoolBasicsNavigationViewController.h"
#import "NSArray+LYUtil.h"
#import "UIView+LYUtil.h"
@interface LYTourscoolBasicsNavigationViewController ()

@end

@implementation LYTourscoolBasicsNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [self.navigationBar setViewBottomShadow];
    self.navigationBar.tintColor = [UIColor colorWithHexString:@"404040"];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *barBackgroundView = [[self.navigationBar subviews] objectAt:0];
    if (barBackgroundView) {
        UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];
        backgroundImageView.hidden = YES;
    }
    
    // 设置导航栏标题
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[LYTourscoolAPPStyleManager navigationTitleColor],NSFontAttributeName:[LYTourscoolAPPStyleManager navigationTitleFont]}];
    
    if (@available(iOS 11.0, *)) {
        // 不显示大标题
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    }
}

- (UIImageView *)findNavBarBottomImage:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findNavBarBottomImage:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - UIViewControllerRotation

- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.viewControllers.lastObject preferredStatusBarStyle];
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
