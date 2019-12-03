//
//  LYRouteListModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYRouteListModel.h"
#import "NSObject+LYCalculatedHeightWidth.h"

@implementation LYRouteListModel

@end

@implementation LYRouteListContentTextModel

- (CGFloat)contentTextCellH {
    CGFloat width = kScreenWidth - 39 - 20 - 37;
    CGFloat contentTextH = [self getHeightWithText:self.text width:width font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    CGFloat allH = contentTextH + 20 + 7;
    return  allH;
}
@end

@implementation LYRouteListScenicSpotModel
- (CGFloat)scenicSpotCellH {
    CGFloat width = kScreenWidth - 39 - 20 - 37;
    CGFloat textHeight = [self getHeightWithText:self.text width:width font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    CGFloat botImageH = 7 + 17;
    CGFloat collectionH = 110 + 10 + 10;
    CGFloat allH = textHeight + botImageH + collectionH + 10;
    return allH;
}
@end

@implementation LYRouteListhHotelModel
- (CGFloat)hotelCellH {
    CGFloat width = kScreenWidth - 39 - 20 - 37;
    CGFloat textHeight = [self getHeightWithText:self.text width:width font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    CGFloat botImageH = 7 + 17;
    CGFloat allH = textHeight + botImageH + 10 + 10;
    return allH;
}
@end

@implementation LYRouteListhMealsModel
- (CGFloat)mealsCellH {
    CGFloat width = kScreenWidth - 39 - 20 - 37;
    CGFloat textHeight = [self getHeightWithText:self.text width:width font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]];
    CGFloat botImageH = 7 + 17;
    CGFloat allH = textHeight + botImageH + 10 + 10;
    return allH;
}
@end
