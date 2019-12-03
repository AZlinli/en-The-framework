//
//  NSString+LYTool.h
//  ToursCool
//
//  Created by tourscool on 10/24/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, PhoneOrEmailVerifyType) {
    /** 为空 */
    PhoneOrEmailVerifyTypeEmpty = 0,
    /** 电话号码 */
    PhoneOrEmailVerifyTypePhone = 1,
    /** 邮件箱 */
    PhoneOrEmailVerifyTypeEmail = 2,
    /** 不是正常的电话号码 */
    PhoneOrEmailVerifyTypeNoPhone = 3,
    /** 不是正常的邮件箱 */
    PhoneOrEmailVerifyTypeNoEmail = 4,
} ;
NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYTool)
/**
 判断是否为空字符串

 @return YES 为空
 */
- (BOOL)isEmpty;

/**
 去除首位空格

 @return NSString
 */
- (NSString *)trim;

/**
 过滤字符串

 @param aString 需要过滤的字符串
 @return 返回过滤之后的字符串
 */
- (NSString *)filterString:(NSString *)aString;


/**
html格式化字符串

@return 返回无空格字符串
*/
- (NSAttributedString *)htmlString;

/**
 过滤空格字符

 @return 返回无空格字符串
 */
- (NSString *)filterSpace;

/**
 身份证验证
 
 @return yes
 */
- (BOOL)isValidIdCardNum;
#pragma mark -- 空格处理
/**
 去除特殊符号
 
 @return string
 */
- (NSString *)undockSpecialSymbol;
- (NSString *)undockSpecialSymbolGetOutRMB;
- (NSString *)interceptionPrice;

#pragma mark -- 中文字符串的首字母
/**
 *  @brief 中文字符串的首字母
 *
 *  @param aString 字文字符串
 *
 *  @return 首字母
 */
+ (NSString *)firstLetter:(NSString *)aString;
/**
 中文字符字母
 
 @param aString 字文字符串
 @return 首字母
 */
+ (NSString *)allFirstLetter:(NSString *)aString;
#pragma mark -- 判断字符串
/**
 *  @brief 判断输入数据是否是邮箱
 *
 *  @param aEmailAddress 判断字符串
 *
 *  @return 是否是邮箱
 */
+ (BOOL)isEmail:(NSString *)aEmailAddress;

/**
 *  @brief 验证电话号码是否正确
 *
 *  @return 是否正确
 */
+ (PhoneOrEmailVerifyType)verifyPhoneOrEmail:(NSString *)aString;
+ (BOOL)checkInternationalPhone:(NSString *)phone telCode:(NSString *)telCode;
- (BOOL)checkPhone;
/**
 *  @brief 正则表达式
 *
 *  @param aFormat      表达式
 *  @param aValueString 判断的字符串
 *
 *  @return 是否满足正则表达式
 */
+ (BOOL)regexWithFormat:(NSString *)aFormat ValueString:(NSString *)aValueString;
/**
 密码强度验证
 @return f是否满足
 */
- (BOOL)validationPasswordStrength;

/**
 url中文处理
 
 @param urlPath URL地址
 @return 处理后的urlString
 */
+ (NSString *)stringToUTF:(NSString *)urlPath;
- (NSString *)stringToUTF;
/**
 字典转字符串
 
 @param dic 字典
 @return 字符串
 */
+ (NSString *)dicToSting:(NSDictionary *)dic;
/**
 数字转换字符串

 @param array 数组
 @return 字符串
 */
+ (NSString *)arrayToSting:(NSArray *)array;
/**
 URL地址和参数拼str
 
 @param urlStr URL地址
 @param dic 参数
 @return string
 */
+ (NSString *)createDicKeyWith:(NSString *)urlStr para:(NSDictionary *)dic;
/**
 md5 16
 
 @return md5string
 */
- (NSString *)md5Str;
/**
 时间转换

 @param totalTime 秒
 @return 00:00
 */
+ (NSString *)getMMSSFromSS:(float)totalTime;
/**
 星期几
 
 @param weekday weekday
 @return 星期几
 */
