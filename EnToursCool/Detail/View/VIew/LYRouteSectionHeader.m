//
//  LYRouteSectionHeader.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYRouteSectionHeader.h"
#import "LYRouteListModel.h"

NSString * const LYRouteSectionHeaderViewID = @"LYRouteSectionHeaderViewID";

@interface LYRouteSectionHeader()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *unfoldButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;
/**model*/
@property(nonatomic, strong) LYRouteListModel *model;
@end

@implementation LYRouteSectionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_14];
    
    [self.unfoldButton setImage:[UIImage imageNamed:@"detail_arrow_down"] forState:0];
    [self.unfoldButton setImage:[UIImage imageNamed:@"detail_arrow_up"] forState:UIControlStateSelected];
    
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        if (self.userTapRouteSectionHeaderViewBlock) {
            self.userTapRouteSectionHeaderViewBlock();
        }
    }];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)dataDidChange
{
    LYRouteListModel * model = self.data;
    self.titleLabel.text = model.title;
    if (![model.showMore boolValue]) {
        [self.unfoldButton setImage:[UIImage imageNamed:@"detail_arrow_down"] forState:0];
    }else{
        [self.unfoldButton setImage:[UIImage imageNamed:@"detail_arrow_up"] forState:0];
    }
}

@end
