//
//  UIView+LYHUD.m
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "UIView+LYHUD.h"
#import "NSString+LYTool.h"
#import "LYLoadingView.h"
#import "LYCustomeMBProgressHUD.h"
static NSTimeInterval HUDShowTime = 2.0;
@implementation UIView (LYHUD)

+ (MBProgressHUD *)obtainHUDWithView:(UIView *)showView
{
    MBProgressHUD *hud = [LYCustomeMBProgressHUD showHUDAddedTo:showView animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    hud.contentColor = [UIColor colorWithHexString:@"f9f9f9"];
    hud.label.font = [UIView ly_hudFont];
    hud.label.numberOfLines = 2;
    return hud;
}

+ (void)showHUDTypeWithView:(UIView *)showView msg:(NSString *)msg type:(LYHUDType)type
{
    if (!showView) {
        return;
    }
    MBProgressHUD *hud = [UIView obtainHUDWithView:showView];
    hud.mode = MBProgressHUDModeCustomView;
    NSString * imageName = @"";
    switch (type) {
        case LYHUDSuccessType:
            imageName = @"";
            break;
        case LYHUDErrorType:
            imageName = @"";
            break;
        case LYHUDWarningType:
            imageName = @"";
            break;
    }
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.label.text = msg;
    [hud hideAnimated:YES afterDelay:HUDShowTime];
}

+ (void)showLoadingHUDWithView:(UIView *)showView msg:(NSString *)msg userInteractionEnabled:(BOOL)userInteractionEnabled
{
    if (!showView) {
        return;
    }
    if ([UIView viewHasHUDWithView:showView]) {
        return;
    }
    MBProgressHUD *hud = [UIView obtainHUDWithView:showView];
    hud.userInteractionEnabled = userInteractionEnabled;
    //    hud.mode = MBProgressHUDModeIndeterminate;
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    LYLoadingView * view = [[LYLoadingView alloc] init];
    hud.customView = view;
    if (msg) {
        hud.label.text = msg;
    }
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showLoadingHUDWithView:(UIView *)showView msg:(NSString *)msg
{
    [UIView showLoadingHUDWithView:showView msg:msg userInteractionEnabled:YES];
}

+ (BOOL)viewHasHUDWithView:(UIView *)showView
{
    for (UIView * view in showView.subviews) {
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            return YES;
        }
    }
    return NO;
}

+ (void)showMSGCenterHUDWithView:(UIView *)showView msg:(NSString *)msg
{
    if (!showView) {
        return;
    }
    if (!msg.length) {
        return ;
    }
    if ([msg isEmpty]) {
        return;
    }
    MBProgressHUD *hud = [UIView obtainHUDWithView:showView];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    [hud hideAnimated:YES afterDelay:HUDShowTime];
}

+ (void)showMSGBottomHUDWithView:(UIView *)showView msg:(NSString *)msg
{
    if (!showView) {
        return;
    }
    if ([msg isEmpty]) {
        return;
    }
    MBProgressHUD *hud = [UIView obtainHUDWithView:showView];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:HUDShowTime];
}

+ (void)dismissHUDWithView:(UIView *)showView
{
    if (!showView) {
        return;
    }
    [MBProgressHUD hideHUDForView:showView animated:YES];
}

+ (UIFont *)ly_hudFont
{
//    return [UIFont obtainPingFontWithStyle:LYPingFangSCRegular size:16.f];
    return [UIFont fontWithName:@"Arial" size: 14];
}

@end
