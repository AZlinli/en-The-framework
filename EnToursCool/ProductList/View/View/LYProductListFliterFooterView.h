//
//  LYProductListFliterFooterView.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString * _Nullable const LYProductListFliterFooterViewID;
typedef void(^LYSelectedBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface LYProductListFliterFooterView : UITableViewHeaderFooterView
@property (nonatomic, copy) LYSelectedBlock selectedBlock;
@end

NS_ASSUME_NONNULL_END