+ (NSString *)weekdayToStringWithWeekday:(NSInteger)weekday;
/**
 数字月份转化

 @param number 月份
 @return 英文月份
 */
+ (NSString *)numberToEmonthWithNumber:(NSString *)number;
/**
 数字转化

 @param number 数字
 @return 10W
 */
+ (NSString *)numberToMyriadWithNumber:(NSInteger)number;
+ (NSString *)obtainDayWithSecondsCountDown:(NSInteger)secondsCountDown;
+ (NSString *)obtainHourWithSecondsCountDown:(NSInteger)secondsCountDown;
+ (NSString *)obtainMinuteWithSecondsCountDown:(NSInteger)secondsCountDown;
+ (NSString *)obtainSecondWithSecondsCountDown:(NSInteger)secondsCountDown;
/**
 截取首字母并且大写
 
 @param chinese 汉子
 @return 首字母
 */
+ (NSString *)transform:(NSString *)chinese;
+ (NSString *)transformNumberToFormat:(NSString *)number;

//去除小数点 直接去掉（非四舍五入）价格后面小数点；（例如：￥18.99，去掉小数点后的数字，展示为￥18）
+ (NSString *)removeDecimal:(NSString *)sourceString;

/**
 判断是否为整型
 
 @param string string
 @return YES
 */
+ (BOOL)isPureInt:(NSString*)string;
/**
 是否浮点型
 
 @param string string
 @return YES
 */
+ (BOOL)isPureFloat:(NSString*)string;
/**
 是否是汉字
 
 @return YES
 */
- (BOOL)isChinese;

/**
 是否包含汉字
 
 @return YES
 */
- (BOOL)includeChinese;
/**
 汉字转拼音
 
 @param chinese 汉字
 @return 拼音
 */
+ (NSString *)transformChineseToPinYingWithChinese:(NSString *)chinese;
/**
 时间转化秒->小时分钟

 @param totalTime 秒
 @return 小时分钟
 */
+ (NSString *)getHHMMFromSS:(NSString *)totalTime;
/**
 磁盘大小

 @param size k
 @return 字符串
 */
+ (NSString *)fileSizeWithInterge:(NSInteger)size;
/**
 获取图片

 @param imageUrl 图片地址
 @return 大小
 */
+ (CGSize)getImageSizeWithURL:(NSString *)imageUrl;
/**
 拼接图片地址

 @param width 宽
 @param height 高
 @param imagePath 图片地址
 @return (width*[[UIScreen mainScreen] scale])x(height*[[UIScreen mainScreen] scale])
 */
+ (NSString *)jointImagePathWithWidth:(CGFloat)width height:(CGFloat)height imagePath:(NSString *)imagePath;
/**
 删除Cache文件

 @param aFolderName 文件名字
 */
+ (void)removeFolderPathInCache:(NSString *)aFolderName;
+ (NSString *)folderPathInCache:(NSString *)aFolderName;
/**
 下划线

 @return NSAttributedString
 */
- (NSAttributedString *)setupAttributedStrikethrough;
+ (NSAttributedString *)setupMineOtherMSGAttributedStrWith:(NSString *)number msg:(NSString *)msg;
+ (NSAttributedString *)setupMineOtherMSGAttributedStrWithMSG:(NSString *)msg;

+ (NSAttributedString *)setCouponStyle:(NSString *)one oneHex:(NSString *)oneHex oneFont:(UIFont *)oneFont
                                   two:(NSString *)two twoHex:(NSString *)twoHex twoFont:(UIFont *)twoFont;

+ (NSString *)changeLinkUrlToNewRouterWithLinkUrl:(NSString *)linkUrl;
- (NSAttributedString *)setupDetailsPriceAttributed;
+ (id)readLocalFileWithName:(NSString *)name;
/**
浮点数转string，去除0，保留1位小数
*/
+ (NSString *)stringDisposeWithFloat:(float)floatValue;
@end

NS_ASSUME_NONNULL_END
