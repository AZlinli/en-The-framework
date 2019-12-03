//
//  EBDropCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "EBDropCell.h"

NSString *const EBDropCellID = @"EBDropCellID";

@interface EBDropCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLbel;


@end
@implementation EBDropCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setDropItem:(EBDropdownListItem *)dropItem
{
    _dropItem = dropItem;
    self.titleLbel.text = dropItem.itemName;
}
@end
