//
//  LYPlayerControllerTopView.h
//  ToursCool
//
//  Created by tourscool on 6/14/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYUserTapPlayerControllerTopViewBackButton)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LYPlayerControllerTopView : UIView
@property (nonatomic, copy) LYUserTapPlayerControllerTopViewBackButton userTapPlayerControllerTopViewBackButton;
@end

NS_ASSUME_NONNULL_END
