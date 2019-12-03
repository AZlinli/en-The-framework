//
//  LYLanguageManager.h
//  ToursCool
//
//  Created by tourscool on 4/24/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYSupportLanguageModel : NSObject
@property (nonatomic , copy) NSString              * appleLanguageName;
@property (nonatomic , copy) NSString              * serverLanguageName;
@property (nonatomic , copy) NSString              * languageContent;
@property (nonatomic , assign) BOOL select;
@end



@interface LYLanguageManager : NSObject
/**
 设置用户语言

 @param userLanguage 语言
 */
+ (void)setUserLanguage:(NSString * _Nullable)userLanguage;
/**
 获取NSUserDefaults 语言

 @return 语言
 */
+ (NSString *)userLanguage;
/**
 获取当前语言

 @return 语言
 */
+ (NSString *)currentLanguage;
/**
 获取上传给服务器语言

 @return 语言
 */
+ (NSString *)currentServerLanguage;
+ (NSString *)ly_localizedStringForKey:(NSString *)key;
+ (NSString *)ly_macroLocalizedStringForKey:(NSString *)key comment:(NSInteger)comment;
+ (NSString *)ly_stringLocalizedStringForKey:(NSString *)key comment:(NSString *)comment;
/**
 支持语言
 
 @return NSArray 语言
 */
+ (NSArray *)obtainSupportLanguage;

/**
 获取系统语言设置APP当前语言
 */
+ (void)systemUserLanguage;
@end

NS_ASSUME_NONNULL_END
