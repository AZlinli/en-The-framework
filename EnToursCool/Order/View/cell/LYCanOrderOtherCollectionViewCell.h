//
//  LYCanOrderOtherCollectionViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * _Nullable const LYCanOrderOtherCollectionViewCellID;
NS_ASSUME_NONNULL_BEGIN
@protocol LYCanOrderOtherCollectionViewCellDelegate <NSObject>

@optional

- (void)deleteImage:(UIImage*)image;

@end
@interface LYCanOrderOtherCollectionViewCell : UICollectionViewCell
@property(nonatomic, assign) BOOL isAddPic;
@property (nonatomic, weak) id<LYCanOrderOtherCollectionViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END


