//
//  NSString+LYTool.m
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "NSString+LYTool.h"
#import "spelling.h"
#import <CommonCrypto/CommonDigest.h>

#import <libPhoneNumber_iOS/NBPhoneNumber.h>
#import <libPhoneNumber_iOS/NBPhoneNumberUtil.h>
#import <libPhoneNumber_iOS/NBPhoneNumberDefines.h>

@implementation NSString (LYTool)

- (BOOL)checkPhone
{
    static NSString *phoneFormat = @"(9[976]\\d|8[987530]\\d|6[987]\\d|5[90]\\d|42\\d|3[875]\\d| 2[98654321]\\d|9[8543210]|8[6421]|6[6543210]|5[87654321]| 4[987654310]|3[9643210]|2[70]|7|1)\\d{1,14}$";
    return [NSString regexWithFormat:phoneFormat ValueString:self];
}

+ (BOOL)checkInternationalPhone:(NSString *)phone telCode:(NSString *)telCode
{
    if (![NSString isPureInt:phone]) {
        return NO;
    }
    NSError *anError = nil;
    NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
    NBPhoneNumber *myNumber = [phoneUtil parse:[NSString stringWithFormat:@"+%@%@,", telCode, phone] defaultRegion:nil error:&anError];
    if (anError == nil) {
        if (![phoneUtil isValidNumber:myNumber]) {
            return NO;
        }
    }else{
        return NO;
    }
    return YES;
}

