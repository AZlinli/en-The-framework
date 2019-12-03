//
//  UILabel+Extension.h
//  地球仓
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 com.diqiucang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

/**
 *  改变行间距
 */
- (void)changeLineSpace:(float)space;

/**
 *  改变字间距
 */
- (void)changeWordSpace:(float)space;

/**
 *  改变行间距和字间距
 */
- (void)changeLineSpace:(float)space WordSpace:(float)wordSpace;


@end

NS_ASSUME_NONNULL_END
