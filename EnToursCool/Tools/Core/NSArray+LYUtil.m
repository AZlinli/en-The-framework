//
//  NSArray+LYUtil.m
//  myTools
//
//  Created by 罗勇 on 2016/11/25.
//  Copyright © 2016年 saber. All rights reserved.
//

#import "NSArray+LYUtil.h"

@implementation NSArray (LYUtil)

+ (BOOL)isArray:(id)obj
{
    return obj && [obj isKindOfClass:[NSArray class]];
}

+ (BOOL)isEmpty:(id)obj
{
    return ![NSArray isArray:obj] || [((NSArray *)obj)isEmpty];
}

- (BOOL)isEmpty
{
    if (self == nil)
        return YES;
    return (BOOL)(self.count == 0);
}

- (NSArray *)removeDuplicate
{
    if (!self.count) {
        return @[];
    }
    NSOrderedSet * orderedSet = [[NSOrderedSet alloc] initWithArray:self];
    return [orderedSet array];
}

- (id)objectAt:(NSUInteger)index
{
    if (index < self.count) {
        return self[index];
    }
    return nil;
}

@end
