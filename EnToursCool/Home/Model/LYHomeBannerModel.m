//
//  LYHomeBannerModel.m
//  ToursCool
//
//  Created by tourscool on 12/7/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeBannerModel.h"
#import "NSString+LYTool.h"

@implementation LYHomeBannerModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"banner":@"LYHomeBannerItemModel"};
}
@end

@implementation LYHomeBannerItemModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"linkUrl":@"link",@"imageUrl":@"image"};
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    self.linkUrl = [NSString changeLinkUrlToNewRouterWithLinkUrl:self.linkUrl];
}

@end

