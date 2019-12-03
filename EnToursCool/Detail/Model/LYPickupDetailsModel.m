//
//  LYPickupDetailsModel.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/27.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYPickupDetailsModel.h"

@implementation LYPickupDetailsModel
- (BOOL)isShowFooter {
    if (self.itemArray.count > 3) {
        return YES;
    }else{
        return NO;
    }
}

@end

@implementation LYPickupDetailsModelItem

@end
