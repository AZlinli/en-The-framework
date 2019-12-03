//
//  LYFullPageAdvertisementModel.h
//  ToursCool
//
//  Created by tourscool on 3/26/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYFullPageAdvertisementModel : NSObject
@property (nonatomic, copy) NSString              * imageUrl;
@property (nonatomic, copy) NSString              * linkUrl;
@property (nonatomic, assign) NSInteger              showSecond;
@property (nonatomic, assign) BOOL              isActive;
@property (nonatomic, assign) BOOL              isCache;
@end

NS_ASSUME_NONNULL_END
