//
//  LYDateView.h
//  ToursCool
//
//  Created by tourscool on 12/29/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LYUserSelectDateBlock)(NSDate * _Nullable selectDate);
NS_ASSUME_NONNULL_BEGIN

@interface LYDateView : UIView
@property (nonatomic, copy) LYUserSelectDateBlock userSelectDateBlock;


- (void)customSetPicker;
@end

NS_ASSUME_NONNULL_END
