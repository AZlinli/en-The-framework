//
//  LYEmptyCollectionHeader.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYEmptyCollectionHeader.h"

@implementation LYEmptyCollectionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNeedLigray:(BOOL)needLigray
{
    _needLigray = needLigray;
    self.backgroundColor = needLigray ? [LYTourscoolAPPStyleManager ly_F7F7F7Color] : [UIColor whiteColor];

}

@end
