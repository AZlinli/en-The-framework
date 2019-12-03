//
//  TourStepper.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TourStepper : UIView
@property (assign , nonatomic) IBInspectable double minimumValue; //最小值
@property (assign , nonatomic) IBInspectable double maximumValue; //最大值
@property (assign , nonatomic) IBInspectable double value;        //当前值
@property (assign , nonatomic) IBInspectable double stepValue;    //步进值
@property (strong , nonatomic) IBInspectable UIColor *tintColor;  //颜色
@property(nonatomic,assign) BOOL isUserInterRect;                 //labelTextField是否允许交互

/**
 *  初始化方法
 */
+ (instancetype)stepper;

/**
 *  带事件响应的初始化方法
 */
+ (instancetype)stepperWithValueChanged:(void(^)(double value))valueChanged;

/**
 *  事件
 */
- (void)stepValueChanged:(void(^)(double value))valueChanged;

@end

NS_ASSUME_NONNULL_END
