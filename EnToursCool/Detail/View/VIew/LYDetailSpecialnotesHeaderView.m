//
//  LYDetailSpecialnotesHeaderView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/28.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailSpecialnotesHeaderView.h"
#import "LYDetailSpecialnotesModel.h"

NSString * const LYDetailSpecialnotesHeaderViewID = @"LYDetailSpecialnotesHeaderViewID";

@interface LYDetailSpecialnotesHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *foldButton;
/**model*/
@property(nonatomic, strong) LYDetailSpecialnotesModel *model;
@end

@implementation LYDetailSpecialnotesHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    self.sectionTitleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.sectionTitleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    
    [self.foldButton setImage:[UIImage imageNamed:@"detail_arrow_down"] forState:0];
    [self.foldButton setImage:[UIImage imageNamed:@"detail_arrow_up"] forState:UIControlStateSelected];
    
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        if (self.userTapSpecialnotesSectionHeaderViewBlock) {
            self.userTapSpecialnotesSectionHeaderViewBlock();
        }
    }];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)dataDidChange
{
    self.model = self.data;
    self.sectionTitleLabel.text =self.model.sectionTitle;
    if (![_model.showMore boolValue]) {
        [self.foldButton setImage:[UIImage imageNamed:@"detail_arrow_down"] forState:0];
    }else{
        [self.foldButton setImage:[UIImage imageNamed:@"detail_arrow_up"] forState:0];
    }
}


@end
