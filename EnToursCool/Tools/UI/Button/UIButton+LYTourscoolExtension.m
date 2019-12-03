//
//  UIButton+LYTourscoolExtension.m
//  LYTestPJ
//
//  Created by tourscool on 10/22/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "UIButton+LYTourscoolExtension.h"
#import <objc/runtime.h>
#import "UIImage+LYUtil.h"

static char rightImageKey;
static char topImageKey;
static char lineSpacingKey;
static char backgroundColorAtNormalKey;
static char txtColorKey;
static char buttonEdgeInsetsstyleKey;
static char spaceKey;

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (LYTourscoolExtension)
@dynamic enlargeEdge;
- (void)setImagePosition:(LYImagePosition)postion spacing:(CGFloat)spacing
{
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width <= CGRectGetWidth(self.titleLabel.frame) ? [self.titleLabel.text sizeWithFont:self.titleLabel.font].width : CGRectGetWidth(self.titleLabel.frame);
    //    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width <= (CGRectGetWidth(self.frame)-spacing-imageWidth) ? [self.titleLabel.text sizeWithFont:self.titleLabel.font].width : CGRectGetWidth(self.titleLabel.frame);
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (postion) {
        case LYImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case LYImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case LYImagePositionTop:
            [self verticalImageAndTitle:spacing];
            break;
            
        case LYImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
    
}


- (void)verticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font,
                                 NSParagraphStyleAttributeName: paragraph};
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:attributes];
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

