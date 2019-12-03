//
//  LYImageShow.m
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYImageShow.h"
#import "UIImage+LYUtil.h"
#import "NSString+LYTool.h"
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageDownloader.h>
@implementation LYImageShow

+ (BOOL)existImageWithimagePath:(NSString *)imagePath
{
    NSString * cacheKey = [imagePath md5Str];
    UIImage * cacheImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:cacheKey];
    if (cacheImage) {
        return YES;
    }
    return NO;
}

+ (UIImage *)ly_cacheImageWithPath:(NSString *)imagepath size:(CGSize)size
{
    NSString * cacheKey = [LYImageShow screctImagePath:imagepath imageSize:size];
    UIImage * cacheImgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
    return cacheImgProcess;
}

+ (void)removeImageWithimagePath:(NSString *)imagePath
{
    NSString * cacheKey = [imagePath md5Str];
    [[SDImageCache sharedImageCache] removeImageForKey:cacheKey withCompletion:nil];
}

+ (void)saveImageInSDCacheimagePath:(NSString *)imagePath image:(UIImage *)image
{
    NSString * cacheKey = [imagePath md5Str];
    BOOL existImage = [LYImageShow existImageWithimagePath:imagePath];
    if (!existImage) {
        [[SDImageCache sharedImageCache] storeImage:image forKey:cacheKey toDisk:YES completion:nil];
    }
}

+ (void)showImageInImageView:(UIImageView *)aImageView imagePath:(NSString *)imagePath
{
    NSString * cacheKey = [imagePath md5Str];
    UIImage * cacheImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:cacheKey];
    if (cacheImage) {
        aImageView.image = cacheImage;
    }
}

+ (void)downImageWithImagePath:(NSString *)imagePath downCompleted:(void(^)(UIImage *))downCompleted
{
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[LYImageShow codeImagePath:imagePath]] options:SDWebImageDownloaderContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (!error) {
            LYNSLog(@"dwon completed -%@", imagePath);
            NSString * cacheKey = [imagePath md5Str];
            UIImage * cacheImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:cacheKey];
            if (!cacheImage) {
                [[SDImageCache sharedImageCache] storeImage:image forKey:cacheKey toDisk:YES completion:nil];
            }
            if (downCompleted) {
                downCompleted(image);
            }
        }else{
            LYNSLog(@"loadImageWithURL -- %@", error);
        }
    }];
    LYNSLog(@"downImageWithImagePath --");
//    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:[LYImageShow codeImagePath:imagePath]] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//
//    }];
}

+ (void)downImagesWithImagePaths:(NSArray *)imagePaths downCompleted:(void(^)(NSDictionary * imageDictionary))downCompleted
{
    dispatch_queue_t imageQueue = dispatch_queue_create("com.toursCool.ly.downImages", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t imageGroup = dispatch_group_create();
    NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
    __block BOOL tag = YES;
    for (NSString * urlString in imagePaths) {
        dispatch_group_enter(imageGroup);
        dispatch_group_async(imageGroup, imageQueue, ^{
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:[LYImageShow codeImagePath:urlString]] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (error) {
                    tag = NO;
                }else{
                    [imageDic setObject:image forKey:imageURL.absoluteString];
                }
                dispatch_group_leave(imageGroup);
            }];
        });
    }
    
    dispatch_group_notify(imageGroup, dispatch_get_main_queue(), ^{
        if (tag) {
            downCompleted(imageDic);
        }else{
            downCompleted(nil);
        }
    });
}

+ (void)cancelLoadImageImageView:(UIImageView *)aImageView
{
    [aImageView sd_cancelCurrentImageLoad];
}

+ (void)showRectImageInImageView:(UIImageView *)aImageView
                        withPath:(NSString *)aImagePath
                placeholderImage:(UIImage * _Nullable)placeholderImage
                    cornerRadius:(CGFloat)cornerRadius
                            size:(CGSize)size
{
    [LYImageShow showImageInImageView:aImageView withPath:aImagePath placeholderImage:placeholderImage withNeedCache:NO withImageType:RectImageType withImageBlock:nil cornerRadius:cornerRadius currentSize:size];
}

