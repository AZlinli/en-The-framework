//
//  LYCommitCommentViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCommitCommentViewModel : NSObject
@property(nonatomic, readwrite, copy) NSString *otherText;
@property(nonatomic, readwrite, copy) NSArray *imageArray;
@property(nonatomic, readwrite, copy) NSString *serviceScore;
//一日游没有下列评分
@property(nonatomic, readwrite, copy) NSString *valueForMoneyScore;
@property(nonatomic, readwrite, copy) NSString *safetyScore;
@property(nonatomic, readwrite, copy) NSString *TourGuideServiceScore;
@property(nonatomic, readwrite, copy) NSString *hotelAndRepastScore;

@property(nonatomic, readonly, strong) RACCommand *submitCommand;

- (instancetype)initWithParameter:(NSDictionary *)parameter;
@end

NS_ASSUME_NONNULL_END
