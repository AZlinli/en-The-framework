//
//  LYHomeViewModel.h
//  ToursCool
//
//  Created by tourscool on 11/26/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYHomeSectionModel;

NS_ASSUME_NONNULL_BEGIN
@interface LYHomeViewModel : NSObject
@property (nonatomic, readonly, copy) NSArray * homeSectionArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, readonly, strong) RACCommand * homeHTTPRequestCommand;

+ (LYHomeViewModel *)sharedHomeViewModel;

@end

NS_ASSUME_NONNULL_END
