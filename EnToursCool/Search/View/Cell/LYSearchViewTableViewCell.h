//
//  LYSearchViewTableViewCell.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/18.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString * _Nullable const LYSearchViewTableViewCellID;
NS_ASSUME_NONNULL_BEGIN

@protocol LYSearchViewTableViewCellDelegate <NSObject>

@required
-(void)deleteItem:(NSString *)name;

@end

@interface LYSearchViewTableViewCell : UITableViewCell
@property (nonatomic, weak) id<LYSearchViewTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
