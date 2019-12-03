//
//  UIImage+LYUtil.h
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LYGradientType) {
    LYGradientTypeTopToBottom = 0,//从上到下
    LYGradientTypeLeftToRight = 1,//从左到右
};

typedef NS_ENUM(NSInteger, QMUIImageResizingMode) {
    QMUIImageResizingModeScaleToFill            = 0,    // 将图片缩放到给定的大小，不考虑宽高比例
    QMUIImageResizingModeScaleAspectFit         = 10,   // 默认的缩放方式，将图片保持宽高比例不变的情况下缩放到不超过给定的大小（但缩放后的大小不一定与给定大小相等），不会产生空白也不会产生裁剪
    QMUIImageResizingModeScaleAspectFill        = 20,   // 将图片保持宽高比例不变的情况下缩放到不超过给定的大小（但缩放后的大小不一定与给定大小相等），若有内容超出则会被裁剪。若裁剪则上下居中裁剪。
    QMUIImageResizingModeScaleAspectFillTop,            // 将图片保持宽高比例不变的情况下缩放到不超过给定的大小（但缩放后的大小不一定与给定大小相等），若有内容超出则会被裁剪。若裁剪则水平居中、垂直居上裁剪。
    QMUIImageResizingModeScaleAspectFillBottom          // 将图片保持宽高比例不变的情况下缩放到不超过给定的大小（但缩放后的大小不一定与给定大小相等），若有内容超出则会被裁剪。若裁剪则水平居中、垂直居下裁剪。
};


@interface UIImage (LYUtil)

/**
 灰度图片

 @param sourceImage image
 @return image
 */
+ (UIImage*)grayImage:(UIImage*)sourceImage;
- (UIImage *)imageTintedWithColorAndSize:(UIColor *)color size:(CGSize)size;
/**
 *  @brief 更改图片颜色
 *
 *  @param color 颜色值
 *
 *  @return 更改颜色之后的图片
 */
- (UIImage *)imageTintedWithColor:(UIColor *)color;

#pragma mark ----------- 遮罩

/**
 *  @brief 将自己图片加在一个遮罩上
 *
 *  @param maskImage 遮罩图
 *
 *  @return 加上遮罩后的图片
 */
- (UIImage *) maskWithImage:(const UIImage *) maskImage;

/**
 *  @brief 给自己加个遮罩色
 *
 *  @param color 遮罩色
 *
 *  @return 加上遮罩后的图片
 */
- (UIImage *) maskWithColor:(UIColor*) color;

#pragma mark - 设置圆角图片   圆形图片

/**
 *  @brief 设置圆形图片
 *
 *  @param diameter 圓直径
 *
 *  @return 圆形图片
 */
- (UIImage *)circularImageWithDiamter:(NSUInteger)diameter;

/**
 *  @brief 设置圆角图片
 *
 *  @param width        图片长宽
 *  @param cornerRadius 圆角角度
 *
 *  @return 圆角图片
 */
- (UIImage *)roundedRectImageWithWidth:(NSUInteger)width withCornerRadius:(CGFloat)cornerRadius;

- (UIImage *)roundedRectImageWithSize:(CGSize)size withCornerRadius:(CGFloat)cornerRadius;
#pragma mark -------------------------------

/**
 *  @brief 缩小图片大小
 *
 *  @param aRect 大小
 *
 *  @return 处理后的图片
 */
- (UIImage*)shrinkImage:(CGRect)aRect;

/**
 *  @brief 设置缩略图
 *
 *  @param aImage 源图片
 *
 *  @return 处理后的图片
 */
- (UIImage *)generatePhotoThumbnail:(UIImage *)aImage;

/**
 *  @brief //计算适合的大小。并保留其原始图片大小
 *
 *  @param aThisSize 当前图片大小
 *  @param aSize     容器框大小
 *
 *  @return 适合的大小
 */
+ (CGSize)fitSize:(CGSize)aThisSize inSize:(CGSize)aSize;

/**
 *  @brief 返回调整的缩略图
 *
 *  @param aImage    源图片
 *  @param aViewsize 容器大小
 *
 *  @return 调整的缩略图
 */
+ (UIImage *)image:(UIImage *)aImage fitInSize:(CGSize)aViewsize;


