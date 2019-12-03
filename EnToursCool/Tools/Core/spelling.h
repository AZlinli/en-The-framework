//
//  spelling.h
//  CommonLayer
//

//

#import <Foundation/Foundation.h>

@interface spelling : NSObject

/**
 *  @brief 拼音首字母
 *
 *  @param hanzi 汉字
 *
 *  @return 首字母
 */
char pinyinFirstLetter(unsigned short hanzi);

@end
