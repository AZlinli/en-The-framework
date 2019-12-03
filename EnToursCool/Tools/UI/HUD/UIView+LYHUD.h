//
//  UIView+LYHUD.h
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LYHUDType){
    /** 成功 */
    LYHUDSuccessType,
    /** 失败 */
    LYHUDErrorType,
    /** 警告 */
    LYHUDWarningType
};
NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYHUD)
/**
 显示LoadingHUD

 @param showView 显示View
 @param msg 提示信息
 */
+ (void)showLoadingHUDWithView:(UIView *)showView msg:(NSString * _Nullable)msg;
+ (void)showLoadingHUDWithView:(UIView *)showView msg:(NSString * _Nullable)msg userInteractionEnabled:(BOOL)userInteractionEnabled;
/**
 底部显示提示信息HUD

 @param showView 显示View
 @param msg 信息
 */
+ (void)showMSGBottomHUDWithView:(UIView *)showView msg:(NSString * _Nullable)msg;
/**
 中部显示提示信息HUD

 @param showView 显示View
 @param msg 信息
 */
+ (void)showMSGCenterHUDWithView:(UIView *)showView msg:(NSString * _Nullable)msg;
/**
 显示图片HUD

 @param showView 显示View
 @param msg 信息
 @param type 显示类型
 */
+ (void)showHUDTypeWithView:(UIView *)showView msg:(NSString * _Nullable)msg type:(LYHUDType)type;
/**
 隐藏HUD

 @param showView 显示的View
 */
+ (void)dismissHUDWithView:(UIView *)showView;
+ (BOOL)viewHasHUDWithView:(UIView *)showView;
@end

NS_ASSUME_NONNULL_END
