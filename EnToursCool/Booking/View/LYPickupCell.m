//
//  LYPickupCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYPickupCell.h"
#import "EBDropdownListView.h"

NSString *const LYPickupCellID = @"LYPickupCellID";

@interface LYPickupCell()
@property (weak, nonatomic) IBOutlet UILabel *pickLabel;
@property (weak, nonatomic) IBOutlet UIView *placeView;
@property (nonatomic, strong)EBDropdownListView *dropdownListView;

@end

@implementation LYPickupCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.pickLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.pickLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_16];
    [self addPopView];
}

//添加下拉框
- (void)addPopView
{
    EBDropdownListItem *item1 = [[EBDropdownListItem alloc] initWithItem:@"0" itemName:@"06:45am Flushing，Asian Jewel SeAsian Jewel SeafoodAsian Jewel Seafoodafood Restaurant"];
                                 
    EBDropdownListItem *item2 = [[EBDropdownListItem alloc] initWithItem:@"1" itemName:@"002"];
    EBDropdownListItem *item3 = [[EBDropdownListItem alloc] initWithItem:@"2" itemName:@"jg;fjb;oogdm;otbhjdfgi;objfigdo;jgow4'tejro'grejro'ejhgoir'jgorjgro'jg ian Jewel SeafoRestauraian Jewel Sea"];

    // 弹出框向下
    EBDropdownListView *dropdownListView = [[EBDropdownListView alloc] initWithDataSource:@[item1,item2,item3]];

    dropdownListView.frame = self.placeView.bounds;
    
//    dropdownListView.selectedIndex = 0;
    dropdownListView.initailString = @"Select pick-up location";
    
    [dropdownListView setViewBorder:0.5 borderColor:[LYTourscoolAPPStyleManager ly_C7D0D9Color]  cornerRadius:4];
    [self.placeView addSubview:dropdownListView];
    
//    __weak typeof(self)weakSelf = self;
    [dropdownListView setDropdownListViewSelectedBlock:^(EBDropdownListView *dropdownListView) {
        NSString *msgString = [NSString stringWithFormat:
                               @"selected name:%@  id:%@  index:%ld"
                               , dropdownListView.selectedItem.itemName
                               , dropdownListView.selectedItem.itemId
                               , dropdownListView.selectedIndex];
//        if ([weakSelf.delegate respondsToSelector:@selector(didSelctDropDowView:atIndexPath:)])
//        {
//            [weakSelf.delegate didSelctDropDowView:dropdownListView atIndexPath:weakSelf.indexPath];
//        }
    }];
    self.dropdownListView = dropdownListView;
}


@end