+ (void)showRectImageInImageView:(UIImageView *)aImageView
                          withPath:(NSString *)aImagePath
                placeholderImage:(UIImage * _Nullable)placeholderImage
                    cornerRadius:(CGFloat)cornerRadius
{
    [LYImageShow showImageInImageView:aImageView withPath:aImagePath placeholderImage:placeholderImage withNeedCache:NO withImageType:RectImageType withImageBlock:nil cornerRadius:cornerRadius];
}
+ (void)showCircleImageInImageView:(UIImageView *)aImageView
                    withPath:(NSString *)aImagePath
            placeholderImage:(UIImage * _Nullable)placeholderImage
{
    [LYImageShow showImageInImageView:aImageView withPath:aImagePath placeholderImage:placeholderImage withNeedCache:NO withImageType:CircleImageType withImageBlock:nil cornerRadius:0.f];
}

+ (void)showImageInImageView:(UIImageView *)aImageView
                    withPath:(NSString *)aImagePath
            placeholderImage:(UIImage * _Nullable)placeholderImage
                  imageBlock:(void (^)(UIImage *imgData))aBlock
{
//    __weak typeof(aImageView) weakImageView = aImageView;
    NSString * urlEncStr = [LYImageShow codeImagePath:aImagePath];
    NSURL *url = [NSURL URLWithString:urlEncStr];
//    NSString *cacheKey = [LYImageShow screctImagePath:aImagePath imageSize:CGSizeZero];
//    UIImage * cacheImgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
//    if (cacheImgProcess) {
//        [LYImageShow showImageView:aImageView image:cacheImgProcess withImageBlock:aBlock];
//    }else{
        [aImageView sd_setImageWithURL:url
                      placeholderImage:placeholderImage
                               options:SDWebImageRefreshCached
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                 CGSize size = imageSize;
                                 aBlock(image);
//                                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                                     [LYImageShow asyncOriginalImage:image forImageType:aImageType forPath:aImagePath cornerRadius:cornerRadius imageSzie:size withImageBlock:^(UIImage *imgData) {
//                                         dispatch_async(dispatch_get_main_queue(), ^{
//                                             if (image) {
//                                                 [LYImageShow showImageView:weakImageView image:imgData withImageBlock:aBlock];
//                                             } else {
//                                                 weakImageView.image = circularPlaceholderImage;
//                                             }
//                                         });
//                                     }];
//                                 });
                             }];
//    }
}

+ (void)showImageInImageView:(UIImageView *)aImageView
                    withPath:(NSString *)aImagePath
            placeholderImage:(UIImage * _Nullable)placeholderImage
{
    [LYImageShow showImageInImageView:aImageView withPath:aImagePath placeholderImage:placeholderImage withNeedCache:NO withImageType:DefaultImageType withImageBlock:nil cornerRadius:0.f];
}

+ (void)ly_showClippedRectImageInImageView:(UIImageView *)aImageView path:(NSString *)path cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage * _Nullable)placeholderImage itemSize:(CGSize)itemSize
{
    UIImage * circularPlaceholderImage = placeholderImage;
    if (cornerRadius > 0.f) {
        circularPlaceholderImage = [circularPlaceholderImage roundedRectImageWithSize:itemSize withCornerRadius:cornerRadius];
    }
    __weak typeof(aImageView) weakImageView = aImageView;
    NSString * urlEncStr = [LYImageShow codeImagePath:path];
    NSURL *url = [NSURL URLWithString:urlEncStr];
    NSString *cacheKey = [LYImageShow screctImagePath:path imageSize:itemSize];
    UIImage * cacheImgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
    if (cacheImgProcess) {
        [LYImageShow showImageView:aImageView image:cacheImgProcess withImageBlock:nil];
    }else{
        [aImageView sd_setImageWithURL:url
                      placeholderImage:circularPlaceholderImage
                               options:SDWebImageRefreshCached
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                     if (image) {
                                         CGSize imageSize = image.size;
                                         CGFloat x = 0.f;
                                         CGFloat y = 0.f;
                                         CGFloat width = itemSize.width * 3.f;
                                         CGFloat height = itemSize.height * 3.f;
                                         x = (imageSize.width - width) / 2.f;
                                         y = imageSize.height - height;
                                         
                                         UIImage * imgProcess = [image ly_imageWithClippedRect:CGRectMake(x, y, width, height)];
                                         if (cornerRadius) {
                                             [LYImageShow asyncOriginalImage:imgProcess forImageType:RectImageType forPath:path cornerRadius:cornerRadius imageSzie:itemSize rectCorner:0 withImageBlock:^(UIImage *imgData) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     if (imgProcess) {
                                                         [LYImageShow showImageView:weakImageView image:imgData withImageBlock:nil];
                                                     } else {
                                                         weakImageView.image = circularPlaceholderImage;
                                                     }
                                                 });
                                             }];
                                         }else{
                                             [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
                                         }
                                     }
                                 });
                             }];
    }
}


