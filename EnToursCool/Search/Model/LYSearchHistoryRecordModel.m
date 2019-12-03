//
//  LYSearchHistoryRecordModel.m
//  ToursCool
//
//  Created by tourscool on 12/5/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSearchHistoryRecordModel.h"
//#import "NSString+LYSize.h"

@implementation LYSearchHistoryRecordModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"searchHistoryRecordid":@"id"};
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    if (self.title.length) {
        self.name = self.title;
    }
//    self.itemCellReuseIdentifier = @"LYSearchHistoryCollectionViewCellID";
//    self.itemWidth = [self.name widthWithFont:[LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_14] constrainedToHeight:34.f] + 24.f;
//    self.itemHeight = 34.f;
}

@end
