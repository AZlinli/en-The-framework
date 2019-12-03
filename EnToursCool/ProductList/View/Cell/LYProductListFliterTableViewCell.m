//
//  LYProductListFliterTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYProductListFliterTableViewCell.h"
#import "LYProductListFliterModel.h"

NSString * const LYProductListFliterTableViewCellID = @"LYProductListFliterTableViewCellID";


@interface LYProductListFliterTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation LYProductListFliterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectedImageView.image = [UIImage imageNamed:@"list_fliter_unselected1"];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"7f7f7f"];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size: 14];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)dataDidChange{
    LYProductListFliterModel *model = self.data;
    self.titleLabel.text = model.title;
    @weakify(self);
    [[RACObserve(model, isSelected) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (model.isSelected) {
            if (self.isOnlySelectOne) {
                self.selectedImageView.image = [UIImage imageNamed:@"list_fliter_selected1"];
            }else{
                self.selectedImageView.image = [UIImage imageNamed:@"list_fliter_selected"];
            }
        }else{
            if (self.isOnlySelectOne) {
                self.selectedImageView.image = [UIImage imageNamed:@"list_fliter_unselected1"];
            }else{
                self.selectedImageView.image = [UIImage imageNamed:@"list_fliter_unselected"];
            }
        }
    }];
    //isOnlySelectOne
}

@end