+ (void)ly_showImageScaleInImageView:(UIImageView *)aImageView path:(NSString *)path cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage * _Nullable)placeholderImage itemSize:(CGSize)itemSize
{
    UIImage * circularPlaceholderImage = placeholderImage;
    if (cornerRadius > 0.f) {
        circularPlaceholderImage = [circularPlaceholderImage roundedRectImageWithSize:aImageView.frame.size withCornerRadius:cornerRadius];
    }
    __weak typeof(aImageView) weakImageView = aImageView;
    NSString * urlEncStr = [LYImageShow codeImagePath:path];
    NSURL *url = [NSURL URLWithString:urlEncStr];
    NSString *cacheKey = [LYImageShow screctImagePath:path imageSize:itemSize];
    UIImage * cacheImgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
    if (cacheImgProcess) {
        [LYImageShow showImageView:aImageView image:cacheImgProcess withImageBlock:nil];
    }else{
        [aImageView sd_setImageWithURL:url
                      placeholderImage:circularPlaceholderImage
                               options:SDWebImageRefreshCached
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                     if (image) {
                                         UIImage * imgProcess = [image qmui_imageResizedInLimitedSize:itemSize resizingMode:QMUIImageResizingModeScaleAspectFit scale:[UIScreen mainScreen].scale];
//                                         UIImage * imgProcess = [UIImage image:image fitInSize:itemSize];
                                         if (cornerRadius) {
                                             [LYImageShow asyncOriginalImage:imgProcess forImageType:RectImageType forPath:path cornerRadius:cornerRadius imageSzie:itemSize rectCorner:0 withImageBlock:^(UIImage *imgData) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     if (imgProcess) {
                                                         [LYImageShow showImageView:weakImageView image:imgData withImageBlock:nil];
                                                     } else {
                                                         weakImageView.image = circularPlaceholderImage;
                                                     }
                                                 });
                                             }];
                                         }else{
                                             [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
                                         }
                                     }
                                 });
                             }];
    }
}

+ (void)ly_showImageInImageView:(UIImageView *)aImageView path:(NSString *)path cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage * _Nullable)placeholderImage itemSize:(CGSize)itemSize
{
    UIImage * circularPlaceholderImage = placeholderImage;
    if (cornerRadius > 0.f) {
        circularPlaceholderImage = [circularPlaceholderImage roundedRectImageWithSize:aImageView.frame.size withCornerRadius:cornerRadius];
    }
    __weak typeof(aImageView) weakImageView = aImageView;
    NSString * urlEncStr = [LYImageShow codeImagePath:path];
    NSURL *url = [NSURL URLWithString:urlEncStr];
    NSString *cacheKey = [LYImageShow screctImagePath:path imageSize:itemSize];
    UIImage * cacheImgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
    if (cacheImgProcess) {
        [LYImageShow showImageView:aImageView image:cacheImgProcess withImageBlock:nil];
    }else{
        [aImageView sd_setImageWithURL:url
                      placeholderImage:circularPlaceholderImage
                               options:SDWebImageRefreshCached
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                     if (image) {
                                         UIImage * img = [UIImage tailorImage:image imageViewSize:itemSize];
                                         UIImage * imgProcess = [UIImage rescaleToSize:img toSize:itemSize];
                                         if (cornerRadius) {
                                             [LYImageShow asyncOriginalImage:imgProcess forImageType:RectImageType forPath:path cornerRadius:cornerRadius imageSzie:itemSize rectCorner:0 withImageBlock:^(UIImage *imgData) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     if (imgProcess) {
                                                         [LYImageShow showImageView:weakImageView image:imgData withImageBlock:nil];
                                                     } else {
                                                         weakImageView.image = circularPlaceholderImage;
                                                     }
                                                 });
                                             }];
                                         }else{
                                             [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
                                         }
                                     }
                                 });
                             }];
    }
}

