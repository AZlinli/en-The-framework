//
//  LYCustomDetailNavigationBar.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^BackBlock)(void);
typedef void (^ShareBlock)(void);

@interface LYCustomDetailNavigationBar : UIView
- (void)setupViewStyleWithAlpha:(CGFloat)alpha;
/**返回按钮的回调*/
@property(nonatomic, copy) BackBlock  backBlock;

/**分享按钮的回调*/
@property(nonatomic, copy) ShareBlock  shareBlock;
@end

NS_ASSUME_NONNULL_END
