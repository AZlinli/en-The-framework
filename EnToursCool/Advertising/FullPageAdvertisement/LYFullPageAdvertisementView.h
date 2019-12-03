//
//  LYFullPageAdvertisementView.h
//  LYIGListKitTest
//
//  Created by tourscool on 2/18/19.
//  Copyright © 2019 Saber. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYFullPageAdvertisementModel;
typedef void(^LYUserTouchFullPageAdvertisementBlock)(NSString * _Nullable advertisementPath);
NS_ASSUME_NONNULL_BEGIN

@interface LYFullPageAdvertisementView : UIView
@property (nonatomic, copy) LYUserTouchFullPageAdvertisementBlock userTouchFullPageAdvertisementBlock;

- (void)showImageWithImagePath:(NSString *)imagePath;

- (void)setViewFullPageAdvertisementModel:(LYFullPageAdvertisementModel *)fullPageAdvertisementModel;
+ (LYFullPageAdvertisementView *)obtainFullPageAdvertisementView;
@end

NS_ASSUME_NONNULL_END