+ (void)ly_downImageAnyCornerImageWithImageView:(UIImageView *)aImageView
                                      path:(NSString *)imagePath
                          placeholderImage:(UIImage * _Nullable)placeholderImage
                               currentSize:(CGSize)currentSize
                                   cornerRadius:(CGFloat)cornerRadius
                                     rectCorner:(UIRectCorner)rectCorner
{
    UIImage * circularPlaceholderImage = placeholderImage;
    if (cornerRadius > 0.f) {
        circularPlaceholderImage = [circularPlaceholderImage roundedRectImageWithSize:aImageView.frame.size withCornerRadius:cornerRadius];
    }
    __weak typeof(aImageView) weakImageView = aImageView;
    [LYImageShow ly_downImageInImageView:aImageView path:imagePath placeholderImage:circularPlaceholderImage currentSize:currentSize downImageCompletedBlock:^(UIImage *downImage) {
        if (downImage) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [LYImageShow asyncOriginalImage:downImage forImageType:AnyRectImageType forPath:imagePath cornerRadius:cornerRadius imageSzie:currentSize rectCorner:rectCorner withImageBlock:^(UIImage *imgData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (imgData) {
                            [LYImageShow showImageView:weakImageView image:imgData withImageBlock:nil];
                        } else {
                            weakImageView.image = circularPlaceholderImage;
                        }
                    });
                }];
            });
        }
    }];
}

+ (void)ly_downImageInImageView:(UIImageView *)aImageView
                           path:(NSString *)imagePath
               placeholderImage:(UIImage * _Nullable)placeholderImage
                    currentSize:(CGSize)currentSize downImageCompletedBlock:(void (^)(UIImage *downImage))downImageCompletedBlock
{
    CGSize imageSize = currentSize;
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        imageSize = aImageView.frame.size;
    }
    NSString * urlEncStr = [LYImageShow codeImagePath:imagePath];
    NSString *cacheKey = [LYImageShow screctImagePath:imagePath imageSize:imageSize];
    UIImage * cacheImgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
    if (cacheImgProcess) {
        [LYImageShow showImageView:aImageView image:cacheImgProcess withImageBlock:nil];
    }else{
        NSURL *url = [NSURL URLWithString:urlEncStr];
        [aImageView sd_setImageWithURL:url
                      placeholderImage:placeholderImage
                               options:SDWebImageRefreshCached
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 if (downImageCompletedBlock) {
                                     downImageCompletedBlock(image);
                                 }
                             }];
    }
}

+ (void)showImageInImageView:(UIImageView *)aImageView
                    withPath:(NSString *)aImagePath
            placeholderImage:(UIImage * _Nullable)placeholderImage
               withNeedCache:(BOOL)needCache
               withImageType:(ImageShowType)aImageType
              withImageBlock:(void (^)(UIImage *imgData))aBlock
                cornerRadius:(CGFloat)cornerRadius
                 currentSize:(CGSize)currentSize
{
    UIImage * circularPlaceholderImage = placeholderImage;
    CGSize imageSize = currentSize;
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        imageSize = aImageView.frame.size;
    }
    if (cornerRadius > 0.f) {
        circularPlaceholderImage = [circularPlaceholderImage roundedRectImageWithSize:imageSize withCornerRadius:cornerRadius];
    }
    __weak typeof(aImageView) weakImageView = aImageView;
    NSString * urlEncStr = [LYImageShow codeImagePath:aImagePath];
    NSURL *url = [NSURL URLWithString:urlEncStr];
    NSString *cacheKey = [LYImageShow screctImagePath:aImagePath imageSize:imageSize];
    UIImage * cacheImgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
    if (cacheImgProcess) {
        [LYImageShow showImageView:aImageView image:cacheImgProcess withImageBlock:aBlock];
    }else{
        [aImageView sd_setImageWithURL:url
                      placeholderImage:circularPlaceholderImage
                               options:SDWebImageRefreshCached
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 CGSize size = imageSize;
                                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                     [LYImageShow asyncOriginalImage:image forImageType:aImageType forPath:aImagePath cornerRadius:cornerRadius imageSzie:size rectCorner:0 withImageBlock:^(UIImage *imgData) {
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             if (image) {
                                                 [LYImageShow showImageView:weakImageView image:imgData withImageBlock:aBlock];
                                             } else {
                                                 weakImageView.image = circularPlaceholderImage;
                                             }
                                         });
                                     }];
                                 });
                             }];
    }
}

