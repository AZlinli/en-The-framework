//
//  LYDetailExpenseModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/26.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,LYDetailExpenseModelItemType) {
    LYDetailExpenseModelItemPriceSpecialNote,
    LYDetailExpenseModelItemInclusions,
    LYDetailExpenseModelItemExclusions,
};

@interface LYDetailExpenseModel : LYDetailBaseModel
/**装有子cellModel的数组*/
@property(nonatomic, strong) NSArray *dataArray;

@end


@interface LYDetailExpenseModelItem : LYDetailBaseModel
/**名字*/
@property(nonatomic, copy) NSString *title;
/**item类型*/
@property(nonatomic, assign) LYDetailExpenseModelItemType type;
/**暂时存储高度*/
@property(nonatomic, strong) NSMutableDictionary *heightDict;
/**文字内容*/
@property(nonatomic, copy) NSString *text;
/**cell真正的高度*/
@property(nonatomic, assign) CGFloat highlightsCellH;

/**cell除开seeMoreButton高度的cell高度*/
@property(nonatomic, assign) CGFloat highlightsExceptSeemoreButtonCellH;

/**cell大于5行的固定高度*/
@property(nonatomic, assign) CGFloat fixationHighlightsCellH;

/**是否高度固定*/
@property(nonatomic, assign) BOOL isFixationHighlightsCellH;

/**是否显示更多*/
@property(nonatomic, assign) BOOL isShowMore;

@end

NS_ASSUME_NONNULL_END
