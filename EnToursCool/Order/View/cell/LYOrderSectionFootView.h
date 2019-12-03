//
//  LYOrderSectionFootView.h
//  EnToursCool
//
//  Created by tourscool on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYOrderSectionFootRemoveBlock) (NSString * _Nullable travelID);

typedef void(^LYOrderSectionFootCancelBlock) (NSString * _Nullable travelID);
typedef void(^LYOrderSectionFootPayBlock) (NSString * _Nullable travelID);
typedef void(^LYOrderSectionFootCommentBlock) (NSString * _Nullable travelID);
typedef void(^LYOrderSectionFootFlightBlock) (NSString * _Nullable travelID);

UIKIT_EXTERN NSString * _Nullable const LYOrderSectionFootViewID;

NS_ASSUME_NONNULL_BEGIN

@interface LYOrderSectionFootView : UITableViewHeaderFooterView

@property (nonatomic, copy) LYOrderSectionFootRemoveBlock removeBlock;

@property (nonatomic, copy) LYOrderSectionFootCancelBlock cancelBlock;
@property (nonatomic, copy) LYOrderSectionFootPayBlock payBlock;
@property (nonatomic, copy) LYOrderSectionFootCommentBlock commentBlock;
@property (nonatomic, copy) LYOrderSectionFootFlightBlock flightBlock;

@end

NS_ASSUME_NONNULL_END
