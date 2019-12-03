//
//  LYContactSheet.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "GAActionSheet.h"
#import "LYContactView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYContactSheet : GAActionSheet

- (instancetype)initWithContactViewWithTelephone:(TelephoneBlock)teleblock online:(OnlineBlock)onlineBlock email:(EmailBlock)emailBlock;

@end

NS_ASSUME_NONNULL_END
