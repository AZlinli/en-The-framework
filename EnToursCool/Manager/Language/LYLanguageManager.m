//
//  LYLanguageManager.m
//  ToursCool
//
//  Created by tourscool on 4/24/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYLanguageManager.h"

static LYLanguageManager * languageManager = nil;


@implementation LYSupportLanguageModel

@end


@interface LYLanguageManager ()
@property (nonatomic, weak) NSBundle * languageBundle;
@property (nonatomic, copy) NSString * userLanguage;
@end

@implementation LYLanguageManager

+ (LYLanguageManager *)sharedLanguageManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languageManager = [[LYLanguageManager alloc] init];
    });
    return languageManager;
}

+ (void)resetSystemLanguage
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserLanguageKey];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)userLanguage
{
    if ([LYLanguageManager sharedLanguageManager].userLanguage) {
        return [LYLanguageManager sharedLanguageManager].userLanguage;
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserLanguageKey];
}

+ (void)setUserLanguage:(NSString *)userLanguage
{
    [LYLanguageManager saveUserLanguage:userLanguage type:YES];
}

+ (void)saveUserLanguage:(NSString *)userLanguage type:(BOOL)type
{
    if ([[LYLanguageManager sharedLanguageManager].userLanguage isEqualToString:userLanguage]) {
        return;
    }
    [LYLanguageManager sharedLanguageManager].userLanguage = userLanguage;
    [LYLanguageManager sharedLanguageManager].languageBundle = nil;
    if (!userLanguage.length) {
        [self resetSystemLanguage];
        return;
    }
    if (type) {
        [[NSUserDefaults standardUserDefaults] setValue:userLanguage forKey:kUserLanguageKey];
        [[NSUserDefaults standardUserDefaults] setValue:@[userLanguage] forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)setUserSystemLanguage:(NSString *)userLanguage
{
    [LYLanguageManager saveUserLanguage:userLanguage type:NO];
}

+ (void)systemUserLanguage
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserLanguageKey]) {
        return;
    }
    NSString *udfLanguageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
    if ([udfLanguageCode hasPrefix:@"zh-Hans"]) {
        [LYLanguageManager setUserSystemLanguage:@"zh-Hans-CN"];
    }else{
        [LYLanguageManager setUserSystemLanguage:@"English"];
    }
}

+ (NSString *)currentLanguage
{
    if ([LYLanguageManager userLanguage]) {
        return [LYLanguageManager userLanguage];
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
}

+ (NSString *)currentServerLanguage
{
    NSString *language = [LYLanguageManager currentLanguage];
    if ([language hasPrefix:@"zh-Hans"]) {
        return @"zh-CN";
    }
    return @"zh-TW";
}

+ (NSBundle *)obtainLanguageBundle
{
    if (![LYLanguageManager sharedLanguageManager].languageBundle) {
        NSString *language = [LYLanguageManager currentLanguage];
        if ([language hasPrefix:@"zh-Hant-TW"]) {
            language = @"zh-Hant-TW";
        } else {
            language = @"en";
        }
        [LYLanguageManager sharedLanguageManager].languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]];
    }
    return [LYLanguageManager sharedLanguageManager].languageBundle;
}

+ (NSString *)ly_localizedStringForKey:(NSString *)key
{
    NSBundle * bundle = [LYLanguageManager obtainLanguageBundle];
    return [bundle localizedStringForKey:key value:nil table:nil];
}

+ (NSString *)ly_stringLocalizedStringForKey:(NSString *)key comment:(NSString *)comment
{
    NSBundle * bundle = [LYLanguageManager obtainLanguageBundle];
    return [NSString localizedStringWithFormat:NSLocalizedStringFromTableInBundle(key, nil, bundle, nil),comment];
}

+ (NSString *)ly_macroLocalizedStringForKey:(NSString *)key comment:(NSInteger)comment
{
    NSBundle * bundle = [LYLanguageManager obtainLanguageBundle];
    return [NSString localizedStringWithFormat:NSLocalizedStringFromTableInBundle(key, nil, bundle, nil),comment];
}

+ (NSArray *)obtainSupportLanguage
{
    LYSupportLanguageModel * englishModel = [[LYSupportLanguageModel alloc] init];
    englishModel.appleLanguageName = @"English";
    englishModel.serverLanguageName = @"English"; //todo
    englishModel.languageContent = @"English";
    englishModel.select = [englishModel.appleLanguageName isEqualToString:[LYLanguageManager currentLanguage]];
    
    
    return @[englishModel];
}

@end