+ (void)showImageView:(UIImageView *)aImageView
                image:(UIImage *)image
       withImageBlock:(void (^)(UIImage *imgData))aBlock
{
    if (aBlock) {
        aBlock(image);
    } else {
        if (image) {
            aImageView.image = image;
        }
    }
}

+ (void)showImageInImageView:(UIImageView *)aImageView
                    withPath:(NSString *)aImagePath
            placeholderImage:(UIImage * _Nullable)placeholderImage
               withNeedCache:(BOOL)needCache
               withImageType:(ImageShowType)aImageType
              withImageBlock:(void (^)(UIImage *imgData))aBlock
                cornerRadius:(CGFloat)cornerRadius
{
    //网络图片处理
    [LYImageShow showImageInImageView:aImageView withPath:aImagePath placeholderImage:placeholderImage withNeedCache:needCache withImageType:aImageType withImageBlock:aBlock cornerRadius:cornerRadius currentSize:CGSizeZero];
}

+ (void)asyncOriginalImage:(UIImage *)originalImage
              forImageType:(ImageShowType)aImageType
                   forPath:(NSString *)aImagePath
              cornerRadius:(CGFloat)cornerRadius
                 imageSzie:(CGSize)imageSzie
                rectCorner:(UIRectCorner)rectCorner
            withImageBlock:(void (^)(UIImage *imgData))aBlock

{
    __block UIImage *imgProcess = nil;
    NSString *cacheKey = [LYImageShow screctImagePath:aImagePath imageSize:imageSzie];
    switch (aImageType) {
        case CircleImageType:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                imgProcess = [originalImage circularImageWithDiamter:imageSzie.height / 2.f];
                [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
                if (aBlock) {
                    aBlock(imgProcess);
                }
            });
        }
            break;
        case RectImageType:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                imgProcess = [originalImage roundedRectImageWithSize:imageSzie withCornerRadius:cornerRadius];
                [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
                if (aBlock) {
                    aBlock(imgProcess);
                }
            });
        }
            break;
        case AnyRectImageType:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                imgProcess = [originalImage ly_anyRoundedRectImageWithSize:imageSzie cornerRadius:cornerRadius rectCorner:rectCorner];
                [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
                if (aBlock) {
                    aBlock(imgProcess);
                }
            });
        }
            break;
        default:
            [[SDImageCache sharedImageCache] storeImage:originalImage forKey:cacheKey toDisk:YES completion:nil];
            break;
    }
}

+ (UIImage *)originalImage:(UIImage *)originalImage
              forImageType:(ImageShowType)aImageType
                   forPath:(NSString *)aImagePath
              cornerRadius:(CGFloat)cornerRadius
                 imageSzie:(CGSize)imageSzie
{
    if (aImagePath == nil) {
        return nil;
    }
    //    SDImageCache
    UIImage *imgProcess = nil;
    NSString *cacheKey = [LYImageShow screctImagePath:aImagePath imageSize:imageSzie];
    switch (aImageType) {
        case CircleImageType:
            imgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
            if (!imgProcess) {
                imgProcess = [originalImage circularImageWithDiamter:imageSzie.height / 2.f];
                [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
            }
            break;
        case RectImageType:
            imgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
            if (!imgProcess) {
                imgProcess = [originalImage roundedRectImageWithSize:imageSzie withCornerRadius:cornerRadius];
                [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
            }
            break;
        case DefaultImageType:
            imgProcess = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
            if (!imgProcess) {
                imgProcess = originalImage;
                // 重新保存 SD自己保存一个原图片 CC_MD5_DIGEST_LENGTH md加密
                [[SDImageCache sharedImageCache] storeImage:imgProcess forKey:cacheKey toDisk:YES completion:nil];
            }
            break;
        default:
            break;
    }
    return imgProcess;
}

+ (NSString *)screctImagePath:(NSString *)imagepath imageSize:(CGSize)imageSize
{
    if (imagepath.length) {
        NSString * imageEncryption = [NSString stringWithFormat:@"%@%@", NSStringFromCGSize(imageSize), imagepath];
        return [imageEncryption md5Str];
    }
    return @"";
}

+ (NSString *)codeImagePath:(NSString *)imagepath
{
    return [imagepath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
