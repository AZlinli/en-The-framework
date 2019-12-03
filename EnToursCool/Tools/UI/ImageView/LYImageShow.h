//
//  LYImageShow.h
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ImageShowType) {
    /**
     *  @brief 默认图片，正常图片
     */
    DefaultImageType,
    /**
     *  @brief 圆形图片
     */
    CircleImageType,
    /**
     *  @brief 圆角
     */
    RectImageType,
    /**
     *  @brief 任意圆角
     */
    AnyRectImageType
};

NS_ASSUME_NONNULL_BEGIN

@interface LYImageShow : NSObject
/**
 设置网络图片

 @param aImageView imageView
 @param aImagePath 图片地址
 @param placeholderImage 占位图
 @param needCache 是否需要缓存
 @param aImageType 图片样式
 @param aBlock 回调
 @param cornerRadius 圆角
 */
+ (void)showImageInImageView:(UIImageView *)aImageView
                    withPath:(NSString *)aImagePath
            placeholderImage:(UIImage * _Nullable)placeholderImage
               withNeedCache:(BOOL)needCache
               withImageType:(ImageShowType)aImageType
              withImageBlock:(nullable void (^)(UIImage *imgData))aBlock
                cornerRadius:(CGFloat)cornerRadius;

/**
 设置圆角网络图片

 @param aImageView ImageView
 @param aImagePath 网络地址
 @param placeholderImage 占位图
 @param cornerRadius 原角度
 */
+ (void)showRectImageInImageView:(UIImageView *)aImageView
                        withPath:(NSString *)aImagePath
                placeholderImage:(UIImage * _Nullable)placeholderImage
                    cornerRadius:(CGFloat)cornerRadius;

/**
 设置圆形网络图片

 @param aImageView ImageView
 @param aImagePath 网络地址
 @param placeholderImage 占位图
 */
+ (void)showCircleImageInImageView:(UIImageView *)aImageView
                          withPath:(NSString *)aImagePath
                  placeholderImage:(UIImage * _Nullable)placeholderImage;

/**
 设置网络图片

 @param aImageView ImageView
 @param aImagePath 网络地址
 @param placeholderImage 占位图
 */
+ (void)showImageInImageView:(UIImageView *)aImageView
                    withPath:(NSString *)aImagePath
            placeholderImage:(UIImage * _Nullable)placeholderImage;
+ (void)downImagesWithImagePaths:(NSArray *)imagePaths downCompleted:(void(^)(NSDictionary * imageDictionary))downCompleted;

+ (void)showRectImageInImageView:(UIImageView *)aImageView
                        withPath:(NSString *)aImagePath
                placeholderImage:(UIImage * _Nullable)placeholderImage
                    cornerRadius:(CGFloat)cornerRadius
                            size:(CGSize)size;

+ (void)ly_showImageScaleInImageView:(UIImageView *)aImageView path:(NSString *)path cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage * _Nullable)placeholderImage itemSize:(CGSize)itemSize;

/**
 正方形图片

 @param aImageView imageView
 @param path 图片地址
 @param cornerRadius cornerRadius
 @param placeholderImage placeholderImage
 @param itemSize imageView 大小
 */
+ (void)ly_showImageInImageView:(UIImageView *)aImageView path:(NSString *)path cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage * _Nullable)placeholderImage itemSize:(CGSize)itemSize;

+ (void)ly_downImageAnyCornerImageWithImageView:(UIImageView *)aImageView
                                           path:(NSString *)imagePath
                               placeholderImage:(UIImage * _Nullable)placeholderImage
                                    currentSize:(CGSize)currentSize
                                   cornerRadius:(CGFloat)cornerRadius
                                     rectCorner:(UIRectCorner)rectCorner;

// LYHomeBannerCollectionViewCell 图片加载使用
+ (void)ly_showClippedRectImageInImageView:(UIImageView *)aImageView path:(NSString *)path cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage * _Nullable)placeholderImage itemSize:(CGSize)itemSize;

+ (void)showImageInImageView:(UIImageView *)aImageView
                    withPath:(NSString *)aImagePath
            placeholderImage:(UIImage * _Nullable)placeholderImage
                  imageBlock:(void (^)(UIImage *imgData))aBlock;

/**
 取消图片下载

 @param aImageView imageView
 */
+ (void)cancelLoadImageImageView:(UIImageView *)aImageView;

+ (void)downImageWithImagePath:(NSString *)imagePath downCompleted:(void(^)(UIImage *))downCompleted;
+ (void)showImageInImageView:(UIImageView *)aImageView imagePath:(NSString *)imagePath;

+ (BOOL)existImageWithimagePath:(NSString *)imagePath;
+ (void)saveImageInSDCacheimagePath:(NSString *)imagePath image:(UIImage *)image;
+ (NSString *)codeImagePath:(NSString *)imagepath;
+ (void)removeImageWithimagePath:(NSString *)imagePath;

+ (UIImage *)ly_cacheImageWithPath:(NSString *)imagepath size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