- (BOOL)isEmpty
{
    if (self == nil) {
        return YES;
    }
    if (!self.length) {
        return YES;
    }
    if ([[self trim] length] == 0) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([self isEqualToString:@"null"]) {
        return YES;
    }
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isEmpty:(NSString *)aString
{
    BOOL ret = NO;
    if ((aString == nil) || ([[aString trim] length] == 0) || [aString isKindOfClass:[NSNull class]])
        ret = YES;
    return ret;
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)filterString:(NSString *)aString
{
    if (!self.length)
    {
        return self;
    }
    
    NSMutableString *mString = [self mutableCopy];
    NSRange r = [mString rangeOfString:aString];
    while (r.location != NSNotFound)
    {
        [mString deleteCharactersInRange:r];
        r = [mString rangeOfString:aString];
    }
    
    return [mString copy];
}

- (NSString *)filterSpace
{
    return [self filterString:@" "];
}

- (NSAttributedString *)htmlString
{
    NSAttributedString *attri = [[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attri;
}

- (NSString *)interceptionPrice
{
    if (self.length) {
        return [self substringFromIndex:1];
    }
    return @"";
}

- (NSString *)undockSpecialSymbolGetOutRMB
{
    if (!self.length) {
        return @"";
    }
    NSMutableString *disposeString = [self mutableCopy];
    
    NSString *styleTagPattern = @"[`~!@#$%^ &*()+=|{}':;',\\[\\]<>/￥?~！@#%……&*（）——+|{}【】‘；：”“’。，、？  ]$€￡$YenKč＄A.R.NT$¥$";
    NSRegularExpression *styleTagRe = [NSRegularExpression regularExpressionWithPattern:styleTagPattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *resultsArray = [styleTagRe matchesInString:disposeString options:NSMatchingReportProgress range:NSMakeRange(0, disposeString.length)];
    for (NSTextCheckingResult *match in [resultsArray reverseObjectEnumerator]) {
        [disposeString replaceCharactersInRange:match.range withString:@""];
    }
    
    return [[disposeString stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}

- (NSString *)undockSpecialSymbol
{
    if (!self.length) {
        return @"";
    }
    if (!self.length) {
        return @"";
    }
    NSString * str = self;
    // NSString *styleTagPattern = @"[`~!@#$%^ &*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？  ]";
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@" _`~!@#$%^&*()+=|{}':;',\\[\\].<->/?！￥%……&*（）——【】‘；：”“’。，、？"];
    NSArray * tempStringArray = [str componentsSeparatedByCharactersInSet:doNotWant];
    str = [tempStringArray componentsJoinedByString:@""];
    
    //这里是清理前后两端空格
    NSString *tempString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    tempString  = [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return [[tempString stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

// 身份证验证
- (BOOL)isValidIdCardNum
{
    NSString *value = [self copy];
    value = [value stringByReplacingOccurrencesOfString:@"X" withString:@"x"];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return NO;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"                   options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"           options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
                
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
            
        default:
            return NO;
    }
    return NO;
}

+ (NSString *)allFirstLetter:(NSString *)aString
{
    NSMutableString *firstLetter = [NSMutableString string];
    if (![NSString isEmpty:aString]) {
        for (int i = 0; i < aString.length; i++) {
            unichar hanzi = [aString characterAtIndex:i];
            char firstLetterChar = pinyinFirstLetter(hanzi);
            if (firstLetterChar >= 'a' && firstLetterChar <= 'z') {
                firstLetterChar = firstLetterChar - 32;
            }
            if (firstLetterChar >= 'A' && firstLetterChar <= 'Z') {
                [firstLetter appendString:[NSString stringWithFormat:@"%c", firstLetterChar]];
            }
        }
    }
    return firstLetter;
}

+ (NSString *)firstLetter:(NSString *)aString {
    NSString *firstLetter = @"#";
    if (![NSString isEmpty:aString]) {
        char firstLetterChar = pinyinFirstLetter([aString characterAtIndex:0]);
        if (firstLetterChar >= 'a' && firstLetterChar <= 'z') {
            firstLetterChar = firstLetterChar - 32;
        }
        if (firstLetterChar >= 'A' && firstLetterChar <= 'Z') {
            firstLetter = [NSString stringWithFormat:@"%c", firstLetterChar];
        }
    }
    if (firstLetter.length) {
        return firstLetter;
    }
    return @"#";
}

+ (NSString *)transformNumberToFormat:(NSString *)number;
{
    NSInteger numberInt = [number integerValue];
    if (numberInt >= 10000) {
        NSInteger remainder = numberInt%10000;
        if (remainder == 0) {
            return [NSString stringWithFormat:@"%.fW", numberInt/10000.f];
        }
        return [NSString stringWithFormat:@"%.2fW", numberInt/10000.f];
    }
    if (numberInt >= 1000) {
        NSInteger remainder = numberInt % 1000;
        if (remainder == 0) {
            return [NSString stringWithFormat:@"%.fK", numberInt/1000.f];
        }
        return [NSString stringWithFormat:@"%.2fK", numberInt/1000.f];
    }
    return number;
}

+ (BOOL)isEmail:(NSString *)aEmailAddress {
    BOOL ret = YES;
    
    NSRange rangeEmail = [aEmailAddress rangeOfString:@"@"];
    if (rangeEmail.location == NSIntegerMax) {
        ret = NO;
    }
    
    return ret;
}

+ (PhoneOrEmailVerifyType)verifyPhoneOrEmail:(NSString *)aString;
{
    PhoneOrEmailVerifyType ret = PhoneOrEmailVerifyTypeEmpty;
    if ([NSString isEmpty:aString]) {
        ret = PhoneOrEmailVerifyTypeEmpty;
    } else {
        // @"[0-9]{8,20}";
        
        //        static NSString *phoneFormat = @"(\\+\\d+)?1[3458]\\d{9}$";
        static NSString *phoneFormat = @"(1[0-9][0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}";
//        static NSString *emailFormat = @"[a-zA-Z0-9_\\.-]+@[a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+";
        static NSString *emailFormat = @"\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}";
        if ([NSString isEmail:aString]) {
            if ([NSString regexWithFormat:emailFormat ValueString:aString])
                ret = PhoneOrEmailVerifyTypeEmail;
            else
                ret = PhoneOrEmailVerifyTypeNoEmail;
        } else {
            if ([NSString regexWithFormat:phoneFormat ValueString:aString])
                ret = PhoneOrEmailVerifyTypePhone;
            else
                ret = PhoneOrEmailVerifyTypeNoPhone;
        }
    }
    return ret;
}

- (BOOL)validationPasswordStrength
{
    if (!self.length) {
        return NO;
    }
    static NSString *passwordFormat = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *_Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordFormat];
    return [_Predicate evaluateWithObject:self];
}

+ (BOOL)regexWithFormat:(NSString *)aFormat ValueString:(NSString *)aValueString {
    NSPredicate *_Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", aFormat];
    return [_Predicate evaluateWithObject:aValueString];
}

+ (NSString *)stringToUTF:(NSString *)urlPath
{
    if (urlPath.length == 0) {
        return @"";
    }
    return [urlPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)stringToUTF
{
    if (self.length == 0) {
        return @"";
    }
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSString *)arrayToSting:(NSArray *)array
{
    if (array.count == 0) {
        array = @[];
    }
    NSError * error = nil;
    NSData * strData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return @"";
    }
    NSString * str = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    
    return str;
}

+ (NSString *)dicToSting:(NSDictionary *)dic
{
    if (dic.count == 0) {
        return @"";
    }
    NSError * error = nil;
    NSData * strData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return @"";
    }
    NSString * str = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    if (str.length > 0) {
        return str;
    }
    return @"";
}

+ (NSString *)createDicKeyWith:(NSString *)urlStr para:(NSDictionary *)dic
{
    if (urlStr.length == 0 || dic.count == 0) {
        return @"";
    }
    NSString * urlPath = [NSString stringToUTF:urlStr];
    NSString * dicKey = [NSString stringWithFormat:@"%@%@",urlPath,dic.description];
    if (dicKey.length == 0) {
        return @"";
    }
    return dicKey;
}

- (NSString *)md5Str
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)getMMSSFromSS:(float)totalTime{
    
    NSInteger seconds = totalTime;
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)(seconds%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
    
}

//截取首字母并且大写
+ (NSString *)transform:(NSString *)chinese
{
    if (chinese == nil || [chinese isEqualToString:@""]) {
        return @"#";
    }
    if ([self isPureInt:chinese] || [self isPureFloat:chinese]) {
        return  @"#";
    }
    return [NSString firstLetter:chinese];
}

//计算出大小
+ (NSString *)fileSizeWithInterge:(NSInteger)size
{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024.f;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024.f * 1024.f);
        return [NSString stringWithFormat:@"%.2fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024.f * 1024.f * 1024.f);
        return [NSString stringWithFormat:@"%.2fG",aFloat];
    }
}

+ (NSString *)transformChineseToPinYingWithChinese:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
    
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

+ (NSString *)obtainDayWithSecondsCountDown:(NSInteger)secondsCountDown
{
    if (secondsCountDown <= 0) {
        return @"00";
    }
    //天
    NSString *str_day = [NSString stringWithFormat:@"%02ld", (long)secondsCountDown/(3600*24)];
    return str_day;
}

+ (NSString *)obtainHourWithSecondsCountDown:(NSInteger)secondsCountDown
{
    if (secondsCountDown <= 0) {
        return @"00";
    }
    //时
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", (long)secondsCountDown/3600%24];
    return str_hour;
}

+ (NSString *)obtainMinuteWithSecondsCountDown:(NSInteger)secondsCountDown
{
    if (secondsCountDown <= 0) {
        return @"00";
    }
    // 分
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (long)(secondsCountDown%3600)/60];
    return str_minute;
}

+ (NSString *)obtainSecondWithSecondsCountDown:(NSInteger)secondsCountDown
{
    if (secondsCountDown <= 0) {
        return @"00";
    }
    // 秒
    NSString *str_second = [NSString stringWithFormat:@"%02ld", (long)secondsCountDown%60];
    return str_second;
}

+ (NSString *)weekdayToStringWithWeekday:(NSInteger)weekday
{
    if (weekday == 1) {
        return @"周日";
    }
    if (weekday == 2) {
        return @"周一";
    }
    if (weekday == 3) {
        return @"周二";
    }
    if (weekday == 4) {
        return @"周三";
    }
    if (weekday == 5) {
        return @"周四";
    }
    if (weekday == 6) {
        return @"周五";
    }
    if (weekday == 7) {
        return @"周六";
    }
    return @"";
}

+ (NSString *)numberToEmonthWithNumber:(NSString *)number
{
    NSInteger weekday = [number integerValue];
    if (weekday == 1) {
        return @"Jan";
    }
    if (weekday == 2) {
        return @"Feb";
    }
    if (weekday == 3) {
        return @"Mar";
    }
    if (weekday == 4) {
        return @"Apr";
    }
    if (weekday == 5) {
        return @"May";
    }
    if (weekday == 6) {
        return @"Jun";
    }
    if (weekday == 7) {
        return @"Jul";
    }
    if (weekday == 8) {
        return @"Aug";
    }
    if (weekday == 9) {
        return @"Sep";
    }
    if (weekday == 10) {
        return @"Oct";
    }
    if (weekday == 11) {
        return @"Nov";
    }
    if (weekday == 12) {
        return @"Dec";
    }
    return @"";
}

+ (NSString *)numberToMyriadWithNumber:(NSInteger)number
{
    if (number/10000 >= 1) {
        return [NSString stringWithFormat:@"%.2fw",number/10000.f];
    }
    return [NSString stringWithFormat:@"%@", @(number)];
}
//判断是否为整型：
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//判断是否为浮点型：
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (CGSize)getImageSizeWithURL:(NSString *)imageUrl
{
    NSString * urlEncStr = [imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * url = [NSURL URLWithString:urlEncStr];
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    if (!url) {
        return CGSizeMake(width, height);
    }
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    if (imageSource){
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
        if (imageProperties != NULL){
            CFNumberRef widthNum  = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNum != NULL) {
                CFNumberGetValue(widthNum, kCFNumberCGFloatType, &width);
            }
            CFNumberRef heightNum = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNum != NULL) {
                CFNumberGetValue(heightNum, kCFNumberCGFloatType, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSource);
        LYNSLog(@"Image dimensions: %.0f x %.0f px", width, height);
    }
    return CGSizeMake(width, height);
}

+ (NSString *)getHHMMFromSS:(NSString *)totalTime
{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", (long)seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (long)(seconds%3600)/60];
    if ([str_hour integerValue] > 0) {
        NSString *format_time = [NSString stringWithFormat:@"%@小时%@分钟",str_hour,str_minute];
        return format_time;
    }
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@分钟",str_minute];
    return format_time;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length)
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         const unichar ls = substring.length > 1 ? [substring characterAtIndex:1] : 0;
         
#define IS_IN(val, min, max) (((val) >= (min)) && ((val) <= (max)))
         
         if(IS_IN(hs, 0xD800, 0xDBFF))
         {
             if(substring.length > 1)
             {
                 const int uc = ((hs - 0xD800) * 0x400) + (ls - 0xDC00) + 0x10000;
                 
                 // Musical: [U+1D000, U+1D24F]
                 // Enclosed Alphanumeric Supplement: [U+1F100, U+1F1FF]
                 // Enclosed Ideographic Supplement: [U+1F200, U+1F2FF]
                 // Miscellaneous Symbols and Pictographs: [U+1F300, U+1F5FF]
                 // Supplemental Symbols and Pictographs: [U+1F900, U+1F9FF]
                 // Emoticons: [U+1F600, U+1F64F]
                 // Transport and Map Symbols: [U+1F680, U+1F6FF]
                 if(IS_IN(uc, 0x1D000, 0x1F9FF))
                     returnValue = YES;
             }
         }
         else if(substring.length > 1 && ls == 0x20E3)
         {
             // emojis for numbers: number + modifier ls = U+20E3
             returnValue = YES;
         }
         else
         {
             if(        // Latin-1 Supplement
                hs == 0x00A9 || hs == 0x00AE
                // General Punctuation
                ||    hs == 0x203C || hs == 0x2049
                // Letterlike Symbols
                ||    hs == 0x2122 || hs == 0x2139
                // Arrows
                ||    IS_IN(hs, 0x2194, 0x2199) || IS_IN(hs, 0x21A9, 0x21AA)
                // Miscellaneous Technical
                ||    IS_IN(hs, 0x231A, 0x231B) || IS_IN(hs, 0x23E9, 0x23F3) || IS_IN(hs, 0x23F8, 0x23FA) || hs == 0x2328 || hs == 0x23CF
                // Geometric Shapes
                ||    IS_IN(hs, 0x25AA, 0x25AB) || IS_IN(hs, 0x25FB, 0x25FE) || hs == 0x25B6 || hs == 0x25C0
                // Miscellaneous Symbols
                ||    IS_IN(hs, 0x2600, 0x2604) || IS_IN(hs, 0x2614, 0x2615) || IS_IN(hs, 0x2622, 0x2623) || IS_IN(hs, 0x262E, 0x262F)
                ||    IS_IN(hs, 0x2638, 0x263A) || IS_IN(hs, 0x2648, 0x2653) || IS_IN(hs, 0x2665, 0x2666) || IS_IN(hs, 0x2692, 0x2694)
                ||    IS_IN(hs, 0x2696, 0x2697) || IS_IN(hs, 0x269B, 0x269C) || IS_IN(hs, 0x26A0, 0x26A1) || IS_IN(hs, 0x26AA, 0x26AB)
                ||    IS_IN(hs, 0x26B0, 0x26B1) || IS_IN(hs, 0x26BD, 0x26BE) || IS_IN(hs, 0x26C4, 0x26C5) || IS_IN(hs, 0x26CE, 0x26CF)
                ||    IS_IN(hs, 0x26D3, 0x26D4) || IS_IN(hs, 0x26D3, 0x26D4) || IS_IN(hs, 0x26E9, 0x26EA) || IS_IN(hs, 0x26F0, 0x26F5)
                ||    IS_IN(hs, 0x26F7, 0x26FA)
                ||    hs == 0x260E || hs == 0x2611 || hs == 0x2618 || hs == 0x261D || hs == 0x2620 || hs == 0x2626 || hs == 0x262A
                ||    hs == 0x2660 || hs == 0x2663 || hs == 0x2668 || hs == 0x267B || hs == 0x267F || hs == 0x2699 || hs == 0x26C8
                ||    hs == 0x26D1 || hs == 0x26FD
                // Dingbats
                ||    IS_IN(hs, 0x2708, 0x270D) || IS_IN(hs, 0x2733, 0x2734) || IS_IN(hs, 0x2753, 0x2755)
                ||    IS_IN(hs, 0x2763, 0x2764) || IS_IN(hs, 0x2795, 0x2797)
                ||    hs == 0x2702 || hs == 0x2705 || hs == 0x270F || hs == 0x2712 || hs == 0x2714 || hs == 0x2716 || hs == 0x271D
                ||    hs == 0x2721 || hs == 0x2728 || hs == 0x2744 || hs == 0x2747 || hs == 0x274C || hs == 0x274E || hs == 0x2757
                ||    hs == 0x27A1 || hs == 0x27B0 || hs == 0x27BF
                // CJK Symbols and Punctuation
                ||    hs == 0x3030 || hs == 0x303D
                // Enclosed CJK Letters and Months
                ||    hs == 0x3297 || hs == 0x3299
                // Supplemental Arrows-B
                ||    IS_IN(hs, 0x2934, 0x2935)
                // Miscellaneous Symbols and Arrows
                ||    IS_IN(hs, 0x2B05, 0x2B07) || IS_IN(hs, 0x2B1B, 0x2B1C) || hs == 0x2B50 || hs == 0x2B55
                )
             {
                 returnValue = YES;
             }
         }
         
#undef IS_IN
     }];
    
    return returnValue;
}


- (NSAttributedString *)setupAttributedStrikethrough
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attrStr.length)];
    return attrStr;
}

