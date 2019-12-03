//
//  LYBaseIGListDiffableModel.m
//  LYIGListKitTest
//
//  Created by tourscool on 2/15/19.
//  Copyright © 2019 Saber. All rights reserved.
//

#import "LYBaseIGListDiffableModel.h"

@implementation LYBaseIGListDiffableModel

- (id<NSObject>)diffIdentifier
{
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object
{
    return [self isEqual:object];
}



@end
