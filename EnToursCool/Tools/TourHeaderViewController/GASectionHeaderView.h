//
//  GASectionHeaderView.h
//  GAIA供应
//
//  Created by  GAIA on 2017/12/14.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GASectionHeaderViewDelegate<NSObject>

@optional

/**
 选中第几个头部

 @param indexPath 序列号
 */
- (void)didSelectHeaderViewAtIndex:(NSIndexPath *)indexPath;

@end

@interface GASectionHeaderView : UITableViewHeaderFooterView
//点中第几个sectionHeader
@property (nonatomic , strong) NSIndexPath *indexPath;
//代理
@property (nonatomic , weak) id<GASectionHeaderViewDelegate>delegate;

@end
