//
//  UIView+LYNib.h
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYNib)
+ (instancetype)loadFromNib;
/*
 *  @brief View
 *  @param aName xib名字
 *  @return View
 */
+ (instancetype)loadFromNibWithName:(NSString*)aName;
/*
 *  @brief View
 *  @param frame
 *  @return View
 */
+ (instancetype)loadFromNibWithFrame:(CGRect)frame;
+ (UINib *)nib;
@end
