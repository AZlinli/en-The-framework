//
//  LYConfigurationCellIdentifier.h
//  LYBook
//
//  Created by luoyong on 2018/9/28.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYConfigurationCellIdentifier <NSObject>
@optional
+ (NSMutableArray *)ly_objectArrayWithKeyValuesArray:(id)object cellID:(NSString *)cellID;
+ (instancetype)ly_objectWithKeyValues:(id)object cellID:(NSString *)cellID;
@end
