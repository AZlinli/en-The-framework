//
//  EBDropCell.h
//  EnToursCool
//
//  Created by tourscool on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EBDropdownListView.h"


UIKIT_EXTERN NSString *const EBDropCellID;

NS_ASSUME_NONNULL_BEGIN

@interface EBDropCell : UITableViewCell

@property (nonatomic, strong)  EBDropdownListItem *dropItem;

@end

NS_ASSUME_NONNULL_END
