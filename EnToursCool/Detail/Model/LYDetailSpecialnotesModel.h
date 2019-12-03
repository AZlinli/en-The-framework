//
//  LYDetailSpecialnotesModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/26.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYDetailBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYDetailSpecialnotesModel : LYDetailBaseModel
/**组名*/
@property(nonatomic, copy) NSString *sectionTitle;
/**是否展开*/
@property (nonatomic, strong) NSNumber * showMore;
/**内容*/
@property(nonatomic, copy) NSString *text;
/**内容*/
@property(nonatomic, copy) NSAttributedString *attributedStringtext;
@end

NS_ASSUME_NONNULL_END
