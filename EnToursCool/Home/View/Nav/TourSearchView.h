//
//  TourSearchView.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^JumpBlock)();
typedef void(^RightJumpBlock)();


NS_ASSUME_NONNULL_BEGIN

@interface TourSearchView : UIView

/// 创建一个类似首页搜索框
/// @param leftImgName 左边图片名字
/// @param placeString 占位文字
/// @param rightImgName 右边图片名
/// @param jumpBlock 点击跳转的回调
- (instancetype)initWithLeftImgName:(NSString *)leftImgName placeString:(NSString *)placeString rightImgName:(NSString *)rightImgName click:(JumpBlock)jumpBlock rightClick:(RightJumpBlock)rightBlock;

@end

NS_ASSUME_NONNULL_END
