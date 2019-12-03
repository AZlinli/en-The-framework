//
//  LYTravelerInformationModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYTravelerInformationModel : NSObject
@property(nonatomic, copy) NSString *IDString;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *brithDate;
@property(nonatomic, copy) NSString *firstName;
@property(nonatomic, copy) NSString *lastName;
@property(nonatomic, copy) NSString *country;
@property(nonatomic, copy) NSString *passport;

@property(nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
