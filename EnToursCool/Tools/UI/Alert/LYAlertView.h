//
//  LYAlertViewController.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LYAlertViewDelegate <NSObject>

@required

-(void)clickConfirmButton;

@end

@interface LYAlertView : UIView
@property (nonatomic, weak) id<LYAlertViewDelegate> delegate;

-(void)alertViewControllerWithMessage:(NSString *)message title:(NSString*)title leftButtonTitle:(NSString*)leftButtonTitle rightButtonTitle:(NSString*)rightButtonTitle;
@end

NS_ASSUME_NONNULL_END
