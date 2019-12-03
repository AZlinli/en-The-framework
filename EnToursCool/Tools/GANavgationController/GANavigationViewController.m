//
//  GANavigationViewController.m
//  GAIA供应
//
//  Created by  GAIA on 2017/8/22.
//  Copyright © 2017年 laidongling. All rights reserved.


#import "GANavigationViewController.h"


//1:开启打印当前控制器名称；0：关闭
#define PrintViewControllerName (1)

@interface GANavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation GANavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    [self setNavigationController];
}


- (void)setNavigationController
{
    
    self.navigationBar.translucent = NO;
     //文字颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[LYTourscoolAPPStyleManager ly_484848Color] , NSFontAttributeName:[LYTourscoolAPPStyleManager ly_ArialRegular_17]}];
     //去掉线条
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor
{
    self.navigationBar.backgroundColor = barBackgroundColor;
}

/**
 *  设置返回按钮 箭头
 */
- (UIBarButtonItem*)createBackButton
{
    //返回item
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(tapToReturn)];
    [backItem setImage:[UIImage imageNamed:@"back_button"]];
    //箭头图片外边距
//    [backItem setImageInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    return backItem;
}

- (void)tapToReturn
{
    [self popViewControllerAnimated:YES];
}

//重写导航控制器的pushViewController:animated: 方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!viewController)
    {
        LYNSLog(@"即将跳转的视图控制器为空!");
        return;
    }
    
#if PrintViewControllerName
    
    LYNSLog(@"当前视图控制器名称: %@", NSStringFromClass(viewController.class));
    
#endif
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES)
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //在push下一个视图控制器之前，隐藏tabBar
    viewController.hidesBottomBarWhenPushed = YES;
    
    //如果左边没有BarButtonItem或者导航控制器的导航栈中的视图控制器大于1个才会出现返回按钮
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] >= 1)
    {
        viewController.navigationItem.leftBarButtonItem = [self createBackButton];
        
    }
    //调用超类方法push
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES)
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
}


@end
