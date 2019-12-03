//
//  LYProductListMoreFilterTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/29.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListMoreFilterTableViewCell.h"
#import "LYProductListFliterModel.h"

NSString * const LYProductListMoreFilterTableViewCellID = @"LYProductListMoreFilterTableViewCellID";

@interface LYProductListMoreFilterTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; //3d3d3d  19A8C7
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation LYProductListMoreFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedImageView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dataDidChange{
    LYFiltrateItemModel * model = self.data;
    self.titleLabel.text = model.name;
    @weakify(self);
    [[RACObserve(model, selected) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.selectedImageView.hidden = ![x boolValue];
        if ([x boolValue]) {
            self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
        }else{
            self.titleLabel.textColor = [UIColor colorWithHexString:@"3d3d3d"];
        }
    }];
}


@end
