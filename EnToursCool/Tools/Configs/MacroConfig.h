//
//  MacroConfig.h
//  GAIA供应
//
//  Created by winter on 2017/8/21.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#ifndef MacroConfig_h
#define MacroConfig_h

#import "NSString+LYTool.h"

//检测block是否可用
#define OBJC_BLOCK_EXEC(block, ...) do { if(block){block(__VA_ARGS__);}else{NSLog(@"block未实现:%p",block);} }while(0)

//主线程异步队列
#define dispatch_async_main_safe(block) [NSThread isMainThread]? block() : dispatch_async(dispatch_get_main_queue(), block);
//主线程同步队列
#define dispatch_sync_main_safe(block) [NSThread isMainThread]? block() : dispatch_sync(dispatch_get_main_queue(), block);


//字符串是否相等
#define STR_EQUAL(src, des) [src isEqualToString:des]
#define str_equal(src, des) STR_EQUAL(src, des)

//异或关系运算
#define XRL(A, B) ((!(A) && (B)) || ((A) && !(B)))
#define xrl(a, b) XRL(a, b)

//字符串连接
#define strapd(str1, str2)  [NSString stringWithFormat:@"%@%@", str1, str2]

//弹框
#define alert(msg)  toast(msg)

#if 1
/**
 *  @author ldl, 16-10-20 10:10:39
 *
 *  <参数宏>显示错误消息的alert，若没有错误详情，则不显示
 *
 *  @param error 传入NSError对象
 */
#define errorAlert(error) \
do \
{ \
    if ([error isKindOfClass:[NSError class]]) \
    { \
        NSString *msg = error.userInfo[NSLocalizedDescriptionKey]; \
        toast(msg); \
    } \
}while(0)
#else
    #define errorAlert(error) do {GALog(@"%@", error);}while(0)
#endif


/**
 模仿安卓的Toast功能
 
 @param string 文本字符串
 */
#define toast(string) \
do \
{ \
    NSString *text = string;    \
    if ([text isKindOfClass:[NSString class]] && [text length]) {  \
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES]; \
        [MBProgressHUD showText:text afterDelay:3]; \
    } \
} while(0)


#endif /* MacroConfig_h */
