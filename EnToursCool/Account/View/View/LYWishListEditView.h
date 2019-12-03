//
//  LYGuideTourDownloadEditView.h
//  ToursCool
//
//  Created by 稀饭旅行 on 2019/9/27.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LYWishListEditViewDelegate <NSObject>

@required
-(void)clickSelectedAllButton:(BOOL)isSelected;
-(void)clickDeleteButton;

@end
@interface LYWishListEditView : UIView
@property (nonatomic, weak) id<LYWishListEditViewDelegate> delegate;
@property (nonatomic, assign) NSInteger count;
- (void)modifySelectButtonState;
- (void)modifySelectButtonNumber;
@end

NS_ASSUME_NONNULL_END
