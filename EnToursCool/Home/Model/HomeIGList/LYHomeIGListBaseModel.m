//
//  LYHomeIGListBaseModel.m
//  ToursCool
//
//  Created by tourscool on 12/21/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeIGListBaseModel.h"

@implementation LYHomeIGListBaseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"moduleName":@"module_name"};
}

- (void)setFooterHeight:(CGFloat)footerHeight
{
    if (footerHeight > 0) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:self.collectionElementKindSectionArray];
        [array addObject:UICollectionElementKindSectionFooter];
        self.collectionElementKindSectionArray = [array copy];
    }
    _footerHeight = footerHeight;
}

- (void)setHeaderHeight:(CGFloat)headerHeight
{
    if (headerHeight > 0) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:self.collectionElementKindSectionArray];
        [array addObject:UICollectionElementKindSectionHeader];
        self.collectionElementKindSectionArray = [array copy];
    }
    _headerHeight = headerHeight;
}

@end
