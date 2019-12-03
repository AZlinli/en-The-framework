//
//  LYDateSelectPriceAndMonthCollectionViewCell.m
//  ToursCool
//
//  Created by tourscool on 11/2/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSelectDatePriceAndMonthCollectionViewCell.h"
#import "LYSelectDatePriceAndMonthModel.h"
NSString * const LYSelectDatePriceAndMonthCollectionViewCellID = @"LYSelectDatePriceAndMonthCollectionViewCellID";
@interface LYSelectDatePriceAndMonthCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UILabel * monthLabel;
@property (nonatomic, weak) IBOutlet UILabel * priceLabel;
@property (nonatomic, weak) IBOutlet UILabel * markLabel;
@end
@implementation LYSelectDatePriceAndMonthCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.markLabel.backgroundColor = [UIColor clearColor];
}

- (void)dataDidChange
{
    LYSelectDatePriceAndMonthModel * model = self.data;
    self.monthLabel.text = model.monthDate;
    self.priceLabel.text = model.price;
    @weakify(self);
    [[RACObserve(model, isSelected) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            self.monthLabel.textColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
            self.priceLabel.textColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
        }else{
            self.monthLabel.textColor = [LYTourscoolAPPStyleManager ly_3D3D3DColor];
            self.priceLabel.textColor = [UIColor colorWithHexString:@"5A5A5A"];
        }
        self.markLabel.hidden = ![x boolValue];
    }];
}

@end
