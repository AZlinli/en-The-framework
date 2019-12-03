//
//  UIImage+LYUtil.m
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import "UIImage+LYUtil.h"
#import "LYImageCommon.h"

@implementation UIImage (LYUtil)

+ (UIImage *)downBigImageWihtUrl:(NSURL *)url scale:(CGFloat)scale pointSize:(CGSize)pointSize
{
    CFDictionaryRef sourceOpt = (__bridge CFDictionaryRef)@{(id)kCGImageSourceShouldCache : @NO};
    CFURLRef urlRef = (__bridge CFURLRef)url;
    CGImageSourceRef source = CGImageSourceCreateWithURL(urlRef, sourceOpt);
    
    CGFloat maxDimension = fmax(pointSize.width, pointSize.height) * scale;
    CFDictionaryRef downsampleOpt = (__bridge CFDictionaryRef)@{(id)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                (id)kCGImageSourceShouldCacheImmediately : @YES ,
                                                                (id)kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                                (id)kCGImageSourceThumbnailMaxPixelSize : @(maxDimension)};
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOpt);
    
    CFRelease(source);
    
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

+ (UIImage*)grayImage:(UIImage*)sourceImage {
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil, width, height,8,0, colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0,0, width, height), sourceImage.CGImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(context);
    CGImageRelease(imageRef);
    return grayImage;
}
#pragma mark - 更改图片颜色

- (UIImage*)imageChangeColor:(UIColor*)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)imageTintedWithColor:(UIColor *)color{
    // This method is designed for use with template images, i.e. solid-coloured mask-like images.
    return [self imageTintedWithColor:color fraction:0.0]; // default to a fully tinted mask of the image.
}

- (UIImage *)imageTintedWithColorAndSize:(UIColor *)color size:(CGSize)size
{
    if (color) {
        // Construct new image the same size as this one.
        UIImage *image;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
            UIGraphicsBeginImageContextWithOptions([self size], NO, [UIScreen mainScreen].scale); // 0.f for scale means "scale for device's main screen".
        } else {
            UIGraphicsBeginImageContext([self size]);
        }
#else
        UIGraphicsBeginImageContext([self size]);
#endif
        CGRect rect = CGRectZero;
        rect.size = size;
        
        // Composite tint color at its own opacity.
        [color set];
        UIRectFill(rect);
        
        // Mask tint color-swatch to this image's opaque mask.
        // We want behaviour like NSCompositeDestinationIn on Mac OS X.
//        [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
        
        // Finally, composite this image over the tinted mask at desired opacity.
        
            // We want behaviour like NSCompositeSourceOver on Mac OS X.
            [self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:0.0];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    return self;
}

- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction{
    if (color) {
        // Construct new image the same size as this one.
        UIImage *image;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
            UIGraphicsBeginImageContextWithOptions([self size], NO, [UIScreen mainScreen].scale); // 0.f for scale means "scale for device's main screen".
        } else {
            UIGraphicsBeginImageContext([self size]);
        }
#else
        UIGraphicsBeginImageContext([self size]);
#endif
        CGRect rect = CGRectZero;
        rect.size = [self size];
        
        // Composite tint color at its own opacity.
        [color set];
        UIRectFill(rect);
        
        // Mask tint color-swatch to this image's opaque mask.
        // We want behaviour like NSCompositeDestinationIn on Mac OS X.
        [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
        
        // Finally, composite this image over the tinted mask at desired opacity.
        if (fraction > 0.0) {
            // We want behaviour like NSCompositeSourceOver on Mac OS X.
            [self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
        }
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    return self;
}


#pragma mark -----------
- (UIImage *)maskWithImage:(const UIImage *) maskImage{
    float scaleFactor = [[UIScreen mainScreen] scale];
    const CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    const CGImageRef maskImageRef = maskImage.CGImage;
    
    const CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width* scaleFactor, maskImage.size.height* scaleFactor, 8, maskImage.size.width * scaleFactor * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextScaleCTM(mainViewContentContext, scaleFactor, scaleFactor);
    CGContextSetInterpolationQuality(mainViewContentContext, kCGInterpolationHigh);
    CGColorSpaceRelease(colorSpace);
    
    if (! mainViewContentContext){
        return nil;
    }
    
    CGFloat ratio = maskImage.size.width / self.size.width;
    
    if (ratio * self.size.height < maskImage.size.height){
        ratio = maskImage.size.height / self.size.height;
    }
    
    const CGRect maskRect  = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    
    const CGRect imageRect  = CGRectMake(-((self.size.width * ratio) - maskImage.size.width) / 2,
                                         -((self.size.height * ratio) - maskImage.size.height) / 2,
                                         self.size.width * ratio,
                                         self.size.height * ratio);
    
    CGContextClipToMask(mainViewContentContext, maskRect, maskImageRef);
    CGContextDrawImage(mainViewContentContext, imageRect, self.CGImage);
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    return theImage;
    //    const CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //    const CGImageRef maskImageRef = maskImage.CGImage;
    //
    //    const CGContextRef mainViewContentContext = CGBitmapContextCreate(NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    ////    const CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    //    CGColorSpaceRelease(colorSpace);
    //
    //    if (! mainViewContentContext)
    //    {
    //        return nil;
    //    }
    //
    //    CGFloat ratio = maskImage.size.width / self.size.width;
    //    if (ratio * self.size.height < maskImage.size.height)
    //    {
    //        ratio = maskImage.size.height / self.size.height;
    //    }
    //
    //    const CGRect maskRect  = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    //
    //    const CGRect imageRect = CGRectMake(-((self.size.width * ratio) - maskImage.size.width) / 2,
    //                                         -((self.size.height * ratio) - maskImage.size.height) / 2,
    //                                         self.size.width * ratio,
    //                                         self.size.height * ratio);
    //
    //    CGContextClipToMask(mainViewContentContext, maskRect, maskImageRef);
    //    CGContextDrawImage(mainViewContentContext, imageRect, self.CGImage);
    //
    //    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    //    CGContextRelease(mainViewContentContext);
    //
    //    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    //
    //    CGImageRelease(newImage);
    //
    //    return theImage;
    
}

/*
 maskWithColor
 takes a (grayscale) image and 'tints' it with the supplied color.
 */
- (UIImage *) maskWithColor:(UIColor *) color{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    //    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, self.CGImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *coloredImage = [UIImage imageWithCGImage:cImage];
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cImage);
    
    return coloredImage;
    
}

#pragma mark - 设置圆角图片   圆形图片

- (UIImage *)circularImageWithDiamter:(NSUInteger)diameter{
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    [imgPath addClip];
    [self drawInRect:frame];
//    [self drawAtPoint:CGPointMake(frame.size.width, frame.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)roundedRectImageWithWidth:(NSUInteger)width withCornerRadius:(CGFloat)cornerRadius{
    CGSize size = CGSizeMake(width, width);
    return [self roundedRectImageWithSize:size withCornerRadius:cornerRadius];
}

- (UIImage *)roundedRectImageWithSize:(CGSize)size withCornerRadius:(CGFloat)cornerRadius{
    CGRect frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:cornerRadius];
    [imgPath addClip];
    [self drawInRect:frame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ly_anyRoundedRectImageWithSize:(CGSize)size
                               cornerRadius:(CGFloat)cornerRadius
                                 rectCorner:(UIRectCorner)rectCorner
{
    CGRect frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath * imgPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                   byRoundingCorners:rectCorner
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    [imgPath addClip];
    [self drawInRect:frame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -------------------------------


- (UIImage*)shrinkImage:(CGRect)aRect {
    UIGraphicsBeginImageContextWithOptions(aRect.size, NO, [UIScreen mainScreen].scale);
    
    [self drawInRect:aRect];
    
    UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return shrinkedImage;
}

- (UIImage *)generatePhotoThumbnail:(UIImage *)aImage {
    // Create a thumbnail version of the image for the event object.
    CGSize size = aImage.size;
    CGSize croppedSize;
    //	CGFloat ratio = 64.0;
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    
    // check the size of the image, we want to make it
    // a square with sides the size of the smallest dimension
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    
    // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([aImage CGImage], clippedRect);
    // Done cropping
    
    // Resize the image
    CGRect rect = CGRectMake(0.0, 0.0, croppedSize.width, croppedSize.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    // Done Resizing
    
    return thumbnail;
}


+ (CGSize)fitSize:(CGSize)aThisSize inSize:(CGSize)aSize{
    CGFloat scale;
    CGSize newsize = aThisSize;
    
    if (newsize.height && (newsize.height > aSize.height)){
        scale = aSize.height / newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    
    if (newsize.width && (newsize.width >= aSize.width)){
        scale = aSize.width / newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    
    return newsize;
}

+ (CGSize)fitSize:(CGSize)aThisSize size:(CGSize)aSize
{
    CGFloat scale;
    CGSize newsize = aThisSize;
    
    if (newsize.height && (newsize.height > aSize.height)){
        scale = aSize.height / newsize.height;
        newsize.height *= scale;
    }
    
    if (newsize.width && (newsize.width > aSize.width)){
        scale = aSize.width / newsize.width;
        newsize.width *= scale;
    }
    
    return newsize;
}

//返回调整的缩略图
+ (UIImage *)image:(UIImage *)aImage fitInSize:(CGSize)aViewsize{
    // calculate the fitted size
    CGSize size = [self fitSize:aImage.size size:aViewsize];
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    float dwidth = (aViewsize.width - size.width) / 2.0f;
    float dheight = (aViewsize.height - size.height) / 2.0f;
    
    CGRect rect = CGRectMake(dwidth, dheight, aViewsize.width, aViewsize.height);
    [aImage drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

//返回居中的缩略图
+ (UIImage *)image:(UIImage *)aImage centerInSize:(CGSize)aViewsize{
    return [self image:aImage centerInSize:aViewsize backgroundColor:nil];
}

+ (UIImage *)tailorImage:(UIImage *)aImage imageViewSize:(CGSize)imageViewSize
{
    CGFloat width = 0.f;
    CGFloat height = 0.f;
    CGSize imageSize = aImage.size;
    CGRect rect;
    if (aImage.size.width < aImage.size.height) {
        width  = aImage.size.width;
        height = aImage.size.width;
        rect = CGRectMake(0, (imageSize.height - height)/2.f, width, height);
    }else if (aImage.size.width > aImage.size.height) {
        width  = aImage.size.height;
        height = aImage.size.height;
        rect = CGRectMake((imageSize.width - width)/2.f, 0.f, width, height);
    }else{
        width  = aImage.size.height;
        height = aImage.size.height;
        rect = CGRectMake(0, 0, width, height);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([aImage CGImage], rect);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:aImage.imageOrientation];
    CGImageRelease(imageRef);
    return newImage;
}

+ (UIImage *)image:(UIImage *)aImage centerInSize:(CGSize)aViewsize backgroundColor:(UIColor*)bgColor{
    CGSize size = aImage.size;
    UIGraphicsBeginImageContextWithOptions(aViewsize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (bgColor) {
        CGContextSetFillColorWithColor(context, bgColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, aViewsize.width, aViewsize.height));
    }
    
    
    float dwidth = (aViewsize.width - size.width) / 2.0f;
    float dheight = (aViewsize.height - size.height) / 2.0f;
    CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
    [aImage drawInRect:rect];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (UIImage *)thumbnailImage:(UIImage *)image
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = imageWidth*0.78;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

//返回填充的缩略图
+ (UIImage *)image:(UIImage *)aImage fillSize:(CGSize)aViewsize{
    CGSize size = aImage.size;
    
    CGFloat scalex = aViewsize.width / size.width;
    CGFloat scaley = aViewsize.height / size.height;
    CGFloat scale = MAX(scalex, scaley);
    
    UIGraphicsBeginImageContext(aViewsize);
    
    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;
    
    float dwidth = ((aViewsize.width - width) / 2.0f);
    float dheight = ((aViewsize.height - height) / 2.0f);
    
    CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height * scale);
    [aImage drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

//让图片变小
+ (UIImage *)rescaleToSize:(UIImage *)aInImage toSize:(CGSize)aSize {
    CGRect rect = CGRectMake(0.0, 0.0, aSize.width, aSize.height);
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(aSize, NO, [UIScreen mainScreen].scale); // 0.f for scale means "scale for device's main screen".
    } else {
        UIGraphicsBeginImageContext(aSize);
    }
#else
    UIGraphicsBeginImageContext([self size]);
#endif
    
    //	UIGraphicsBeginImageContext(rect.size);
    [aInImage drawInRect:rect];
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

#pragma mark

- (UIImage *) croppedImage:(CGRect)cropRect{
    CGImageRef imageRef = CGImageCreateWithImageInRect( [self CGImage], cropRect );
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:1.0f orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return croppedImage;
}

+ (BOOL) writeToImage:(UIImage*)aImage toFileAtPath:(NSString *)aFilePath{
    if ( (aImage == nil) || (aFilePath == nil) ) {
        return NO;
    }
    
    @try {
        NSData *imageData = nil;
        NSString *ext = [aFilePath pathExtension];
        if ([ext isEqualToString:@"jpeg"]||[ext isEqualToString:@"jpg"]) {
            // 0. best  1. lost
            imageData = UIImageJPEGRepresentation(aImage, 0);
        }
        else if([ext isEqualToString:@"png"])
        {
            imageData = UIImagePNGRepresentation(aImage);
        }
        
        if ( (imageData == nil) || ([imageData length] <= 0)) {
            return NO;
        }
        
        [imageData writeToFile:aFilePath atomically:YES];
        
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"create file exception.");
    }
    
    return NO;
}

+ (UIImage*)imageTintedWithColor:(UIColor*)color  toSize:(CGSize)aSize{
    UIGraphicsBeginImageContextWithOptions(aSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, aSize.width, aSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)imageWithColor:(UIColor*)color{
    CGFloat width = 5.f;
    CGFloat height = 5.f;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *coloredImage = [UIImage imageWithCGImage:cImage];
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cImage);
    
    return coloredImage;
}

+ (UIImage*)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float) i_width{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), NO, [UIScreen mainScreen].scale);
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(LYGradientType)gradientType imgSize:(CGSize)imgSize
{
    return [self getGradientImageFromColors:colors gradientType:gradientType imgSize:imgSize cornerRadius:0.f];
}

- (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(LYGradientType)gradientType imgSize:(CGSize)imgSize cornerRadius:(CGFloat)cornerRadius
{
    CGRect frame = CGRectMake(0, 0, imgSize.width, imgSize.height);
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (cornerRadius) {
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:24.f];
        [imgPath addClip];
        [self drawInRect:frame];
    }
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case LYGradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case LYGradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}



+ (UIImage *)ly_createQRCodeWithUrlString:(NSString*)urlString QRSize:(CGFloat)qrSize
{
    CIImage * cllImage = [UIImage ly_createQRCodeWithUrlString:urlString];
    return [UIImage ly_adjustQRImageSize:cllImage QRSize:qrSize];
}

+ (CIImage *)ly_createQRCodeWithUrlString:(NSString*)url
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *qrCode = [filter outputImage];
    return qrCode;
}

+ (UIImage *)ly_adjustQRImageSize:(CIImage*)ciImage QRSize:(CGFloat)qrSize
{
    // 获取CIImage图片的的Frame
    CGRect ciImageRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(qrSize / CGRectGetWidth(ciImageRect), qrSize / CGRectGetHeight(ciImageRect));
    
    // 创建bitmap
    size_t width = CGRectGetWidth(ciImageRect) * scale;
    size_t height = CGRectGetHeight(ciImageRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:ciImageRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, ciImageRect, bitmapImage);
    
    // 保存Bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)ly_imageWithBorderWidth:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image cornerRadius:(CGFloat)cornerRadius
{
    CGSize size = CGSizeMake(image.size.width + 2 * borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    [color set];
    [path fill];
    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderW, borderW, image.size.width, image.size.height) cornerRadius:cornerRadius];
    [path addClip];
    [image drawInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)addCenterlogo:(UIImage*)centerLogo logoPosition:(CGRect)logoRect
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //四个参数为水印图片的位置
    [centerLogo drawInRect:logoRect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)ly_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [text drawAtPoint:point withAttributes:attributed];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ly_imageWithClippedRect:(CGRect)rect
{
    CGRect imageRect = CGRectMakeWithSize(self.size);
    if (CGRectContainsRect(rect, imageRect)) {
        return self;
    }
    // 由于CGImage是以pixel为单位来计算的，而UIImage是以point为单位，所以这里需要将传进来的point转换为pixel
//    CGRect scaledRect = CGRectApplyScale(rect, self.scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *imageOut = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return imageOut;
}

- (UIImage *)ly_imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)qmui_imageResizedInLimitedSize:(CGSize)size resizingMode:(QMUIImageResizingMode)resizingMode
{
    return [self qmui_imageResizedInLimitedSize:size resizingMode:resizingMode scale:self.scale];
}

- (UIImage *)qmui_imageResizedInLimitedSize:(CGSize)size resizingMode:(QMUIImageResizingMode)resizingMode scale:(CGFloat)scale
{
    size = CGSizeFlatSpecificScale(size, scale);
    CGSize imageSize = self.size;
    CGRect drawingRect = CGRectZero;// 图片绘制的 rect
    CGSize contextSize = CGSizeZero;// 画布的大小
    
    if (CGSizeEqualToSize(size, imageSize) && scale == self.scale) {
        return self;
    }
    
    if (resizingMode >= QMUIImageResizingModeScaleAspectFit && resizingMode <= QMUIImageResizingModeScaleAspectFillBottom) {
        CGFloat horizontalRatio = size.width / imageSize.width;
        CGFloat verticalRatio = size.height / imageSize.height;
        CGFloat ratio = 0;
        if (resizingMode >= QMUIImageResizingModeScaleAspectFill && resizingMode < (QMUIImageResizingModeScaleAspectFill + 10)) {
            ratio = MAX(horizontalRatio, verticalRatio);
        } else {
            // 默认按 QMUIImageResizingModeScaleAspectFit
            ratio = MIN(horizontalRatio, verticalRatio);
        }
        CGSize resizedSize = CGSizeMake(flatSpecificScale(imageSize.width * ratio, scale), flatSpecificScale(imageSize.height * ratio, scale));
        contextSize = CGSizeMake(MIN(size.width, resizedSize.width), MIN(size.height, resizedSize.height));
        drawingRect.origin.x = CGFloatGetCenter(contextSize.width, resizedSize.width);
        
        CGFloat originY = 0;
        if (resizingMode % 10 == 1) {
            // toTop
            originY = 0;
        } else if (resizingMode % 10 == 2) {
            // toBottom
            originY = contextSize.height - resizedSize.height;
        } else {
            // default is Center
            originY = CGFloatGetCenter(contextSize.height, resizedSize.height);
        }
        drawingRect.origin.y = originY;
        
        drawingRect.size = resizedSize;
    } else {
        // 默认按照 QMUIImageResizingModeScaleToFill
        drawingRect = CGRectMakeWithSize(size);
        contextSize = size;
    }
    
    return [UIImage qmui_imageWithSize:contextSize opaque:self.qmui_opaque scale:scale actions:^(CGContextRef contextRef) {
        [self drawInRect:drawingRect];
    }];
}

+ (UIImage *)qmui_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock {
    if (!actionBlock || CGSizeIsEmpty(size)) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    actionBlock(context);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

- (BOOL)qmui_opaque {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast
    || alphaInfo == kCGImageAlphaNoneSkipFirst
    || alphaInfo == kCGImageAlphaNone;
    return opaque;
}

@end
