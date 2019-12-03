//
//  LYWebViewController.h
//  ToursCool
//
//  Created by tourscool on 12/11/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYTourscoolBasicsViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LYWebViewStyle){
    LYWebViewStyleNone = 1,
    LYWebViewStyleBottom
};

@interface LYWebViewController : LYTourscoolBasicsViewController
@property (nonatomic, assign) LYWebViewStyle webViewStyle;
+ (void)goTransparentWebVCWithVC:(UIViewController *)vc para:(NSDictionary * _Nullable)para;
+ (void)goPushWebVCWithVC:(UIViewController *)vc para:(NSDictionary *)para;
- (void)jumpWebHTML:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
