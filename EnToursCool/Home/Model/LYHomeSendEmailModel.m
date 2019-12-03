//
//  LYHomeSendEmailModel.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYHomeSendEmailModel.h"
#import "NSString+LYSize.h"

@implementation LYHomeSendEmailModel

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues
{
    CGFloat height = [self.subTitle.trim heightWithFont:[LYTourscoolAPPStyleManager ly_ArialRegular_15] constrainedToWidth:kScreenWidth - 32];
    
    self.height = height + 113;
}



@end
