//
//  LYDetailViewModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LYDetailBaseModel;

@interface LYDetailViewModel : NSObject

/**section数组*/
@property(nonatomic, strong, readonly) NSArray *detailSectionArray;
/**section数组点击展开收起*/
@property (nonatomic, readonly, strong) RACCommand * showMoreRouteCommand;
/**Highlights点击展开收起*/
@property (nonatomic, readonly, strong) RACCommand * showMoreHighlightsCommand;
/**Pick-up Details点击展开收起*/
@property (nonatomic, readonly, strong) RACCommand * footerShowMoreCommand;
/**Special Notes数组点击展开收起*/
@property (nonatomic, readonly, strong) RACCommand * showMoreSpecialNotesCommand;
/**Expense cell点击展开收起*/
@property (nonatomic, readonly, strong) RACCommand * showMoreExpenseCommand;

/**吸顶view，button的点击*/
@property (nonatomic, readonly, strong) RACCommand * selectTypeButtonCommand;
/**当前选中吸顶view的button的tag*/
@property (nonatomic, readonly, strong) NSNumber * selectTypeButton;
/**点击topView的按钮后让didscroll代理不滚动*/
@property (nonatomic, readwrite, assign) BOOL tapButton;

/// 切换吸顶view的按钮
/// @param tag 当前按钮的tag
- (void)updateSelectTypeButtonWithTag:(NSInteger)tag;

/// 获取当前model在数组里面的位置
/// @param model detailSectionArray中的模型
- (NSInteger)obtainSectionArrayWithModel:(Class)model;
@end

NS_ASSUME_NONNULL_END
