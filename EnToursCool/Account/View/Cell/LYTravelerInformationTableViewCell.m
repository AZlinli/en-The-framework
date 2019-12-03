//
//  LYTravelerInformationTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYTravelerInformationTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIView+LYUtil.h"
#import "LYTravelerInformationModel.h"

NSString * const LYTravelerInformationTableViewCellID = @"LYTravelerInformationTableViewCellID";

@interface LYTravelerInformationTableViewCell()
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *dateLabel;
@end

@implementation LYTravelerInformationTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
        titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(16.f);
            make.top.equalTo(self.mas_top).offset(20.f);
        }];
       
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont fontWithName:@"Arial" size: 12];
        dateLabel.textColor = [UIColor colorWithHexString:@"A7A7A7"];
        [self addSubview:dateLabel];
        self.dateLabel = dateLabel;
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(10.f);
            make.top.equalTo(self.mas_top).offset(20.f);
        }];
        
//        UIImageView *arrowImageView = [[UIImageView alloc] init];
//        arrowImageView.image = [UIImage imageNamed:@"right_arrow"];
//        [self addSubview:arrowImageView];
//        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(20.f);
//            make.right.equalTo(self.mas_right).offset(-26.f);
//        }];
        
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
            make.top.equalTo(self.mas_top).offset(20.f);
            make.right.equalTo(self.mas_right).offset(-26.f);
        }];
        
        UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [removeButton addTarget:self action:@selector(clickRemoveButton:) forControlEvents:UIControlEventTouchUpInside];
        [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
        [removeButton setTitleColor:[UIColor colorWithHexString:@"19A8C7"] forState:UIControlStateNormal];
        removeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size: 12];
        [self addSubview:removeButton];
        [removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.mas_left).offset(16.f);
            make.top.equalTo(titleLabel.mas_bottom).offset(10.f);
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
}

- (void)clickRemoveButton:(id)sender{
    if (self.removeBlock) {
        LYTravelerInformationModel *model = self.data;
        self.removeBlock(model.IDString);
    }
}

@end
