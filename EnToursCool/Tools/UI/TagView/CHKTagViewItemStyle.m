//
//  CHKTagViewItemStyle.m
//  CHKTagView
//
//  Created by Hongkai Cui on 2017/11/23.
//  Copyright © 2017年 崔洪凯. All rights reserved.
//

#import "CHKTagViewItemStyle.h"

@implementation CHKTagViewItemStyle

- (instancetype)initWithType:(CHKTagViewItemStyleType)type
{
    self = [super init];
    if (self) {
        switch (type) {
            case CHKTagViewItemStyleTypeDetailInfo:
            {
                self.textColorNormal = [LYTourscoolAPPStyleManager ly_AEAEAEColor];
                self.textColorSelected = [LYTourscoolAPPStyleManager ly_AEAEAEColor];
                self.backgroundColorNormal = [UIColor whiteColor];
                self.backgroundColorSelected = [UIColor whiteColor];
                self.borderColorNormal = self.textColorNormal;
                self.borderColorSelected = self.textColorSelected;
                self.borderWidth = 0.5;
                self.cornerraduis = 4;
                self.itemHeight = 18.f;
                self.font = [UIFont systemFontOfSize:10.f];
                self.fontMarginVertical = -2;
                self.fontMarginHorizontal = 4;
                self.padding = UIEdgeInsetsMake(5, 2, 2, 5);
            }
                break;
            case CHKTagViewItemStyleTypeDefault:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

@end
