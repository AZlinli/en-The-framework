//
//  LYDetailExpenseModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/26.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailExpenseModel.h"
#import "NSObject+LYCalculatedHeightWidth.h"

@implementation LYDetailExpenseModel

@end

@implementation LYDetailExpenseModelItem
- (CGFloat)highlightsCellH {
    if (self.heightDict[@"highlightsCellH"]) {
        NSNumber * highlightsCellHNum = self.heightDict[@"highlightsCellH"];
        return [highlightsCellHNum floatValue];
    }
    CGFloat titleH = 14 + 10;
    CGFloat textW = kScreenWidth - 30 - 30 - 10;
    CGFloat textH = ceil([self getHeightWithText:self.text width:textW font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]]);
    CGFloat seeMoreButtonH = 20 + 14 + 10;
    CGFloat allCellH = titleH + textH + seeMoreButtonH;
    self.heightDict[@"highlightsCellH"] = @(allCellH);
    return allCellH;
}

- (CGFloat)highlightsExceptSeemoreButtonCellH {
    if (self.heightDict[@"highlightsExceptSeemoreButtonCellH"]) {
        NSNumber * highlightsCellHNum = self.heightDict[@"highlightsExceptSeemoreButtonCellH"];
        return [highlightsCellHNum floatValue];
    }
    CGFloat titleH = 14 + 10;
    CGFloat textW = kScreenWidth - 30 - 30 - 10;
    CGFloat textH = ceil([self getHeightWithText:self.text width:textW font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]]);
    CGFloat allCellH = titleH + textH + 10;
    self.heightDict[@"highlightsExceptSeemoreButtonCellH"] = @(allCellH);
    return allCellH;
}

- (CGFloat)fixationHighlightsCellH {
    if (self.heightDict[@"fixationHighlightsCellH"]) {
        NSNumber * highlightsCellHNum = self.heightDict[@"fixationHighlightsCellH"];
        return [highlightsCellHNum floatValue];
    }
    CGFloat titleH = 14 + 10;
    CGFloat seeMoreButtonH = 20 + 14 + 10;
    CGFloat allCellH = 18 * 5 + titleH + seeMoreButtonH;
    self.heightDict[@"fixationHighlightsCellH"] = @(allCellH);
    return allCellH;
}

- (BOOL)isFixationHighlightsCellH {
    return self.highlightsCellH >= self.fixationHighlightsCellH;
}

- (NSMutableDictionary *)heightDict {
    if (!_heightDict) {
        _heightDict = [NSMutableDictionary dictionary];
    }
    return _heightDict;
}

@end


