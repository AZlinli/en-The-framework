//
//  LYAlertTableView.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/20.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LYAlertTableView;

@protocol AlertTableViewDelegate <NSObject>

//提供数据源
- (NSMutableArray*)alertTableVieDataSource;

//每一个cell的高度
- (CGFloat)alertTableView:(LYAlertTableView *)alertTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@required

/// 自定义cell
/// @param tableView tableView
/// @param indexPath indexpathx
- (UITableViewCell*)alertTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
typedef void (^SelectAlertTableViewBlock)(NSIndexPath *indexPath);

typedef void (^TapCompletionBlock)(BOOL isTap);

@interface LYAlertTableView : UIView
//AlertTableView的frame
@property (nonatomic, assign) CGRect globalFrame;
//tableView的frame
@property (nonatomic,assign)  CGRect tableViewFrame;
//点击当前AlertTableView的回调
@property (nonatomic, copy) TapCompletionBlock tapBlock;

@property (nonatomic, weak) id<AlertTableViewDelegate> delegate;
//选中cell的回调
@property (nonatomic, copy) SelectAlertTableViewBlock selectBlock;

//显示到window
- (void)show;

//显示到指定view
- (void)showInView:(UIView*)view;

//刷新数据
- (void)reloadData;

//隐藏
- (void)hidden;

@end

NS_ASSUME_NONNULL_END
