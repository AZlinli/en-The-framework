//
//  LYDetailHighlightsModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailHighlightsModel.h"
#import "NSObject+LYCalculatedHeightWidth.h"

@implementation LYDetailHighlightsModel

- (CGFloat)highlightsCellH {
    if (self.heightDict[@"highlightsCellH"]) {
        NSNumber * highlightsCellHNum = self.heightDict[@"highlightsCellH"];
        return [highlightsCellHNum floatValue];
    }
    CGFloat titleH = 20 + 17 + 16;
    CGFloat textW = kScreenWidth - 16 - 16;
    CGFloat textH = ceil([self getHeightWithText:self.text width:textW font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]]);
    CGFloat seeMoreButtonH = 20 + 14 + 20;
    CGFloat allCellH = titleH + textH + seeMoreButtonH;
    self.heightDict[@"highlightsCellH"] = @(allCellH);
    return allCellH;
}

- (CGFloat)highlightsExceptSeemoreButtonCellH {
    if (self.heightDict[@"highlightsExceptSeemoreButtonCellH"]) {
        NSNumber * highlightsCellHNum = self.heightDict[@"highlightsExceptSeemoreButtonCellH"];
        return [highlightsCellHNum floatValue];
    }
    CGFloat titleH = 20 + 17 + 16;
    CGFloat textW = kScreenWidth - 16 - 16;
    CGFloat textH = ceil([self getHeightWithText:self.text width:textW font:[LYTourscoolAPPStyleManager ly_ArialRegular_14]]);
    CGFloat allCellH = titleH + textH + 20;
    self.heightDict[@"highlightsExceptSeemoreButtonCellH"] = @(allCellH);
    return allCellH;
}

- (CGFloat)fixationHighlightsCellH {
    if (self.heightDict[@"fixationHighlightsCellH"]) {
        NSNumber * highlightsCellHNum = self.heightDict[@"fixationHighlightsCellH"];
        return [highlightsCellHNum floatValue];
    }
    CGFloat titleH = 20 + 17 + 16;
    CGFloat seeMoreButtonH = 20 + 14 + 20;
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
