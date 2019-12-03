//
//  LYDetailTravelerInfoViewTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailTravelerInfoViewTableViewCell.h"
#import "LYTravelerInformationModel.h"
#import <Masonry/Masonry.h>

NSString * const LYDetailTravelerInfoViewTableViewCellID = @"LYDetailTravelerInfoViewTableViewCellID";
@interface LYDetailTravelerInfoViewTableViewCell()
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *dateLabel;
@property(nonatomic, weak) UILabel *errorTipsLabel;
@property(nonatomic, weak) UIButton *selectedButton;
@end

@implementation LYDetailTravelerInfoViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *selectdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectdButton setImage:[UIImage imageNamed:@"list_fliter_unselected"] forState:UIControlStateNormal];
        [selectdButton setImage:[UIImage imageNamed:@"list_fliter_selected"] forState:UIControlStateSelected];
        [selectdButton addTarget:self action:@selector(clickSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectdButton];
        self.selected = selectdButton;
        [selectdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(25.f);
            make.top.equalTo(self.mas_top).offset(28.f);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.tintColor = [LYTourscoolAPPStyleManager ly_484848Color];
        titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(28.f);
            make.left.equalTo(selectdButton.mas_right).offset(10.f);
        }];
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.textColor = [LYTourscoolAPPStyleManager ly_A7A7A7Color];
        dateLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
        [self addSubview:dateLabel];
        self.dateLabel = dateLabel;
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(28.f);
            make.left.equalTo(titleLabel.mas_right).offset(10.f);
        }];
        
        UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [arrowButton setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        @weakify(self);
        arrowButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                if (self.editBlock) {
                    LYTravelerInformationModel *model = self.data;
                    self.editBlock(model.IDString);
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        [self addSubview:arrowButton];
        [arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(28.f);
            make.right.equalTo(self.mas_right).offset(-26.f);
        }];
        
        //line
        UIImageView *line = [[UIImageView alloc] init];
        line.image = [UIImage imageNamed:@"detail_sep_line"];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(16.f);
            make.right.equalTo(self.mas_right).offset(-16.f);
            make.height.offset(1.f);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dataDidChange{
    LYTravelerInformationModel *model = self.data;
    self.titleLabel.text = model.title;
    self.dateLabel.text = model.brithDate;
    RAC(self.selectedButton, selected) = [RACObserve(model, isSelected) takeUntil:self.rac_prepareForReuseSignal];
}

- (void)clickSelectedButton:(id)sender{
    self.selectedButton.selected = !self.selectedButton.selected;
    if (self.selectedBlock) {
        LYTravelerInformationModel *model = self.data;
        self.selectedBlock(model.IDString);
    }
}

@end