- (void)setTxtColor:(BOOL)txtColor
{
    objc_setAssociatedObject(self, &txtColorKey, @(txtColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)txtColor
{
    NSNumber *txtColor = objc_getAssociatedObject(self, &txtColorKey);
    return txtColor.boolValue;
}

- (UIImage *)rightImage
{
    return objc_getAssociatedObject(self, &rightImageKey);
}

- (void)setRightImage:(UIImage *)rightImage
{
    NSString *title = [self titleForState:UIControlStateNormal];
    title = [NSString stringWithFormat:@"%@  ", title ?: @""];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:title];
    
    UIColor *normalColor = [self titleColorForState:UIControlStateNormal];
    UIColor *selectedColor = [self titleColorForState:UIControlStateSelected];
    UIColor *heighColor = [self titleColorForState:UIControlStateHighlighted];
    
    NSMutableAttributedString *normalString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [normalString addAttribute:NSForegroundColorAttributeName
                         value:normalColor
                         range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [rightImage imageTintedWithColorAndSize:normalColor size:CGSizeMake(20, 20)];
    
    NSAttributedString *attributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [normalString appendAttributedString:attributeStr1];
    
    [self setAttributedTitle:normalString forState:UIControlStateNormal];
    
    NSMutableAttributedString *selectedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [selectedString addAttribute:NSForegroundColorAttributeName
                           value:[self titleColorForState:UIControlStateSelected]
                           range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachmentSelected = [[NSTextAttachment alloc] init];
    textAttachmentSelected.image = [rightImage imageTintedWithColorAndSize:selectedColor size:CGSizeMake(20, 20)];
    NSAttributedString *selectedAttributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachmentSelected];
    [selectedString appendAttributedString:selectedAttributeStr1];
    
    [self setAttributedTitle:selectedString forState:UIControlStateSelected];
    
    NSMutableAttributedString *heightString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [heightString addAttribute:NSForegroundColorAttributeName
                         value:heighColor
                         range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachmentHeigh = [[NSTextAttachment alloc] init];
    textAttachmentHeigh.image = [rightImage imageTintedWithColorAndSize:heighColor size:CGSizeMake(20, 20)];
    NSAttributedString *selectedAttributeStr2 = [NSAttributedString attributedStringWithAttachment:textAttachmentHeigh];
    [heightString appendAttributedString:selectedAttributeStr2];
    
    [self setAttributedTitle:heightString forState:UIControlStateHighlighted];
    
    objc_setAssociatedObject(self, &rightImageKey, rightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)topImage
{
    return objc_getAssociatedObject(self, &topImageKey);
}

- (void)setTopImage:(UIImage *)topImage
{
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSString *title = [self titleForState:UIControlStateNormal];
    title = [@"\n" stringByAppendingString:title];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = self.lineSpacing;
    
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentCenter:
            style.alignment = NSTextAlignmentCenter;
            break;
        case UIControlContentHorizontalAlignmentLeft:
            style.alignment = NSTextAlignmentLeft;
            break;
        case UIControlContentHorizontalAlignmentRight:
            style.alignment = NSTextAlignmentRight;
            break;
        default:
            style.alignment = NSTextAlignmentCenter;
            break;
    }
    
    UIColor *normalColor = [self titleColorForState:UIControlStateNormal];
    UIColor *selectedColor = [self titleColorForState:UIControlStateSelected];
    UIColor *heighlightColor = [self titleColorForState:UIControlStateHighlighted];
    
    //正常button
    NSMutableAttributedString *normalString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [normalString addAttribute:NSForegroundColorAttributeName
                         value:normalColor
                         range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = self.txtColor ? [topImage imageTintedWithColor:normalColor] : topImage;
    NSAttributedString *attributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    [normalString insertAttributedString:attributeStr1 atIndex:0];
    [normalString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, normalString.length)];
    
    [self setAttributedTitle:normalString forState:UIControlStateNormal];
    
    //选中的button
    NSMutableAttributedString *selectedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [selectedString addAttribute:NSForegroundColorAttributeName
                           value:[self titleColorForState:UIControlStateSelected]
                           range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachmentSelected = [[NSTextAttachment alloc] init];
    textAttachmentSelected.image = self.txtColor ? [topImage imageTintedWithColor:selectedColor] : topImage;
    NSAttributedString *selectedAttributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachmentSelected];
    [selectedString insertAttributedString:selectedAttributeStr1 atIndex:0];
    [selectedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, normalString.length)];
    
    [self setAttributedTitle:selectedString forState:UIControlStateSelected];
    
    //高亮的button
    NSMutableAttributedString *heighlightString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [heighlightString addAttribute:NSForegroundColorAttributeName
                             value:[self titleColorForState:UIControlStateHighlighted]
                             range:NSMakeRange(0, title.length)];
    
    NSTextAttachment *textAttachmentHeighlight = [[NSTextAttachment alloc] init];
    textAttachmentHeighlight.image = self.txtColor ? [topImage imageTintedWithColor:heighlightColor] : topImage;
    NSAttributedString *heighlightAttributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachmentHeighlight];
    [heighlightString insertAttributedString:heighlightAttributeStr1 atIndex:0];
    [heighlightString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, normalString.length)];
    
    [self setAttributedTitle:heighlightString forState:UIControlStateHighlighted];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    objc_setAssociatedObject(self, &topImageKey, topImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBackgroundColorAtNormal:(UIColor *)backgroundColorAtNormal
{
    UIImage *imgColor = [UIImage imageWithColor:backgroundColorAtNormal];
    [self setBackgroundImage:imgColor forState:UIControlStateNormal];
    objc_setAssociatedObject(self, &backgroundColorAtNormalKey, backgroundColorAtNormal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)backgroundColorAtNormal
{
    return objc_getAssociatedObject(self, &backgroundColorAtNormalKey);
}

#pragma mark - 样式
- (CGFloat)lineSpacing
{
    return [objc_getAssociatedObject(self, &lineSpacingKey) floatValue];
}

- (void)setLineSpacing:(CGFloat)lineSpacing
{
    objc_setAssociatedObject(self, &lineSpacingKey, @(lineSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.topImage = self.topImage;
}

- (void)setSpace:(CGFloat)space
{
    objc_setAssociatedObject(self, &spaceKey, @(space), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)space
{
    return [objc_getAssociatedObject(self, &spaceKey) floatValue];
}

- (void)setButtonEdgeInsetsstyle:(NSInteger)buttonEdgeInsetsstyle
{
    objc_setAssociatedObject(self, &buttonEdgeInsetsstyleKey, @(buttonEdgeInsetsstyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSInteger)buttonEdgeInsetsstyle
{
    return [objc_getAssociatedObject(self, &buttonEdgeInsetsstyleKey) integerValue];
}

/**
 *  @brief 扩大整个按钮的大小
 *
 *  @param aEdge 需要扩大的大小
 */
- (void)setEnlargeEdge:(CGFloat)aEdge
{
    [self setEnlargeEdgeWithTop:aEdge right:aEdge bottom:aEdge left:aEdge];
}

/**
 *  @brief 按需扩大按钮大小
 *
 *  @param topEdge    上边距
 *  @param rightEdge  右边距
 *  @param bottomEdge 下边距
 *  @param leftEdge   左边距
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)topEdge
                        right:(CGFloat)rightEdge
                       bottom:(CGFloat)bottomEdge
                         left:(CGFloat)leftEdge
{
    
    objc_setAssociatedObject(self, &topNameKey, @(topEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, @(rightEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, @(bottomEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, @(leftEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  @brief 扩大的按钮点击区域
 *
 *  @return 点击区域
 */
- (CGRect)enlargedRect
{
    
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point);
}

- (void)buttonTitleCenter
{
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets titleEdge;
    // 设置按钮内边距
    imgViewSize = self.imageView.bounds.size;
    titleSize = self.titleLabel.bounds.size;
    btnSize = self.bounds.size;
    // {top, left, bottom, right}
    titleEdge = UIEdgeInsetsMake(0, - imgViewSize.width, 0.0, 0.0);
    [self setTitleEdgeInsets:titleEdge];
}

@end
