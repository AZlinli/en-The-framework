//
//  LYBaseModel.h
//  LYBook
//
//  Created by luoyong on 2018/9/28.
//  Copyright © 2018年 luoyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYConfigurationCellIdentifier.h"
@interface LYBaseModel : NSObject <LYConfigurationCellIdentifier>
@property (nonatomic, copy) NSString * cellReuseIdentifier;
@end