- (NSAttributedString *)setupDetailsPriceAttributed
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self];
    [attrStr addAttribute:NSFontAttributeName value:[LYTourscoolAPPStyleManager ly_pingFangSCSemibold_12] range:NSMakeRange(0, 1)];
    [attrStr addAttribute:NSFontAttributeName value:[LYTourscoolAPPStyleManager ly_pingFangSCSemibold_24] range:NSMakeRange(1, attrStr.length - 1)];
    return attrStr;
}

+ (NSAttributedString *)setCouponStyle:(NSString *)one oneHex:(NSString *)oneHex oneFont:(UIFont *)oneFont
                                   two:(NSString *)two twoHex:(NSString *)twoHex twoFont:(UIFont *)twoFont
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@", one, two]];
    if (oneHex.length) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:oneHex] range:NSMakeRange(0, one.length)];
    }
    
    [attrStr addAttribute:NSFontAttributeName value:oneFont range:NSMakeRange(0, one.length)];
    if (twoHex.length) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:twoHex] range:NSMakeRange(one.length, two.length)];
    }
    [attrStr addAttribute:NSFontAttributeName value:twoFont range:NSMakeRange(one.length, two.length)];
    return attrStr;
}

+ (NSAttributedString *)setupMineOtherMSGAttributedStrWithMSG:(NSString *)msg
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", msg]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"00ABF9"] range:NSMakeRange(0, msg.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont obtainPingFontWithStyle:LYPingFangSCRegular size:12.f] range:NSMakeRange(0, msg.length)];
    return attrStr;
}

