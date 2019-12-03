//
//  LYBaseModel.m
//  LYBook
//
//  Created by luoyong on 2018/9/28.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import "LYBaseModel.h"
static NSString * ReuseIdentifier;
@implementation LYBaseModel

+ (instancetype)ly_objectWithKeyValues:(id)object cellID:(NSString *)cellID
{
    ReuseIdentifier = cellID;
    return [super mj_objectWithKeyValues:object];
}

+ (NSMutableArray *)ly_objectArrayWithKeyValuesArray:(id)object cellID:(NSString *)cellID
{
    ReuseIdentifier = cellID;
    return [super mj_objectArrayWithKeyValuesArray:object];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    self.cellReuseIdentifier = ReuseIdentifier;
}
@end
