//
//  UITextField+LYUtil.m
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import "UITextField+LYUtil.h"
#import "UIView+Helper.h"
#import <objc/runtime.h>
static const char LeftInsetKey,LeftImageKey,PlaceholderColorKey , RightInsetKey, RightImageKet;
@implementation UITextField (LYUtil)
@dynamic leftInset,leftImage,rightInset,rightImage;


- (void)setRightInset:(CGFloat)rightInset{
    objc_setAssociatedObject(self, &RightInsetKey, @(rightInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIView *rightView = self.rightView;
    if (rightView==nil) {
        rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightInset, 1)];
        rightView.backgroundColor = [UIColor clearColor];
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = rightView;
    }
}

- (CGFloat)rightInset{
    NSNumber *rightInset = objc_getAssociatedObject(self, &RightInsetKey);
    if (![rightInset boolValue]) {
        return 0.f;
    }
    return rightInset.floatValue;
}


- (void)setRightImage:(UIImage *)rightImage{
    objc_setAssociatedObject(self, &RightImageKet, rightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIImageView *image = [[UIImageView alloc] initWithImage:rightImage];
    image.contentMode = UIViewContentModeRight;
    if (self.rightInset) {
        image.width = self.rightInset;
    }else{
        image.width = rightImage.size.width*3/2;
    }
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = image;
}

- (UIImage *)rightImage{
    return objc_getAssociatedObject(self, &RightImageKet);
}

- (void)setLeftInset:(CGFloat)leftInset{
    objc_setAssociatedObject(self, &LeftInsetKey, @(leftInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIView *leftView = self.leftView;
    if (leftView==nil) {
        leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftInset, 1)];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = leftView;
    }
}

- (CGFloat)leftInset{
    NSNumber *leftInset = objc_getAssociatedObject(self, &LeftInsetKey);
    if (![leftInset boolValue]) {
        return 0.f;
    }
    return leftInset.floatValue;
}

- (void)setLeftImage:(UIImage *)leftImage{
    objc_setAssociatedObject(self, &LeftImageKey, leftImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIImageView *image = [[UIImageView alloc] initWithImage:leftImage];
    image.contentMode = UIViewContentModeRight;
    if (self.leftInset) {
        image.width = self.leftInset;
    }else{
        image.width = leftImage.size.width*3/2;
    }
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = image;
}

- (UIImage *)leftImage{
    return objc_getAssociatedObject(self, &LeftImageKey);
}
//KVC iOS13崩溃
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
//    objc_setAssociatedObject(self, &PlaceholderColorKey, placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor{
    return objc_getAssociatedObject(self,&PlaceholderColorKey);
}

- (void)setPlaceholderWithColor:(UIColor *)color conent:(NSString*)content font:(UIFont*)font{
    if (content.length <= 0) {
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (font != nil) {
        [dic setValue:font forKey:NSFontAttributeName];
    }
    if (color != nil) {
        [dic setValue:color forKey:NSForegroundColorAttributeName];
    }
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:content attributes:dic];
}

@end