+ (NSAttributedString *)setupMineOtherMSGAttributedStrWith:(NSString *)number msg:(NSString *)msg
{
    NSString * space = @"\n";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@", number, space, msg]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"00ABF9"] range:NSMakeRange(0, number.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont obtainPingFontWithStyle:LYPingFangSCSemibold size:16.f] range:NSMakeRange(0, number.length)];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"A2A2A2"] range:NSMakeRange(number.length, msg.length + space.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont obtainPingFontWithStyle:LYPingFangSCRegular size:12.f] range:NSMakeRange(number.length, msg.length + space.length)];
    return attrStr;
}

+ (NSString *)jointImagePathWithWidth:(CGFloat)width height:(CGFloat)height imagePath:(NSString *)imagePath
{
    if (!imagePath.length) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@/%.fx%.f", imagePath, width * [[UIScreen mainScreen] scale],height * [[UIScreen mainScreen] scale]];
}

+ (NSString *)cacheFolderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

+ (void)removeFolderPathInCache:(NSString *)aFolderName
{
    NSString *folderPath = [[self cacheFolderPath] stringByAppendingPathComponent:aFolderName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        NSError *err = nil;
        [[NSFileManager defaultManager] removeItemAtPath:folderPath error:&err];
        LYNSLog(@"%@", err);
    }
}

