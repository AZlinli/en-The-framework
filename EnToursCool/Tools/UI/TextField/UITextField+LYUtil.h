//
//  UITextField+LYUtil.h
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LYUtil)
@property (nonatomic,assign) IBInspectable CGFloat leftInset;
@property (nonatomic,strong) IBInspectable UIImage *leftImage;

@property (nonatomic,assign) IBInspectable CGFloat rightInset;
@property (nonatomic,strong) IBInspectable UIImage *rightImage;

@property (nonatomic,strong) IBInspectable UIColor *placeholderColor;

//iOS KVC崩溃 处理方式
- (void)setPlaceholderWithColor:(UIColor *)color conent:(NSString*)content font:(UIFont*)font;
@end
