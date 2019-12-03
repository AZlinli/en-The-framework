//
//  GAActionSheet.h
//  GAIA供应
//
//  Created by  GAIA on 2017/9/25.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAActionSheet : UIView
/** conent view */
@property (strong , nonatomic) UIView *contentView;

/**
 创建alert视图
 
 @return UIView
 */
+ (instancetype)actionSheet;

/**
 准备初始化-
 */
- (void)prepare;

/**
 布局-设置frame
 */
- (void)layout;

/**
 显示
 */
- (void)show;

/**
 消失
 */
- (void)dismiss;

/**
 加在sheetView到某个View上面

 @param placeView 加在某个View上面
 */
- (void)showViewAddTo:(UIView *)placeView;
   

@end
