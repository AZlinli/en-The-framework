//
//  NewsViewController.h
//  01-news
//
//  Created by Lai DongLing on 16/8/4.
//  Copyright © 2016年 Jin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDLNewsViewController : UIViewController

//是否需要取消下划线（默认不取消,默认NO,取消下划线YES）
@property (nonatomic, assign)  BOOL needCancleUnderLine;

//获取当前控制器
@property (strong, nonatomic) UIViewController *currentVc;

@end
