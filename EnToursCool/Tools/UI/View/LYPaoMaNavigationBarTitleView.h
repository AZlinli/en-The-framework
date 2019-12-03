//
//  LYPaoMaNavigationBarTitleView.h
//  SouthEastProject
//
//  Created by luoyong on 2018/5/4.
//  Copyright © 2018年 Saber. All rights reserved.
//
/**
 * 跑马灯
 * veriosn 1.0.0
 * xcode   9.2
 */
#import "LYNavigationBarTitleView.h"

@interface LYPaoMaNavigationBarTitleView : LYNavigationBarTitleView
/**
 初始化

 @param frame frame
 @param title title
 @return LYPaoMaNavigationBarTitleView
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;
/**
 开始
 */
- (void)start;
/**
 停止
 */
- (void)stop;
@end
