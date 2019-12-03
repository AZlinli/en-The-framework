//
//  LYMemberProfileViewModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/29.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMemberProfileViewModel : NSObject
@property(nonatomic, readwrite, copy) UIImage *selectedImage;
@property(nonatomic, readwrite, copy) NSString *image;
@property(nonatomic, readwrite, copy) NSString *name;
@property(nonatomic, readwrite, copy) NSString *birthDate;
@property(nonatomic, readwrite, copy) NSString *gender;

@property(nonatomic, readonly, strong) RACCommand *saveCommand;
@end

NS_ASSUME_NONNULL_END
