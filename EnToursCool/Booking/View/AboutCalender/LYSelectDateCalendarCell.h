//
//  LYSelectDateCalendarCell.h
//  ToursCool
//
//  Created by tourscool on 11/1/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <FSCalendar/FSCalendar.h>
UIKIT_EXTERN NSString * _Nullable const LYSelectDateCalendarCellID;
@class LYSelectDatePriceModel, EKEvent;
NS_ASSUME_NONNULL_BEGIN

@interface LYSelectDateCalendarCell : FSCalendarCell
/**
 日历事件
 */
@property (weak, nonatomic) UILabel *dateEventLabel;
/**
 价格
 */
@property (weak, nonatomic) UILabel *priceLabel;
/**
 选中背景
 */
@property (weak, nonatomic) CALayer *selectionLayer;

//设置价格label内容
- (void)setPriceLabelTextWithTitle:(NSString *)title;

//设置价格labe在是否选中状态下的字体颜色 type：1.选中，0：取消选中
- (void)setPriceLabelTextColorWithType:(BOOL)type;

- (void)setItemSpecial:(BOOL)type;


- (void)setPriceis:(LYSelectDatePriceModel *)selectDatePriceModel eventTitle:(EKEvent *)event;

@end

NS_ASSUME_NONNULL_END
