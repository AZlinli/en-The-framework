//
//  LYHomeMenuModel.m
//  ToursCool
//
//  Created by tourscool on 12/7/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeMenuModel.h"
#import "NSString+LYTool.h"

@implementation LYHomeMenuModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"nav":@"LYHomeMenuItemModel"};
}
 
@end

@implementation LYHomeMenuItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"jumpUrl":@"nav_link",@"imageUrl":@"nav_image",@"title":@"nav_title"};
}


- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    self.jumpUrl = [NSString changeLinkUrlToNewRouterWithLinkUrl:self.jumpUrl];
}

@end

