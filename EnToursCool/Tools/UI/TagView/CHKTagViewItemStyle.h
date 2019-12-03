//
//  CHKTagViewItemStyle.h
//  CHKTagView
//
//  Created by Hongkai Cui on 2017/11/23.
//  Copyright © 2017年 崔洪凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHKTagViewItemStyleType) {
    CHKTagViewItemStyleTypeDefault = 0,
    CHKTagViewItemStyleTypeDetailInfo
};

@interface CHKTagViewItemStyle : NSObject

@property (nonatomic,strong) UIColor *textColorNormal;//正常状态文字颜色
@property (nonatomic,strong) UIColor *textColorSelected;//选中状态文字颜色
@property (nonatomic,strong) UIColor *backgroundColorNormal;//正常状态背景色
@property (nonatomic,strong) UIColor *backgroundColorSelected;//选中状态背景色
@property (nonatomic,strong) UIColor *borderColorNormal;//边框颜色
@property (nonatomic,strong) UIColor *borderColorSelected;
@property (nonatomic,assign) CGFloat borderWidth;//边框宽
@property (nonatomic,assign) CGFloat cornerraduis;//圆角半径
@property (nonatomic,assign) CGFloat fontSize;//字体大小
@property (nonatomic,assign) CGFloat fontMarginHorizontal;//文字水平内间距
@property (nonatomic,assign) CGFloat fontMarginVertical;//文字垂直内间距
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,assign) CGFloat itemHeight;
@property (nonatomic, assign) UIEdgeInsets padding;

- (instancetype)initWithType:(CHKTagViewItemStyleType)type;

@end
