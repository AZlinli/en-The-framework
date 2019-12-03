//
//  AppDelegate.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/6.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) void (^backgroundCompletionHandler)(void);
@end

