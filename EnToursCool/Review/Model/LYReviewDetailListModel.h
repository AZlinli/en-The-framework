//
//  LYReviewDetailListModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYReviewDetailListModel : NSObject
/**<##>*/
@property(nonatomic, copy) NSString *headerUrl;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *contentText;
@property(nonatomic, strong) NSArray *imageArray;

/**<##>*/
@property(nonatomic, assign) CGFloat cellH;
@end

NS_ASSUME_NONNULL_END
