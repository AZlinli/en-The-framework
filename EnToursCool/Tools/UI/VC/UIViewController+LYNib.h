//
//  UIViewController+LYNib.h
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BackButtonHandlerProtocol <NSObject>
@optional
- (BOOL)navigationShouldPopOnBackButton;
@end
@interface UIViewController (LYNib)<BackButtonHandlerProtocol>

/**
 *  @brief xib中加载VC
 *  @return VC
 */
+ (instancetype)loadFromNib;
/**
 *  @brief StoryBoard加载VC
 *
 *  @param storyBoard StoryBoard名称
 *
 *  @return VC
 */
+ (instancetype)loadFromStoryBoard:(NSString *)storyBoard;
/**
 pop 指定页面

 @param vcName ControllerName
 @param animated 是否动画
 */
- (void)backToViewControllerWithVCName:(NSString *)vcName animated:(BOOL)animated;
- (BOOL)navigationControllerHasWithVCName:(NSString *)vcName;
- (void)exchangeWithVCName:(NSString *)vcName swappedVCName:(NSString *)swappedVCName;
+ (UIViewController *)findCurrentShowingViewController;
/**
 是否包含某个界面

 @param vcName 名字
 @return BOOL
 */
+ (BOOL)findViewControllerWithVCName:(NSString *)vcName;

@end
