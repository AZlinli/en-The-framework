//
//  LYDetailTableHeaderModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailTableHeaderModel.h"
#import "NSObject+LYCalculatedHeightWidth.h"

@implementation LYDetailTableHeaderModel

- (CGFloat)tableHeaderH {
    CGFloat bannerH = 300;
    
    CGFloat titleLabelW = kScreenWidth - 16 - 16;
    CGFloat titleLabelH = ceil([self getHeightWithText:self.title width:titleLabelW font:[LYTourscoolAPPStyleManager ly_ArialBold_16]]);
    CGFloat titleLabelAllH = titleLabelH;
    
    CGFloat starViewH = 20 + 10 + 10;
    
    CGFloat bestsellerH = 15 + 10;
    
    CGFloat currentPriceLabelH = 17 + 10;
    
    CGFloat saleLabelH = 15 + 10;
    
    CGFloat tagCollectionViewH;
    
    CGFloat tagCollectionViewW = kScreenWidth - 16 - 16;

    CGFloat tagAllW = 0.0;
    //所有tag的k计算宽度
    for (NSString *tag in self.tagArray) {
        tagAllW += [self getWidthWithText:tag height:18 font:[LYTourscoolAPPStyleManager ly_ArialRegular_10]] + 18;
    }
    //tag之间的间隙
    tagAllW += (self.tagArray.count - 1) * 8;
    
    //如果当前collectionView的宽度小于所有tag的计算值，则需要两行显示
    if (tagCollectionViewW < tagAllW) {
        tagCollectionViewH = 15 + 42;
    }else{
        if (self.tagArray.count == 0) {
            tagCollectionViewH = 0;
        }else{
            tagCollectionViewH = 15 + 18;
        }
    }
    
    CGFloat headerH = bannerH + titleLabelAllH + starViewH + bestsellerH + currentPriceLabelH + saleLabelH + tagCollectionViewH;
    return headerH;
}
@end
