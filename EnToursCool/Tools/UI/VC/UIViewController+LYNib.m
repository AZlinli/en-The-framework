//
//  UIViewController+LYNib.m
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import "UIViewController+LYNib.h"

@implementation UIViewController (LYNib)


+ (instancetype)loadFromNib{
    return [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

+ (instancetype)loadFromStoryBoard:(NSString *)storyBoard;{
    UIViewController * board = [[UIStoryboard storyboardWithName:storyBoard bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    return board;
}

- (BOOL)navigationControllerHasWithVCName:(NSString *)vcName
{
    if (self.navigationController) {
        NSArray * controllers = self.navigationController.viewControllers;
        NSArray * result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(vcName)];
        }]];
        if (result.count) {
            return YES;
        }
    }
    return NO;
}

- (UIViewController *)navigationControllerHasVCName:(NSString *)vcName
{
    if (self.navigationController) {
        NSArray * controllers = self.navigationController.viewControllers;
        NSArray * result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(vcName)];
        }]];
        if (result.count) {
            return result.firstObject;
        }
    }
    return nil;
}

- (void)exchangeWithVCName:(NSString *)vcName swappedVCName:(NSString *)swappedVCName
{
    if ([self navigationControllerHasWithVCName:vcName] && [self navigationControllerHasWithVCName:swappedVCName]) {
        // setViewControllers
        NSArray * controllers = self.navigationController.viewControllers;
        NSInteger VCIndex = [controllers indexOfObject:[self navigationControllerHasVCName:vcName]];
        NSInteger swappedVCIndex = [controllers indexOfObject:[self navigationControllerHasVCName:swappedVCName]];
        if (swappedVCIndex >= 0 && VCIndex >= 0) {
            NSMutableArray * controllersMutableArray = [NSMutableArray arrayWithArray:controllers];
            [controllersMutableArray exchangeObjectAtIndex:VCIndex withObjectAtIndex:swappedVCIndex];
            [self.navigationController setViewControllers:[controllersMutableArray copy]];
        }
    }
}

- (void)backToViewControllerWithVCName:(NSString *)vcName animated:(BOOL)animated
{
    if (self.navigationController) {
        NSArray * controllers = self.navigationController.viewControllers;
        NSArray * result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(vcName)];
        }]];
        if (result.count) {
            [self.navigationController popToViewController:result[0] animated:animated];
        }
    }
}

+ (UIViewController *)findCurrentShowingViewController
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}

+ (BOOL)findViewControllerWithVCName:(NSString *)vcName
{
    UIViewController * currentVC = [UIViewController findCurrentShowingViewController];
    __block BOOL tag = NO;
    if ([currentVC isKindOfClass:NSClassFromString(vcName)]) {
        tag = YES;
        if (tag) {
            return tag;
        }
    }
    if (currentVC.navigationController.viewControllers.count) {
        [currentVC.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(vcName)]) {
                tag = YES;
                *stop = YES;
            }
        }];
    }
    if (tag) {
        return tag;
    }
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabBarController = (UITabBarController *)vc;
        vc = tabBarController.selectedViewController;
    }
    
    tag = [UIViewController ly_findVCInNavigationController:vc vcName:vcName];
    if (tag) {
        return tag;
    }
    
    if ([vc presentedViewController]) {
        vc = [vc presentedViewController];
    }
    
    return [UIViewController ly_findVCInNavigationController:vc vcName:vcName];
}

+ (BOOL)ly_findVCInNavigationController:(UIViewController *)vc vcName:(NSString *)vcName
{
    __block BOOL tag = NO;
    if ([vc isKindOfClass:[UINavigationController class]]){
        UINavigationController *nextRootVC = (UINavigationController *)vc;
        [nextRootVC.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(vcName)]) {
                tag = YES;
                *stop = YES;
            }
        }];
        return tag;
    }
    return tag;
}

+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc
{
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) {
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else {
        currentShowingVC = vc;
    }
    return currentShowingVC;
}

@end
@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
}

@end
