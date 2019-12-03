//
//  LYFullPageAdvertisementModel.m
//  ToursCool
//
//  Created by tourscool on 3/26/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import "LYFullPageAdvertisementModel.h"

@implementation LYFullPageAdvertisementModel
MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"imageUrl":@"image_url",
             @"linkUrl":@"link_url",
             @"showSecond":@"show_second",
             @"isActive":@"is_active",
             @"isCache":@"is_cache"};
}

@end