+ (NSString *)folderPathInCache:(NSString *)aFolderName {
    NSString *folderPath = [[self cacheFolderPath] stringByAppendingPathComponent:aFolderName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        NSError *err = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&err];
    }
    return folderPath;
}

+ (NSString *)removeDecimal:(NSString *)sourceString{
    NSRange range;
    range = [sourceString rangeOfString:@"."];
    if (range.location == NSNotFound) {
        return sourceString;
    }else{
        return  [sourceString substringToIndex:range.location];
    }
}

#pragma mark - 临时处理

+ (NSString *)changeLinkUrlToNewRouterWithLinkUrl:(NSString *)linkUrl
{
    NSString * currentLinkUrl = linkUrl;
    if ([linkUrl hasPrefix:@"tourscool://open/ProductListVC"]) {
        currentLinkUrl = [linkUrl stringByReplacingOccurrencesOfString:@"tourscool://open/ProductListVC"withString:[LYRouterManager jointURLPattern:ProductListViewControllerKey]];
    }
    if ([linkUrl hasPrefix:@"tourscool://open/WebVC"]) {
        currentLinkUrl = [linkUrl stringByReplacingOccurrencesOfString:@"tourscool://open/WebVC?urlPath"withString:[NSString stringWithFormat:@"%@?url_path", [LYRouterManager jointURLPattern:WebViewControllerKey]]];
    }
    return currentLinkUrl;
}

+ (id)readLocalFileWithName:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
}

+ (NSString *)stringDisposeWithFloat:(float)floatValue{
    NSString *str = [NSString stringWithFormat:@"%.1f",floatValue];
    long len = str.length;
    for (int i = 0; i < len; i++){
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."]){
        return [str substringToIndex:[str length]-1];
    }
    else{
        return str;
    }
}
@end