/**
 *  @brief 居中图片
 *
 *  @param aImage    源图片
 *  @param aViewsize 展示大小
 *
 *  @return 居中的缩略图
 */
+ (UIImage *)image:(UIImage *)aImage centerInSize:(CGSize)aViewsize;

+ (UIImage *)image:(UIImage *)aImage centerInSize:(CGSize)aViewsize backgroundColor:(UIColor*)bgColor;

/**
 *  @brief 填充图片
 *
 *  @param aImage    源图片
 *  @param aViewsize 需要填充的大小
 *
 *  @return 填充的缩略图
 */
+ (UIImage *)image:(UIImage *)aImage fillSize:(CGSize)aViewsize;

+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
/**
 *  @brief 让图片变小
 *
 *  @param aInImage 源图片
 *  @param aSize    略小的大小
 *
 *  @return 变小后的图片
 */
+ (UIImage *)rescaleToSize:(UIImage *)aInImage toSize:(CGSize)aSize;
+ (UIImage *)thumbnailImage:(UIImage *)image;
#pragma mark

- (UIImage *) croppedImage:(CGRect)cropRect;

+ (UIImage*)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float) i_width;

/**
 *  @brief 画出一个纯色的图片
 *
 *  @param color 图片颜色
 *  @param aSize 尺寸
 *
 *  @return 画出来的图片
 */
+ (UIImage*)imageTintedWithColor:(UIColor*)color  toSize:(CGSize)aSize;
- (UIImage*)imageChangeColor:(UIColor*)color;

/**
 *   @brief  纯色图片
 *
 *   @param color 颜色
 *
 *   @return 相应颜色的图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color;

/**
 *  @brief 图片保存为jpg,png文件
 *
 *  @param aImage    源图片
 *  @param aFilePath 存放位置
 *
 *  @return 是否保存成功
 */
+ (BOOL) writeToImage:(UIImage*)aImage toFileAtPath:(NSString *)aFilePath;
/**
 大图显示

 @param url 地址
 @param scale 比例
 @param pointSize 大小
 @return Image
 */
+ (UIImage *)downBigImageWihtUrl:(NSURL *)url scale:(CGFloat)scale pointSize:(CGSize)pointSize;

/**
 渐变色图片

 @param colors 颜色数字
 @param gradientType 方式
 @param imgSize 大小
 @return 图片
 */
- (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(LYGradientType)gradientType imgSize:(CGSize)imgSize;
- (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(LYGradientType)gradientType imgSize:(CGSize)imgSize cornerRadius:(CGFloat)cornerRadius;
/**
 二维码生成

 @param urlString 地址
 @param qrSize 大小
 @return 图片
 */
+ (UIImage *)ly_createQRCodeWithUrlString:(NSString*)urlString QRSize:(CGFloat)qrSize;

/**
 图片添加图片

 @param centerLogo 图片
 @param logoRect 位置
 @return 图片
 */
- (UIImage*)addCenterlogo:(UIImage*)centerLogo logoPosition:(CGRect)logoRect;

/**
 图片添加圆角边框

 @param borderW 大小
 @param color 颜色
 @param image 图片
 @param cornerRadius 圆角
 @return 图片
 */
+ (UIImage *)ly_imageWithBorderWidth:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)ly_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed;

+ (UIImage *)tailorImage:(UIImage *)aImage imageViewSize:(CGSize)imageViewSize;

- (UIImage *)ly_anyRoundedRectImageWithSize:(CGSize)size
                               cornerRadius:(CGFloat)cornerRadius
                                 rectCorner:(UIRectCorner)rectCorner;
/**
 指定裁剪图片区域

 @param rect 裁剪区域
 @return 图片
 */
- (UIImage *)ly_imageWithClippedRect:(CGRect)rect;

- (UIImage *)ly_imageWithColor:(UIColor *)color;

- (UIImage *)qmui_imageResizedInLimitedSize:(CGSize)size resizingMode:(QMUIImageResizingMode)resizingMode;

- (UIImage *)qmui_imageResizedInLimitedSize:(CGSize)size resizingMode:(QMUIImageResizingMode)resizingMode scale:(CGFloat)scale;
@end
